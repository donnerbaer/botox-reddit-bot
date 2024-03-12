import sys
import requests
import json
import os
import random
import time
from datetime import datetime
from app import config, database


try:
    config = config.Config().get_config()
except:
    print("ERROR: helper.fetch_reddit_user.py: pronlem with config.ini")
    os._exit(0)

try:
    __db = database.Database()
    __connection = __db.get_connection()
    __cursor = __db.get_cursor()
except:
    print("ERROR: helper.fetch_reddit_user.py: pronlem with config.ini")
    os._exit(0)


ALLOW_FETCH_FULL_JSON = config['FETCHING.REDDIT']['ALLOW_FETCH_FULL_JSON']
ALLOW_SAVE_JSON_FROM_BANNED_ACCOUNTS = config['FETCHING.REDDIT']['ALLOW_SAVE_JSON_FROM_BANNED_ACCOUNTS']



def format_timestamp(timestamp:str|int ) -> str|None:
    """_summary_

    Args:
        timestamp (str | int): _description_

    Returns:
        str|None: _description_
    """
    try:
        return datetime.fromtimestamp(timestamp).strftime('%Y-%m-%d %H:%M:%S UTC')
    except:
        return None



def fetch_user_metadata(username:str) -> dict|str:
    """_summary_

    Args:
        username (str): _description_

    Returns:
        dict|str: _description_
    """
    # Reddit API endpoint for user information
    user_url = f"https://www.reddit.com/user/{username}/about.json"
    # Reddit API endpoint for user's recent posts
    posts_url = f"https://www.reddit.com/user/{username}/submitted.json"
    # Reddit API endpoint for user's recent comments
    comments_url = f"https://www.reddit.com/user/{username}/comments.json"
    
    # Send GET request to fetch user information
    user_response = requests.get(user_url, headers={"User-Agent": "YOUR_APP_NAME"})
    
    # Check if the request was successful
    if user_response.status_code == 200:
        # Parse JSON response for user information
        
        if ALLOW_FETCH_FULL_JSON == 'yes':
            user_metadata = user_response.json()
        else: 
        # Extract relevant user metadata
            user_data = user_response.json()['data']
            created_utc = format_timestamp(user_data.get('created_utc'))
            user_metadata = {
                'username': user_data.get('name'),
                'created_utc': created_utc,
                'comment_karma': user_data.get('comment_karma'),
                'link_karma': user_data.get('link_karma'),
                'is_gold': user_data.get('is_gold'),
                'is_mod': user_data.get('is_mod'),
                'is_employee': user_data.get('is_employee'),
                'has_verified_email': user_data.get('has_verified_email'),
                'is_suspended': user_data.get('is_suspended')
            }
        

        # Send GET request to fetch user's recent posts
        posts_response = requests.get(posts_url, headers={"User-Agent": "YOUR_APP_NAME"})
        # Parse JSON response for user's recent posts
        if posts_response.status_code == 200:
                  
            if ALLOW_FETCH_FULL_JSON == 'yes':
                recent_posts_metadata = posts_response.json()
            else: 
                posts_data = posts_response.json()['data']['children']
                recent_posts_metadata = []
                for post in posts_data:
                    post_data = post.get('data')
                    created_utc = format_timestamp(post_data.get('created_utc'))

                    post_metadata = {
                        'title': post_data.get('title'),
                        'created_utc': created_utc,
                        'permalink': post_data.get('permalink'),
                        'num_comments': post_data.get('num_comments'),
                        'score': post_data.get('score'),
                        'subreddit': post_data.get('subreddit'),
                        'is_self': post_data.get('is_self'),
                        'domain': post_data.get('domain')
                    }
                    recent_posts_metadata.append(post_metadata)

            user_metadata['recent_posts'] = recent_posts_metadata
        
        # Send GET request to fetch user's recent comments
        comments_response = requests.get(comments_url, headers={"User-Agent": "YOUR_APP_NAME"})
        # Parse JSON response for user's recent comments
        if comments_response.status_code == 200:
            if ALLOW_FETCH_FULL_JSON == 'yes':
                recent_comments_metadata = comments_response.json()
            else: 

                comments_data = comments_response.json()['data']['children']
                # Extract metadata of recent comments
                recent_comments_metadata = []
                for comment in comments_data:
                    comment_data = comment.get('data')
                    created_utc = format_timestamp(comment_data.get('created_utc'))
                
                    comment_metadata = {
                        'body': comment_data.get('body'),
                        'created_utc': created_utc,
                        'link_id': comment_data.get('link_id'),
                        'score': comment_data.get('score'),
                        'subreddit': comment_data.get('subreddit'),
                        'permalink': comment_data.get('permalink')
                    }
                    recent_comments_metadata.append(comment_metadata)

            user_metadata['recent_comments'] = recent_comments_metadata

        return user_metadata
    else:
        return f'ERROR {user_response.status_code}'
        


def save_metadata_to_json(username:int, user_metadata: dict) -> bool:
    """_summary_

    Args:
        username (int): _description_
        user_metadata (dict): _description_

    Returns:
        bool: _description_
    """
    try:
        filename = f"./json/{username}.json"
        with open(filename, 'w') as f:
            json.dump(user_metadata, f, indent=4)
        print(f"Metadata saved to {filename}")
        return True
    except:
        print("Failed to fetch metadata, cannot save to file.")
        return False



def process_fetch(username:str) -> None:
    """ processing the fetching for fetch and save the json
    """
    

    time_sleep = (random.random() * 4) + 1
    print(f'Pausing for: {time_sleep} sec')
    time.sleep(time_sleep)

    user_metadata = fetch_user_metadata(username)
    if isinstance(user_metadata, str):
        if user_metadata.startswith('ERROR 404'):
                print(f"{user_metadata} {username} user does not exists")
                query_update = """ UPDATE reddit_bots SET was_fetched = 0, is_deleted = 1, is_banned = 0  WHERE user_id = ?"""

    elif isinstance(user_metadata, dict):
        if user_metadata.get('is_suspended') == True:
            print(f"User {username} is suspended")
            if ALLOW_SAVE_JSON_FROM_BANNED_ACCOUNTS == 'yes':
                query_update = """ UPDATE reddit_bots SET was_fetched = 1, is_deleted = 0, is_banned = 1 WHERE user_id = ?"""
            else:
                query_update = """ UPDATE reddit_bots SET was_fetched = 0, is_deleted = 0, is_banned = 1 WHERE user_id = ?"""

        else:
            save_json_status = save_metadata_to_json(username, user_metadata)
            print(f'Save {username}.json: {save_json_status}')
            query_update = """ UPDATE reddit_bots SET was_fetched = 1, is_deleted = 0, is_banned = 0 WHERE user_id = ?"""

    else:
        print("Can\'t save")

    __cursor.execute(query_update,(username,))
    __connection.commit()
    print()

