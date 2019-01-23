
[ "$NAMESPACE" = "" ] && export NAMESPACE=staging

kubectl get namespace $NAMESPACE > /dev/null 2>&1 && echo "namespace $NAMESPACE exists already; nothing to do" || kubectl create namespace $NAMESPACE 

bash 1_* \
  && bash 2_* \
  && bash 3_* \
  && bash 4_*
