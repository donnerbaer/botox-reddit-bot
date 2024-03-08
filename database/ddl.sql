CREATE TABLE IF NOT EXISTS reddit_bots(
    annotator TEXT,
    user_id TEXT,
    was_fetched INTEGER,
    is_deleted INTEGER,
    is_banned INTEGER,
    human INTEGER,
    bot INTEGER,
    like INTEGER,
    repost INTEGER,
    derived_content INTEGER,
    repeated_posts INTEGER,
    fluent_content INTEGER,
    active_inactivity_period INTEGER,
    high_frequency_activity INTEGER,
    note TEXT,
    PRIMARY KEY(annotator, user_id)
);


CREATE TABLE IF NOT EXISTS system(
    id INTEGER,
    key TEXT,
    value TEXT,
    PRIMARY KEY(id)
);