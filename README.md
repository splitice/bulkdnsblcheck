bulkdnsblcheck
==============

A parallel DNSBL checker using bash and GNU Parallel utilities

## Usage
```
#./rbl.sh
Usage:
/opt/zabbix/rbl5.sh listcheck - Verify that all DNSBLS in the list are responding within a reasonable time (online)
/opt/zabbix/rbl5.sh details [ip1] [...] - Fetch details for all RBL entries for one or many IP addresses
/opt/zabbix/rbl5.sh count [ip1] [...] - Fetch a total count of RBL entries for many IP addresses

IP address can be either a single address or network in CIDR form
```

## Prerequisites
 - GNU Parallel
 - prips
 - bind-utils (dig)