
import sqlite3
import configparser
from helper.fetch_user import *

select_query = """ SELECT DISTINCT user_id FROM reddit_bots """

config = configparser.ConfigParser()
config.read('config.ini')
connection = sqlite3.connect(config['DATABASE']['FILE'])
cursor = connection.cursor()

data = cursor.execute(select_query).fetchall()


for username in data:
    username = username[0]
    user_metadata = fetch_user_metadata(username)
    if user_metadata == 0:
        continue
    save_metadata_to_json(username, user_metadata)
    print(f'fetched {username}')

