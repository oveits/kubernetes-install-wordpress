
if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0"
  exit 1
fi

cat << EOF > mysqlDeployment.sh
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: mysql
  namespace: ${NAMESPACE}
  labels:
    app: wordpress
spec:
  selector:
    matchLabels:
      app: wordpress
      tier: mysql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: wordpress
        tier: mysql
    spec:
      containers:
      - image: mysql:5.6
        name: mysql
        terminationMessagePolicy: FallbackToLogsOnError
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-pass
              key: password
        ports:
        - containerPort: 3306
          name: mysql
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql
      volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: mysql-pv-claim
EOF

if [ "$1" == "-d" ]; then
   kubectl delete -f mysqlDeployment.sh
else
   kubectl create -f mysqlDeployment.sh
fi
