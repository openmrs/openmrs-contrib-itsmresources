# firewall

Host firewall via `ufw`: default-deny incoming, SSH always allowed, and optionally the web
ports and a set of container egress denies. The role is a no-op unless a host sets
`firewall_enabled: true`, so it is safe to leave in the `hosts: all` play.

## Inbound

SSH is opened before ufw is enabled, so turning it on cannot drop the control connection.
Ports 80/443 are opened only when `firewall_allow_http` is true — by default that tracks
`restrict_http_to_cloudflare`, which further narrows them to `cloudflare_ip_ranges` and
asserts the host really is behind Cloudflare. A host that needs the web ports open to the
world sets `firewall_allow_http: true` on its own.

## Container egress (`docker_egress_deny_enabled`)

Denies containers a route to the cloud metadata endpoint and the RFC1918 ranges, closing
infrastructure SSRF — untrusted input, or a compromised dependency, steering an outbound
call at `169.254.169.254` (instance-role credentials, i.e. the whole cloud account) or into
the private network. Used by `aksum`, which runs agent containers that consume untrusted
community input.

Container traffic is forwarded, and Docker gets at it before any ufw chain does, so these
cannot be ufw rules — they are a `DOCKER-USER` block in `/etc/ufw/after.rules` and
`after6.rules`, which ufw re-applies on reload and at boot. Two consequences worth knowing:

- The role templates the **whole** rules files, including Ubuntu's stock contents, so those
  templates need re-checking against the packaged files on a distro upgrade. Only hosts
  with the denies enabled get them written at all.
- The block flushes `DOCKER-USER` on every reload, so ufw is the only thing that may
  populate that chain on these hosts.

Rules match on the outbound interface (`docker_egress_uplink_interface`, defaulting to the
default-route NIC), not on container source subnets, which exempts container-to-container
traffic — a container keeps full access to the rest of its compose stack while losing every
off-host private destination. The denies therefore apply to **every** container on the host.
Anything needing an off-host private destination, a resolver on the private network in
particular, must be listed in `docker_egress_allowed_destinations`.

The v6 denies are insurance rather than an active control: Docker gives containers no IPv6
connectivity unless the daemon is configured for it, so until that happens the v6
`DOCKER-USER` chain exists but nothing jumps to it. Note v6 cannot be made as complete as
v4 out of the box — there is no RFC1918 equivalent, and an internal v6 host normally has a
globally routable address, so `docker_egress_denied_destinations6` needs the host's own
prefix added to cover the internal network rather than just link-local and ULA.

### Verification

```sh
docker run --rm alpine wget -qT2 -O- http://169.254.169.254/   # must time out
docker run --rm alpine wget -qT2 -O- https://example.com/      # must succeed
iptables -S DOCKER-USER                                        # the denies, then RETURN
```

Internal stack endpoints must keep working; on a host whose resolver is a private address
off-box (`resolvectl status`), that address belongs in `docker_egress_allowed_destinations`.

See `defaults/main.yml` for the rest.
