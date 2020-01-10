import ftplib
import logging
import os
import shutil
import sys
import zipfile

import timeout_decorator
import xmltodict

import ClassProtocolEF3
import ClassTypeProtocols
import parser_prot as parser_protocol
import utils_functions as UtilsFunctions
import var_execution
from connect_to_db import connect_bd

PREFIX = var_execution.PREFIX
DB = var_execution.DB
TEMP_DIR = var_execution.TEMP_DIR
LOG_DIR = var_execution.LOG_DIR
file_log = var_execution.file_log
logging.basicConfig(level=logging.DEBUG, filename=file_log,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
except_file = ()

logging_parser = UtilsFunctions.logging_parser


def get_xml_to_dict(filexml, dirxml, region, type_f):
    try:
        # UtilsFunctions.unic(filexml, dirxml)
        pass
    except Exception as ex1:
        logging.exception("Error in file copy: ")
        with open(file_log, 'a') as flog9:
            flog9.write('Error in file copy {0} {1}\n\n\n'.format(str(ex1), filexml))
    path_xml = dirxml + '/' + filexml
    with open(path_xml) as fd:
        try:
            firs_str = fd.read()
            if True:
                firs_str = firs_str.replace("xmlns:ns1", "xmlnsns1").replace("xmlns:ns2", "xmlnsns2").replace(
                        "xmlns:ns3", "xmlnsns3").replace("xmlns:ns4", "xmlnsns4") \
                    .replace("xmlns:ns5", "xmlnsns5").replace("xmlns:ns6", "xmlnsns6").replace("xmlns:ns7",
                                                                                               "xmlnsns7").replace(
                        "xmlns:ns8", "xmlnsns8")
                firs_str = firs_str.replace("ns1:", "").replace("ns2:", "").replace("ns3:", "").replace("ns4:", "") \
                    .replace("ns5:", "").replace("ns6:", "").replace("ns7:", "").replace("ns8:", "")
            doc = xmltodict.parse(firs_str)
            parser_protocol.parser(doc, path_xml, filexml, region, type_f)

        except Exception as ex:
            logging.exception("Error: ")
            with open(file_log, 'a') as flog:
                flog.write("Error transforming to dict " + str(ex) + ' ' + path_xml + '\n\n\n')


def bolter(file, l_dir, region, type_f):
    file_lower = file.lower()
    if not file_lower.endswith('.xml'):
        return
    for g in except_file:
        if file_lower.find(g.lower()) != -1:
            return
    try:
        get_xml_to_dict(file, l_dir, region, type_f)
    except Exception as exppars:
        logging.exception("Error: ")
        with open(file_log, 'a') as flog:
            flog.write(f'Error parse file {str(exppars)} {file}\n')


def get_list_ftp_curr(path_parse, region):
    host = 'ftp.zakupki.gov.ru'
    ftpuser = 'free'
    password = 'free'
    ftp2 = ftplib.FTP(host)
    ftp2.set_debuglevel(0)
    ftp2.encoding = 'utf8'
    ftp2.login(ftpuser, password)
    ftp2.cwd(path_parse)
    data = ftp2.nlst()
    array_ar = []
    con_arhiv = connect_bd(DB)
    cur_arhiv = con_arhiv.cursor()
    for i in data:
        if i.find('2016') != -1 or i.find('2017') != -1 or i.find('2018') != -1 or i.find('2019') != -1 or i.find(
                '2020') != -1 or i.find(
                '2021') != -1 or i.find(
                '2022') != -1 or i.find(
                '2023') != -1:
            cur_arhiv.execute(f"""SELECT id FROM {PREFIX}arhiv_prot WHERE arhiv = %s AND region = %s""",
                              (i, region))
            find_file = cur_arhiv.fetchone()
            if find_file:
                continue
            else:
                array_ar.append(i)
                query_ar = f"""INSERT INTO {PREFIX}arhiv_prot SET arhiv = %s, region = %s"""
                query_par = (i, region)
                cur_arhiv.execute(query_ar, query_par)
    cur_arhiv.close()
    con_arhiv.close()
    return array_ar


def get_list_ftp_prev(path_parse, region):
    host = 'ftp.zakupki.gov.ru'
    ftpuser = 'free'
    password = 'free'
    ftp2 = ftplib.FTP(host)
    ftp2.set_debuglevel(0)
    ftp2.encoding = 'utf8'
    ftp2.login(ftpuser, password)
    ftp2.cwd(path_parse)
    data = ftp2.nlst()
    array_ar = []
    con_arhiv = connect_bd(DB)
    cur_arhiv = con_arhiv.cursor()
    for i in data:
        i_prev = "prev_{0}".format(i)
        if True:
            cur_arhiv.execute(f"""SELECT id FROM {PREFIX}arhiv_prot WHERE arhiv = %s AND region = %s""",
                              (i_prev, region))
            find_file = cur_arhiv.fetchone()
            if find_file:
                continue
            else:
                array_ar.append(i)
                query_ar = f"""INSERT INTO {PREFIX}arhiv_prot SET arhiv = %s, region = %s"""
                query_par = (i_prev, region)
                cur_arhiv.execute(query_ar, query_par)
    cur_arhiv.close()
    con_arhiv.close()
    return array_ar


def get_list_ftp_last(path_parse):
    host = 'ftp.zakupki.gov.ru'
    ftpuser = 'free'
    password = 'free'
    ftp2 = ftplib.FTP(host)
    ftp2.set_debuglevel(0)
    ftp2.encoding = 'utf8'
    ftp2.login(ftpuser, password)
    ftp2.cwd(path_parse)
    data = ftp2.nlst()
    array_ar = []
    for i in data:
        if i.find('2016') != -1 or i.find('2017') != -1 or i.find('2018') != -1 or i.find('2019') != -1 or i.find(
                '2020') != -1 or i.find(
                '2021') != -1 or i.find(
                '2022') != -1 or i.find(
                '2023') != -1:
            array_ar.append(i)

    return array_ar


def extract_prot(m, path_parse1, region):
    global need_file
    l = get_ar(m, path_parse1)
    if l:
        r_ind = l.rindex('.')
        l_dir = l[:r_ind]
        os.mkdir(l_dir)
        try:
            z = zipfile.ZipFile(l, 'r')
            z.extractall(l_dir)
            z.close()
        except UnicodeDecodeError as ea:
            with open(file_log, 'a') as floga:
                floga.write(f'Error extract archive UnicodeDecodeError {str(ea)} {l}\n')
            try:
                os.system('unzip %s -d %s' % (l, l_dir))
                logging_parser("The archive has been extracted alternate methods", l)
            except Exception as ear:
                with open(file_log, 'a') as flogb:
                    flogb.write(f'Error extracting alternate method {str(ear)} {l}\n')
                return
        except Exception as e:
            logging.exception("Error: ")
            with open(file_log, 'a') as flogc:
                flogc.write(f'Error extarctiong archive {str(e)} {l}\n')
            return

        try:
            file_list = os.listdir(l_dir)

            list_type_Deviation = [file for file in file_list if
                                   file.find(ClassTypeProtocols.TypeProtocols.type_Deviation) != -1]
        except Exception as ex:
            logging.exception("Error: ")
            with open(file_log, 'a') as flog:
                flog.write(f'The file list was not gotten {str(ex)} {l_dir}\n')
        else:

            for f12 in list_type_Deviation:
                bolter(f12, l_dir, region, ClassTypeProtocols.TypeProtocols.type_Deviation)

        os.remove(l)
        try:
            shutil.rmtree(l_dir, ignore_errors=True)
        except Exception:
            pass


@timeout_decorator.timeout(300)
def down_timeout(m, path_parse1):
    host = 'ftp.zakupki.gov.ru'
    ftpuser = 'free'
    password = 'free'
    ftp2 = ftplib.FTP(host)
    ftp2.set_debuglevel(0)
    ftp2.encoding = 'utf8'
    ftp2.login(ftpuser, password)
    ftp2.cwd(path_parse1)
    local_f = '{0}/{1}'.format(TEMP_DIR, str(m))
    lf = open(local_f, 'wb')
    ftp2.retrbinary('RETR ' + str(m), lf.write)
    lf.close()
    return local_f


def get_ar(m, path_parse1):
    retry = True
    count = 0
    while retry:
        try:
            lf = down_timeout(m, path_parse1)
            retry = False
            return lf
        except Exception as ex:
            if count > 50:
                with open(file_log, 'a') as flog:
                    flog.write('The array has not been downloaded ' + count + ' try ' + str(ex) + ' ' + m + '\n')
                return 0
            count += 1


def main():
    shutil.rmtree(TEMP_DIR, ignore_errors=True)
    os.mkdir(TEMP_DIR)
    if not os.path.exists(LOG_DIR):
        os.mkdir(LOG_DIR)
    con_region = connect_bd(DB)
    cur_region = con_region.cursor()
    cur_region.execute("""SELECT * FROM region""")
    path_array = cur_region.fetchall()
    cur_region.close()
    con_region.close()

    for reg in path_array:
        if len(sys.argv) == 1:
            print(
                    'Bad parametrs: use curr, last, prev'
            )
            exit()
        elif str(sys.argv[1]) == 'last':
            path_parse = 'fcs_regions/' + reg['path'] + '/protocols/'
        elif str(sys.argv[1]) == 'curr':
            path_parse = 'fcs_regions/' + reg['path'] + '/protocols/currMonth/'
        elif str(sys.argv[1]) == 'prev':
            path_parse = 'fcs_regions/' + reg['path'] + '/protocols/prevMonth/'

        try:
            if str(sys.argv[1]) == 'curr':
                arr_con = get_list_ftp_curr(path_parse, reg['path'])
            elif str(sys.argv[1]) == 'last':
                arr_con = get_list_ftp_last(path_parse)
            elif str(sys.argv[1]) == 'prev':
                arr_con = get_list_ftp_prev(path_parse, reg['path'])
            else:
                arr_con = []
                print('Bad parametrs: use curr, last, prev')
                exit()
            for j in arr_con:
                try:
                    extract_prot(j, path_parse, reg['conf'])
                except Exception as exc:
                    print('Error in extractor ' + str(exc) + ' ' + j)
                    logging.exception("Error: ")
                    with open(file_log, 'a') as flog:
                        flog.write('Error in extractor ' + str(exc) + ' ' + j + '\n')
                    continue

        except Exception as ex:
            if '550 Failed to change directory' in str(ex):
                logging.warning(f"Can not find directory {path_parse}")
                continue
            logging.exception("Error: ")
            with open(file_log, 'a') as flog:
                flog.write(f'Error in getting list archives {str(ex)} {path_parse}\n')
            continue


if __name__ == "__main__":
    logging_parser("Start parsing")
    main()
    logging_parser('Added ProtocolDeviation',
                   ClassProtocolEF3.ProtocolEF3.add_protocolEF3)
    logging_parser('Updated ProtocolDeviation',
                   ClassProtocolEF3.ProtocolEF3.update_protocolEF3)
    logging_parser("End parsing")
