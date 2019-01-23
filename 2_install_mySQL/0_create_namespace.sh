
kubectl get namespace mysql-staging > /dev/null 2>&1 && echo "namespace mysql-staging exists already; nothing to do" || kubectl create namespace mysql-staging 
