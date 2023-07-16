# The guide to run IMDB testset

Query set source: https://github.com/gregrahn/join-order-benchmark

IMDB dataset: https://drive.google.com/file/d/1uuSJh_7MqxKUEOm2d93rShxkngbTTTXN/view?usp=sharing

## Step1: Unzip the imdb data file

```shell
tar -xvf imdb.tar -C ~/imdb_data
```

## Step2: Create the schema 

Enter psql and clip `schematext.sql` into it.

## Step3: Load data

Use the following sql code to load data, here we assume data is in `~/imdb_data`.

```sql
delete from aka_name;
delete from aka_title;
delete from cast_info;
delete from char_name;
delete from comp_cast_type;
delete from company_name;
delete from company_type;
delete from complete_cast;
delete from info_type;
delete from keyword;
delete from kind_type;
delete from link_type;
delete from movie_companies;
delete from movie_info;
delete from movie_info_idx;
delete from movie_keyword;
delete from movie_link;
delete from name;
delete from person_info;
delete from role_type;
delete from title;

\copy aka_name from '~/imdb_data/aka_name.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy aka_title from '~/imdb_data/aka_title.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy cast_info from '~/imdb_data/cast_info.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy char_name from '~/imdb_data/char_name.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy comp_cast_type from '~/imdb_data/comp_cast_type.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy company_name from '~/imdb_data/company_name.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy company_type from '~/imdb_data/company_type.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy complete_cast from '~/imdb_data/complete_cast.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy info_type from '~/imdb_data/info_type.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy keyword from '~/imdb_data/keyword.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy kind_type from '~/imdb_data/kind_type.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy link_type from '~/imdb_data/link_type.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy movie_companies from '~/imdb_data/movie_companies.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy movie_info from '~/imdb_data/movie_info.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy movie_info_idx from '~/imdb_data/movie_info_idx.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy movie_keyword from '~/imdb_data/movie_keyword.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy movie_link from '~/imdb_data/movie_link.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy name from '~/imdb_data/name.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy person_info from '~/imdb_data/person_info.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy role_type from '~/imdb_data/role_type.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
\copy title from '~/imdb_data/title.csv' with (FORMAT csv, escape '\', quote '"')
                                                     
ALTER TABLE title ALTER COLUMN production_year TYPE NUMERIC;
ANALYZE title;
```

## Step4: Create other table



### Step4.1: mi_votes

```sql
drop table mi_votes;
select mi_v.id, mi_v.movie_id as movie_id, 
			 to_number(mi_v.info, '99999999999999') as votes, 
			 mi_d.info as votes_distribution, 
			 mi_r.info as rating
into mi_votes
from movie_info_idx as mi_v, movie_info_idx as mi_d, movie_info_idx as mi_r
where mi_v.info_type_id = 100
  and mi_d.info_type_id = 99
  and mi_r.info_type_id = 101
  and mi_v.movie_id = mi_d.movie_id
  and mi_r.movie_id = mi_d.movie_id;

create index movie_id_votes on mi_votes(movie_id);

select count(distinct(movie_id)) from mi_votes;
```

### Step4.2: mi_budget

```sql
drop table mi_budget;
select mi_b.id, mi_b.movie_id as movie_id,
			 to_number(substring(mi_b.info, position('$' in mi_b.info)+1), '999999999999999') as budget
into mi_budget
from movie_info as mi_b
where mi_b.info_type_id = 105
  and mi_b.info LIKE '%$%';

create index movie_id_budget on mi_budget(movie_id);
```

### Step4.3: mi_gross

```sql
drop table mi_gross;
select mi_g.id, mi_g.movie_id as movie_id,
       to_number(substring(mi_g.info, position('$' in mi_g.info)+1), '9999999999999999') as gross
into mi_gross
from movie_info as mi_g
where mi_g.info_type_id = 107
  and mi_g.info LIKE '%$%';

create index movie_id_gross on mi_gross(movie_id);
```







## Step5:  Create foreign key index

```sql
create index company_id_movie_companies on movie_companies(company_id);
create index company_type_id_movie_companies on movie_companies(company_type_id);
create index info_type_id_movie_info_idx on movie_info_idx(info_type_id);
create index info_type_id_movie_info on movie_info(info_type_id);
create index info_type_id_person_info on person_info(info_type_id);
create index keyword_id_movie_keyword on movie_keyword(keyword_id);
create index kind_id_aka_title on aka_title(kind_id);
create index kind_id_title on title(kind_id);
create index linked_movie_id_movie_link on movie_link(linked_movie_id);
create index link_type_id_movie_link on movie_link(link_type_id);
create index movie_id_aka_title on aka_title(movie_id);
create index movie_id_cast_info on cast_info(movie_id);
create index movie_id_complete_cast on complete_cast(movie_id);
create index movie_id_movie_companies on movie_companies(movie_id);
create index movie_id_movie_info_idx on movie_info_idx(movie_id);
create index movie_id_movie_keyword on movie_keyword(movie_id);
create index movie_id_movie_link on movie_link(movie_id);
create index movie_id_movie_info on movie_info(movie_id);
create index person_id_aka_name on aka_name(person_id);
create index person_id_cast_info on cast_info(person_id);
create index person_id_person_info on person_info(person_id);
create index person_role_id_cast_info on cast_info(person_role_id);
create index role_id_cast_info on cast_info(role_id);
```



## Step6: execute the query set

we've given a python script as example to execute the entire query set, but possibly it needs to be modified to fit in other envionments.
