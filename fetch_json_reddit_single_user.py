import sys
from helper.fetch_reddit_user import *
from app.config import *



if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python <script>.py <username>")
        sys.exit(1)
    username = sys.argv[1]
    process_fetch(username)
