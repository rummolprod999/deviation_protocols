import dateutil.parser
import pytz

import utils_functions as UtilsFunctions


class Protocol:
    def __init__(self, protocol, xml):
        prot = protocol[list(protocol.keys())[0]]
        list_p = [v for v in prot.keys() if 'fcs' in v.lower()]
        self.protocol = prot[list_p[0]]
        self.xml = xml
        if 'protocolLot' in self.protocol:
            if self.protocol['protocolLot'] is None:
                self.applications = []
            elif 'applications' in self.protocol['protocolLot']:
                if 'application' in self.protocol['protocolLot']['applications']:
                    self.applications = UtilsFunctions.generator_univ(
                            self.protocol['protocolLot']['applications']['application'])
                else:
                    self.applications = []
            elif 'application' in self.protocol['protocolLot']:
                self.applications = UtilsFunctions.generator_univ(self.protocol['protocolLot']['application'])
            else:
                self.applications = []
        else:
            self.applications = []

    def get_purchaseNumber(self):
        d = UtilsFunctions.get_el(self.protocol, 'purchaseNumber')
        return d

    def get_id(self):
        d = UtilsFunctions.get_el(self.protocol, 'id')
        return d

    def get_protocol_date(self):
        d = UtilsFunctions.get_el(self.protocol, 'protocolDate')
        if d:
            try:
                dt = dateutil.parser.parse(d)
                d = dt.astimezone(pytz.timezone("Europe/Moscow"))
            except Exception:
                d = ''
        else:
            d = ''
        return str(d)

    def get_purchase_date(self):
        d = UtilsFunctions.get_el(self.protocol, 'purchaseInfo', 'publishDate') or UtilsFunctions.get_el(self.protocol, 'publishDate')
        if d:
            try:
                dt = dateutil.parser.parse(d)
                d = dt.astimezone(pytz.timezone("Europe/Moscow"))
            except Exception:
                d = ''
        else:
            d = ''
        return str(d)

    def get_purchase_name(self):
        d = UtilsFunctions.get_el(self.protocol, 'purchaseInfo', 'purchaseObjectInfo') or UtilsFunctions.get_el(self.protocol, 'foundationProtocolName')
        return d

    def get_url(self):
        d = UtilsFunctions.get_el(self.protocol, 'href')
        return d

    def get_print_form(self):
        d = UtilsFunctions.get_el(self.protocol, 'printForm', 'url')
        if d.startswith("<![CDATA"):
            d = d[9:-3]
        return d

    def get_journal_number(self, application):
        d = UtilsFunctions.get_el(application, 'journalNumber')
        return d
