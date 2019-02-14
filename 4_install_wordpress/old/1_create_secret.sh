
# [ "$PASSWORD" == "" ] && export PASSWORD="$1"

if [ "$PASSWORD" == "" || "$NAMESPACE" == "" ]; then
  echo "usage: export PASSWORD=your-password; export NAMESPACE=staging; $0"
  exit 1
fi

#PASSWORD=$1
echo "PASSWORD=$PASSWORD"

if [ "$1" == "-d" ]; then
   kubectl delete secret generic mysql-pass --from-literal=password="$PASSWORD" -n $STAGING
else
   kubectl create secret generic mysql-pass --from-literal=password="$PASSWORD" -n $STAGING
fi
