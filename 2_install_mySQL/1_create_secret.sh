
[ "$PASSWORD" == "" ] && export PASSWORD="$1"

if [ "$PASSWORD" == "" ] || [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0 my-password"
  echo "       export NAMESPACE=staging; export PASSWORD=your-password; $0"
  exit 1
fi

#PASSWORD=$1
echo "PASSWORD=$PASSWORD"
echo "NAMESPACE=$NAMESPACE"

if [ "$1" == "-d" ]; then
   kubectl delete secret generic mysql-pass --from-literal=password="$PASSWORD" -n ${NAMESPACE}
else
   kubectl create secret generic mysql-pass --from-literal=password="$PASSWORD" -n ${NAMESPACE}
fi
