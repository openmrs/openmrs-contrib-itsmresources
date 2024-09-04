# Tiers

We are dividing our infrastructure into different tiers. They've been proposed in [talk](https://talk.openmrs.org/t/rfc-production-tiers-for-our-infrastructure/14832). The tier should be defined in [Terraform](https://docs.openmrs.org/infrastructure/vms.html)


## Tier 1
The most used and relevant services for the community. A large portion of the active community would consider 1h long outage during business time a bad experience, and would prevent them doing their work. These are the most critical systems that affect most of our community, most of the time.
Outages are expected to last less than 1h.


## Tier 2
These services can be down quite possibly for a couple of hours before it actually blocks someone. Outages are expected to last less than 4h.


## Tier 3
Similar to Tier 2, but a smaller percentage of the community would be affected. Outages are expected to last less than a day.


## Tier 4
Either affects a very small percentage of the community, or accessed/used much less frequently. Outages are expected to last less than 2 days.

