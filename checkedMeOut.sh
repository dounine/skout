#!/bin/bash
session_id=$1
while (( 1 ))
do
	for id in `./search-users.sh ${session_id}`;
	do
	curl --request GET \
  	--url "https://www.skout.com/api/1/users/${id}?whoCheckedMeOut=true" \
  	--header 'cache-control: no-cache' \
  	--header "session_id: ${session_id}" --connect-timeout 3 --max-time 3 | jq .
	done
done
