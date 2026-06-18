# Cloudflare publishes its edge IP ranges at https://www.cloudflare.com/ips/. The list is
# stable -- it changes roughly once every few years -- but cloudflare_realip.conf pins those
# ranges, so a silent change would leave new Cloudflare edges untrusted and break real-IP
# recovery (and any future origin firewall allowlist). This check compares the live etag from
# the API against the expected etag pinned in the agent config and flags drift, so the snippet
# can be refreshed before it bites.
from checks import AgentCheck

import json

try:
    from urllib.request import urlopen, Request
except ImportError:  # older agent embeds ship Python 2
    from urllib2 import urlopen, Request

CLOUDFLARE_IPS_URL = "https://api.cloudflare.com/client/v4/ips"
SERVICE_CHECK = "cloudflare.ips.list_changed"


class CloudflareIpsCheck(AgentCheck):

    def check(self, instance):
        expected_etag = instance.get("expected_etag")
        if not expected_etag:
            self.service_check(SERVICE_CHECK, AgentCheck.UNKNOWN,
                               message="expected_etag is not configured")
            return

        try:
            request = Request(CLOUDFLARE_IPS_URL, headers={"Accept": "application/json"})
            response = urlopen(request, timeout=15)
            payload = json.loads(response.read().decode("utf-8"))
        except Exception as e:
            # Network/parse failures are transient; report UNKNOWN rather than paging on a blip.
            self.service_check(SERVICE_CHECK, AgentCheck.UNKNOWN,
                               message="Could not fetch Cloudflare IP list: {0}".format(e))
            return

        live_etag = (payload.get("result") or {}).get("etag")
        if not live_etag:
            self.service_check(SERVICE_CHECK, AgentCheck.UNKNOWN,
                               message="Cloudflare response contained no etag")
            return

        changed = live_etag != expected_etag
        self.gauge("cloudflare.ips.list_changed", 1 if changed else 0)

        if changed:
            self.service_check(
                SERVICE_CHECK, AgentCheck.CRITICAL,
                message=("Cloudflare IP list etag changed: expected {0}, got {1}. Refresh "
                         "cloudflare_realip.conf and cloudflare_ips_expected_etag."
                         ).format(expected_etag, live_etag))
        else:
            self.service_check(SERVICE_CHECK, AgentCheck.OK)
