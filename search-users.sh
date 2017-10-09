#!/bin/bash
session_id=$1
skout_url=https://www.skout.com/api/1/users/search
include_buzz=false
limit=10
offset=0
other_ethnicity_multi=
other_gender=both
other_interested_in=both
other_max_age=30
other_min_age=18
search_level=2
userListsOptions=`curl --request OPTIONS --connect-timeout 3 --max-time 3  --url "${skout_url}?include_buzz=${include_buzz}&limit=${limit}&offset=${offset}&other_ethnicity_multi=${other_ethnicity_multi}&other_gender=${other_gender}&other_interested_in=${other_interested_in}&other_max_age=${other_max_age}&other_min_age=${other_min_age}&search_level=${search_level}"   --header 'cache-control: no-cache'  --header "session_id: ${session_id}" --header 'OPTIONS: session_id' --header "Access-Control-Request-Method: GET"`
userLists=`curl --request GET --connect-timeout 3 --max-time 3  --url "${skout_url}?include_buzz=${include_buzz}&limit=${limit}&offset=${offset}&other_ethnicity_multi=${other_ethnicity_multi}&other_gender=${other_gender}&other_interested_in=${other_interested_in}&other_max_age=${other_max_age}&other_min_age=${other_min_age}&search_level=${search_level}"   --header 'cache-control: no-cache'  --header "session_id: ${session_id}"`
userIds=
for row in $(echo "${userLists}" | jq -r '.elements[] | @base64'); do
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }

   userIds=${userIds}" "$(_jq '.user.id')
done
echo ${userIds}
