
# create unique BOX:
while true; do
   BOX="b$( < /dev/urandom tr -dc a-z-1-9 | head -c9)"
   kubectl get namespace $BOX 2>/dev/null || break
done

# save all config in config file:
[ -d config ] || mkdir config
export CONFIG_FILE=$(pwd)/config/$BOX.properties

echo "BOX=$BOX" > $CONFIG_FILE
echo "NAMESPACE=$BOX" >> $CONFIG_FILE
echo "MYSQL_PASSWORD=$( < /dev/urandom tr -dc A-Z-a-z-1-9 | head -c8)" >> $CONFIG_FILE

