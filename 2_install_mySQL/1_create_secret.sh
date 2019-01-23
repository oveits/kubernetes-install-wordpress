
[ "$PASSWORD" == "" ] && export PASSWORD="$1"

if [ "$PASSWORD" == "" ]; then
  echo "usage: $0 my-password"
  echo "       export PASSWORD=your-password; $0"
  exit 1
fi

#PASSWORD=$1
echo "PASSWORD=$PASSWORD"

kubectl create secret generic mysql-pass --from-literal=password="$PASSWORD" -n mysql-staging
