import pymysql

if __name__ == "__main__":
    print('Hello, this file is only for importing!')


def connect_bd(baza):
    con = pymysql.connect(host="localhost", port=3306, user="root", passwd="1234", db=baza, charset='utf8',
                          init_command='SET NAMES UTF8', cursorclass=pymysql.cursors.DictCursor, autocommit=True)
    return con
