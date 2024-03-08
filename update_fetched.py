
import sqlite3
import configparser
import os

query_update = """ UPDATE reddit_bots SET was_fetched = 1 WHERE user_id = ? """

config = configparser.ConfigParser()
config.read('config.ini')
connection = sqlite3.connect(config['DATABASE']['FILE'])
cursor = connection.cursor()

json_files = os.listdir('json')

for user in json_files:
    user = (user.replace(".json",''))
    cursor.execute(query_update, (user ,))
    connection.commit()

cursor.close()
connection.close()