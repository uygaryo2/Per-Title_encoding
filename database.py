import pandas as pd
import mysql.connector

def connect_to_db():
    db = mysql.connector.connect(host='localhost',
                                user='root',
                                password='8526252s',
                                database='awt',
                                auth_plugin='mysql_native_password')
    return db


def query_db(table):
    db = connect_to_db()
    mycursor = db.cursor()
    mycursor.execute(f'SELECT * FROM {table}')
    result = mycursor.fetchall()


    mycursor.execute(f'SHOW COLUMNS FROM {table}')
    column_header = mycursor.fetchall()
    column_names = list()
    for column in column_header:
        column_name = column[0]
        column_names.append(column_name)

    result_df = pd.DataFrame(data=result, columns=column_names)
    db.close()
    return result_df

for table in ['clip', 'encode', 'label', 'scene_change']:
    df = query_db(table=table)
    df.to_csv(f'./data/{table}.csv')
    del df