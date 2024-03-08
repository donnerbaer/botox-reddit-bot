import sys
import requests
import json
from datetime import datetime

def format_timestamp(timestamp):
    return datetime.utcfromtimestamp(timestamp).strftime('%Y-%m-%d %H:%M:%S UTC')

def fetch_user_metadata(username):
    status_code = []
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
        user_data = user_response.json()['data']
        

        user_metadata_created_utc = None
        if user_data.get('created_utc') is not None:
            user_metadata_created_utc = format_timestamp(user_data.get('created_utc'))

        user_metadata = {
            'username': user_data.get('name'),
            'created_utc': user_metadata_created_utc,
            'comment_karma': user_data.get('comment_karma'),
            'link_karma': user_data.get('link_karma'),
            'is_gold': user_data.get('is_gold'),
            'is_mod': user_data.get('is_mod'),
            'has_verified_email': user_data.get('has_verified_email')
        }
        
        # Send GET request to fetch user's recent posts
        posts_response = requests.get(posts_url, headers={"User-Agent": "YOUR_APP_NAME"})
        # Parse JSON response for user's recent posts
        if posts_response.status_code == 200:
            posts_data = posts_response.json()['data']['children']
            # Extract metadata of recent posts
            recent_posts_metadata = []
            for post in posts_data:

                post_metadata_created_utc = None
                print(post['data'].get('created_utc'))
                if post['data'].get('created_utc') is not None:
                    post_metadata_created_utc = format_timestamp(post['data'].get('created_utc'))

                post_metadata = {
                    'title': post['data'].get('title'),
                    'created_utc': post_metadata_created_utc,
                    'permalink': post['data'].get('permalink'),
                    'num_comments': post['data'].get('num_comments'),
                    'score': post['data'].get('score'),
                    'subreddit': post['data'].get('subreddit'),
                    'is_self': post['data'].get('is_self'),
                    'domain': post['data'].get('domain')
                }
                recent_posts_metadata.append(post_metadata)
            user_metadata['recent_posts'] = recent_posts_metadata
        else:
            status_code.append(posts_response.status_code)
        
        # Send GET request to fetch user's recent comments
        comments_response = requests.get(comments_url, headers={"User-Agent": "YOUR_APP_NAME"})
        # Parse JSON response for user's recent comments
        if comments_response.status_code == 200:
            comments_data = comments_response.json()['data']['children']
            # Extract metadata of recent comments
            recent_comments_metadata = []
            for comment in comments_data:

                comment_metadata_created_utc = None
                if comment['data'].get('created_utc') is not None:
                    comment_metadata_created_utc = format_timestamp(comment['data'].get('created_utc'))

                comment_metadata = {
                    'body': comment['data'].get('body'),
                    'created_utc': comment_metadata_created_utc,
                    'link_id': comment['data'].get('link_id'),
                    'score': comment['data'].get('score'),
                    'subreddit': comment['data'].get('subreddit'),
                    'permalink': comment['data'].get('permalink')
                }
                recent_comments_metadata.append(comment_metadata)
            user_metadata['recent_comments'] = recent_comments_metadata
        else:
            status_code.append(comments_response.status_code)
        
        return user_metadata
    else:
        return -1



def save_metadata_to_json(username, user_metadata):
    if user_metadata:
        filename = f"./json/{username}.json"
        with open(filename, 'w') as f:
            json.dump(user_metadata, f, indent=4)
        return True
    else:
        return False


