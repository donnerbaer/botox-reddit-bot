import sqlite3
import os
from app.config import Config

class Database:
    """ This class will handle the database. Like connection, cursor and type of database like sqlite3 ...
    """

    def __init__(self) -> None:
        """_summary_
        """

        try:
            self.__config = Config().get_config()
        except:
            print("Database: problem with the config-file")
            os._exit(0)

        try:
            self.__database_type = self.__config['DATABASE']['DATABASE_TYPE'].strip()
        except:
            print("Database: problem with the DATABASE_TYPE")
            os._exit(0)

        self.__database(self.__database_type)
        



    def __database(self, database_type:str) -> None:
        """_summary_

        Args:
            database_type (str): _description_
        """
        
        if database_type == "sqlite":
            self.__connection = sqlite3.connect(self.__config['DATABASE']['FILE'])
            self.__cursor = self.__connection.cursor()

        else:
            print("Not supported database")
            os._exit(0)


    def get_cursor(self):
        """_summary_
        """
        return self.__cursor


    def get_connection(self):
        """_summary_
        """
        return self.__connection


    def close(self) -> None:
        """_summary_
        """
        try:
            self.__cursor.close()
            self.__connection.close()
        except:
            print("Database: problem with closing the database connection/cursor")