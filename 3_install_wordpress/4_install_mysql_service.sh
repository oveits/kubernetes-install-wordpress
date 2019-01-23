
if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0"
  exit 1
fi

cat <<EOF > mysqlService.yaml
apiVersion: v1
kind: Service
metadata:
  name: wordpress-mysql
  namespace: mysql-staging
  labels:
    app: wordpress
spec:
  ports:
    - port: 3306
  selector:
    app: wordpress
    tier: mysql
  clusterIP: None
EOF

kubectl create -f mysqlService.yaml
