import sys
import sqlite3


def create_database(db_name:str = "database") -> None:
    query_create = """
            CREATE TABLE IF NOT EXISTS reddit_bots(
                id INTEGER,
                unnamed INTEGER,
                annotator TEXT,
                user_id TEXT,
                was_fetched INTEGER,
                is_duplicate INTEGER,
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
                PRIMARY KEY(unnamed, user_id)
                );
            """

    connection = sqlite3.connect(f"database/{db_name}.db")
    cursor = connection.cursor()
    cursor.execute(query_create)
    connection.commit()
    cursor.close()
    connection.close()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        create_database(sys.argv[1])
    create_database()
    
