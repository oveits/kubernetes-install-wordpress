
# if NAMESPACE is not defined, use the current namespace:
[ "$NAMESPACE" == "" ] \
  && NAMESPACE=$(kubectl config get-contexts | grep '^\*' | awk '{print $5}')

# if current NAMESPACE is not defined, use the default namespace:
[ "$NAMESPACE" == "" ] && NAMESPACE=default

[ "$1" == "-d" ] && CMD=delete || CMD=apply


