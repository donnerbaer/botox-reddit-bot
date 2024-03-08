
-- SELECT number of not annotated accounts
SELECT COUNT(reddit_bots.user_id) FROM reddit_bots WHERE annotator IS NULL;

-- SELECT number of annotated accounts of user ?
SELECT COUNT(reddit_bots.user_id) FROM reddit_bots WHERE annotator = "";

