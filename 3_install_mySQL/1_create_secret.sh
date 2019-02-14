
source $CONFIG_FILE

if [ "$MYSQL_PASSWORD" == "" ] || [ "$NAMESPACE" == "" ]; then
  echo "usage: NAMESPACE=staging MYSQL_PASSWORD=your-password bash $0"
  echo "       source <property-file>; bash $0"
  exit 1
fi

echo "MYSQL_PASSWORD=$MYSQL_PASSWORD"
echo "NAMESPACE=$NAMESPACE"

if [ "$1" == "-d" ]; then
   kubectl delete secret mysql-pass -n ${NAMESPACE}
else
   #kubectl create secret generic mysql-pass --from-literal=password="$MYSQL_PASSWORD" -n ${NAMESPACE}
   cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
data:
  password: $(echo -n "$MYSQL_PASSWORD" | base64)
metadata:
  name: mysql-pass
  namespace: bh3d1yooxn
type: Opaque
EOF
fi

