MESSAGE="$(kubectl describe issuer letsencrypt | grep 'Message\|Reason')"
echo "$MESSAGE"
echo "$MESSAGE" | grep -q ACMEAccountRegistered
