import logging
import os
import traceback
from warnings import filterwarnings

import pymysql

from ClassProtocolEF3 import parserEF3
from ClassTypeProtocols import TypeProtocols
from utils_functions import logging_parser
from var_execution import LOG_DIR, file_log

if __name__ == "__main__":
    print('Hello, this file is only for importing!')

if not os.path.exists(LOG_DIR):
    os.mkdir(LOG_DIR)
filterwarnings('ignore', category=pymysql.Warning)
logging.basicConfig(level=logging.DEBUG, filename=file_log,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')


def parser(doc, path_xml, filexml, reg, type_f):
    try:

        if type_f == TypeProtocols.type_Deviation:
            parserEF3(doc, path_xml, filexml, reg, type_f)

    except Exception as e:
        logging_parser("Error in function parser", e, path_xml, type_f)
        traceback.print_tb(e.__traceback__)
