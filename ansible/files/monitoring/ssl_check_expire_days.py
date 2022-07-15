import time
import datetime
from OpenSSL import crypto as c
from checks import AgentCheck

class SSLCheckExpireDays(AgentCheck):
    def check(self, instance):
        metric = "ssl.expire_in_days"
        certfile = instance['cert']
        cert_tag = 'cert:%s' % (certfile.split('/')[-1:],)
        date_format = "%Y%m%d%H%M%SZ"

        cert = c.load_certificate(c.FILETYPE_PEM, open(certfile).read())
        output = cert.get_notAfter()
        if output:
            d0 = datetime.datetime.today()
            d1 = datetime.datetime(*time.strptime(output.decode(), date_format)[0:3])
            delta = d1 - d0
            self.gauge(metric, int(delta.days), tags=[cert_tag])
        else:
            self.gauge(metric, -1, tags=[cert_tag])
