import configparser
import os



class Config:
    """ This class will handle the config file / configparser
    """


    def __init__(self, config_file:str = './config.ini') -> None:
        """_summary_
        """
        try:
            self.__config = configparser.ConfigParser()
            self.__config.read(config_file)
            
        except:
            print("ERROR: no config.ini")
            print(config_file)
            os._exit(1)


    def get_config(self) -> configparser.ConfigParser:
        """_summary_

        Returns:
            configparser.ConfigParser: _description_
        """
        return self.__config