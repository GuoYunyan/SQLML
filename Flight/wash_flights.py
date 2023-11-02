import pandas as pd
import numpy as np

df = pd.read_csv('flights.csv')

print(df.shape)

def convert_time(x):
    x_str = str(int(x)).zfill(4) 
    return int(x_str[:2]) * 60 + int(x_str[2:]) 

columns_to_drop = ['CANCELLATION_REASON', 'AIR_SYSTEM_DELAY', 'SECURITY_DELAY', 
                   'AIRLINE_DELAY', 'LATE_AIRCRAFT_DELAY', 'WEATHER_DELAY']
df = df.drop(columns=columns_to_drop)
df = df.dropna()

df['IS_DELAYED'] = (df['ARRIVAL_DELAY'] > 0).astype(int)

time_cols = ['SCHEDULED_DEPARTURE', 'DEPARTURE_TIME', 'WHEELS_OFF', 'WHEELS_ON', 
             'SCHEDULED_ARRIVAL', 'ARRIVAL_TIME']
df = df.dropna(subset=time_cols)

for col in time_cols:
    df[col] = df[col].apply(convert_time)



df = df[~df.isin([np.inf, -np.inf]).any(1)]

float_cols = df.select_dtypes(include=['float64']).columns
df[float_cols] = df[float_cols].astype(int)

df = df[df['ORIGIN_AIRPORT'].str.len() == 3]
df = df[df['DESTINATION_AIRPORT'].str.len() == 3]

df.to_csv('flights.csv', index=False)
print('Done!')