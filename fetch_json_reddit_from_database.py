import os
import sys
from helper.fetch_reddit_user import *
from app.config import *
from app.database import *


select_query = """ SELECT DISTINCT user_id FROM reddit_bots"""


try:
    config = Config().get_config()
except:
    print("ERROR: helper.fetch_reddit_user.py: problem with config.ini")
    os._exit(0)

try:
    __db = Database()
    __cursor = __db.get_cursor()
except:
    print("ERROR: helper.fetch_reddit_user.py: problem with config.ini")
    os._exit(0)



usernames = __cursor.execute(select_query).fetchall()
for username in usernames:
    username = username[0]
    print(username)
    process_fetch(username)


try:
    __db.close()
except:
    os._exit(0)

os._exit(0)