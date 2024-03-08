import sys
import sqlite3
import configparser


def create_database(db_name:str = "database") -> None:
    file = open(config['DATABASE']['DDL'], encoding='utf-8')
    query_create = file.read()
    cursor.executescript(query_create)
    connection.commit()


def insert_system_information() -> None:
    values = ("database version",config['SYSTEM']['VERSION'])
    query = f""" INSERT INTO system (id, key, value) 
            VALUES(1, ?, ?)
            ;
            """
    cursor.execute(query,(values))
    connection.commit()



if __name__ == '__main__':

    config = configparser.ConfigParser()
    config.read('config.ini')
    connection = sqlite3.connect(config['DATABASE']['FILE'])
    cursor = connection.cursor()


    create_database()
    insert_system_information()


    cursor.close()
    connection.close()
