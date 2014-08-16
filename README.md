bulkdnsblcheck
==============

A parallel DNSBL checker using bash and GNU Parallel utilities

## Usage
```
#./rbl.sh
Usage:
./rbl.sh listcheck - Verify that all DNSBLS in the list are responding within a reasonable time (online)
./rbl.sh details [ip1] [...] - Fetch details for all RBL entries for one or many IP addresses
./rbl.sh count [ip1] [...] - Fetch a total count of RBL entries for many IP addresses

IP address can be either a single address or network in CIDR form
```

## Prerequisites
 - GNU Parallel
 - prips
 - bind-utils (dig)
 
 Optionally adns-utils if installed will be used for greater bulk query performance (in place of GNU Parallel and dig for some actions)