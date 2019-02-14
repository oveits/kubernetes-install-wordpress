
source $CONFIG_FILE

if [ "$BOX" == "" ]; then
  echo "usage: BOX=staging bash $0"
  exit 1
fi


source $HOME/.cloudflare/credentials.sh
# the content of the credentials file should look like follows:
# ZONE=your_zone
# EMAIL=your_email@example.com
# GLOBAL_API_KEY=your_global_api_key

IP=$(curl -4 -s ifconfig.co); 
  
echo "My public IP is: $IP"

NAME=$BOX
ENTRY=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE/dns_records?type=A&name=$NAME&page=1&per_page=20&order=type&direction=desc&match=all" \
       -H "X-Auth-Email: $EMAIL" \
       -H "X-Auth-Key: $GLOBAL_API_KEY" \
       -H "Content-Type: application/json" )

ID=$(echo "$ENTRY" | jq '.["result"][0]["id"]' | sed "s/\"//g")

# Create entry, if not present:
echo ENTRY=$ENTRY
echo ID=$ID

[ "$ID" == "null" ] && [ "$IP" != "" ] \
  && curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE/dns_records/"  \
	  -H "X-Auth-Email: $EMAIL" \
	  -H "X-Auth-Key: $GLOBAL_API_KEY" \
	  -H "Content-Type: application/json" \
	  --data '{
          "type":"A",
          "name":"'$NAME'",
          "content":"'$IP'",
          "ttl":120,
          "priority":10,
          "proxied":false}' \
  && echo "New DNS record created for $NAME"
