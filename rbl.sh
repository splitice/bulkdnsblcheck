#!/bin/bash

## DNSBL Bulk Checker
## Developed By: SplitIce <https://www.x4b.net>
## Free for commercial & Non-commercial use or whatever, just dot sue me.
##
## Usage: 
## ./rbl.sh listcheck - Verify that all DNSBLS in the list are responding within a reasonable time (online)
## ./rbl.sh details [ip1] [...] - Fetch details for all RBL entries for one or many IP addresses
## ./rbl.sh [ip1] [...] - Fetch a total count of RBL entries for many IP addresses

RBL=rbl_list.txt

if [[ $1 == "check" ]]; then
        dig +short +time=1 +tries=2 $2 | grep "127.0.0."
elif [[ $1 == "listcheck" ]]; then
        RBL_C=$(cat "$RBL" | grep -v "#")

        while read -r var; do
                if [[ $(dig 1.1.1.1.$var +time=1 2>&1 | grep timed | wc -l) == "1" ]]; then
                        echo "$var timed out"
                fi
        done <<< "$RBL_C"
elif [[ $1 == "details" ]]; then
        echo "Performing detailed lookup for $2"
        RBL_C=$(cat "$RBL" | grep -v "#")

		for i in "${@:2}"; do
			W=$( echo $i | cut -d. -f1 )
			X=$( echo $i | cut -d. -f2 )
			Y=$( echo $i | cut -d. -f3 )
			Z=$( echo $i | cut -d. -f4 )

			while read -r var; do
					CHECK=$(dig +short $Z.$Y.$X.$W.$var | grep "127.0.0." | wc -l)

					if [[ $CHECK -gt 0 ]]; then
							REASON=$(dig +short $Z.$Y.$X.$W.$var TXT)
							echo "$i blacklisted on $var for: $REASON"
					fi
			done <<< "$RBL_C"
		done
else
        COUNT=0
        RBL_C=$(cat "$RBL" | grep -v "#")

        for var in "$@"
        do
                W=$( echo $var | cut -d. -f1 )
                X=$( echo $var | cut -d. -f2 )
                Y=$( echo $var | cut -d. -f3 )
                Z=$( echo $var | cut -d. -f4 )
                R=$(echo "$RBL_C" | sed -e "s/^/$Z.$Y.$X.$W./g" | parallel --max-procs 100 bash "$0" check {} | wc -l)
                let "COUNT=R+COUNT"
        done
        echo $COUNT
fi