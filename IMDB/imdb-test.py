import os
import shutil
import psycopg2

current_file_path = os.path.abspath(__file__)
current_directory = os.path.dirname(current_file_path)
print(current_directory) # /home/postgres/my-imdb


pg_path = '/opt/pg0/'
conf_path = pg_path + 'data/postgresql.conf'
restart_command = 'pg_ctl -D ' + pg_path + 'data restart > /dev/null 2>&1'

source_file = os.path.join(os.getcwd(), 'imdb.conf')
backup_path = conf_path + '.bak'
shutil.copy(conf_path, backup_path)
shutil.copy(source_file, conf_path)

configures = [
    # {
    #    '_id': '00', 
    #    '_base': current_directory + '/pg_result_00/', 
    #    '_mqsql_set' : current_directory + '/queryset_progressive',
	#    '_active': True,	
    #    'enable_physicml'  : 'off',
    #    'physicml_pushdown': 'off',
    #    'physicml_greedy'  : 'off',
    #    'physicml_dynamic' : 'off'
    # },
    # {
    #    '_id': '01', 
    #    '_base': current_directory + '/pg_result_01/', 
    #    '_mqsql_set' : current_directory + '/queryset_progressive',
    #    '_active': True,
    #    'enable_logicml'   : 'off',
    #    'enable_physicml'  : 'on',
    #    'physicml_pushdown': 'on',
    #    'physicml_greedy'  : 'off',
    #    'physicml_dynamic' : 'off'
    # },
    # {
    #    '_id': '10', 
    #    '_base': current_directory + '/pg_result_10/', 
    #    '_mqsql_set' : current_directory + '/queryset_progressive',
    #    '_active': True,
    #    'enable_logicml'   : 'on',
    #    'enable_physicml'  : 'off',
    #    'physicml_pushdown': 'off',
    #    'physicml_greedy'  : 'off',
    #    'physicml_dynamic' : 'off'
    # },
    # {
    #     '_id': '11', 
    #     '_base': current_directory + '/pg_result_11/', 
    #     '_mqsql_set' : current_directory + '/queryset_progressive',
    #     '_active': True,
    #     'enable_logicml'   : 'on',
    #     'enable_physicml'  : 'on',
    #     'physicml_pushdown': 'on',
    #     'physicml_greedy'  : 'off',
    #     'physicml_dynamic' : 'off'
    # },
    # {
    #     '_id': '15', 
    #     '_base': current_directory + '/pg_result_15/', 
    #     '_mqsql_set' : current_directory + '/queryset_dynamic',
    #     '_active': True,
    #     'enable_logicml'   : 'on',
    #     'enable_physicml'  : 'on',
    #     'physicml_pushdown': 'off',
    #     'physicml_greedy'  : 'off',
    #     'physicml_dynamic' : 'on'
    # },
]

def getnum(s:str) -> int:
    a1 = s.find('_')
    a2 = s.find('.')
    return int(s[a1 + 1: a2 - 1])

def getalpha(s:str):
    a2 = s.find('.')
    return s[a2 - 1: a2]

_, __, files = os.walk(current_directory + '/queryset_progressive').__next__()

if ".DS_Store" in files:
    files.remove(".DS_Store")

files.sort(key = lambda x: (getnum(x), getalpha(x)))

for configure in configures:

    if not configure['_active']:
        continue

    # 修改配置文件
    with open(conf_path, "r") as f:
        lines = f.readlines()
        
    for (i, line) in enumerate(lines):
        if '#' in line or '=' not in line: continue
        key = line.split('=')[0].strip()
        if key in configure.keys():
            lines[i] = f"{key} = {configure[key]}\n"
        
    with open(conf_path, "w") as f:
        f.writelines(lines)
    
    f.close()

    # store postgresql.conf
    d0 = configure['_base']

    # create directory
    if not os.path.exists(d0): 
        os.makedirs(d0, exist_ok=True)
    
    shutil.copy(conf_path, d0 + '/')

    # restart PG
    os.system(restart_command)
    conn = psycopg2.connect("dbname=test-imdb user=postgres password=yourpasswd host=127.0.0.1 port=5432")

    for filename in files:
        if filename[-4:] != '.sql': continue

        # obtain testing data
        with open(configure['_mqsql_set'] + '/' + filename, "r") as f:
            query = ''.join(f.readlines())

        # execute
        for rnd in range(1):
            d = configure['_base'] + str(rnd)

            # create directory
            if not os.path.exists(d): 
                os.makedirs(d, exist_ok=True)

            print(configure['_id'], filename, rnd)
            # obtain CURSOR
            cur = conn.cursor()
            cur.execute(query)
            records = cur.fetchall()
            res_txt = [tup[0] + '\n' for tup in records]
            cur.close()
            conn.commit()

            with open(d + '/' + filename[:-4] + '_res.txt', "w") as f:
                f.writelines(res_txt)
   		 
    conn.close()

print("finished")