# router-basic-stress-test
basic route creation/update/delete stress test

1. Create a test pod and secure and insecure services.

       oc create -f dc.json

       oc create -f insecure-service.json

       oc create -f secure-service.json


2. Run one of the stress tests:

       ./create-routes

       # OR

       ./delete-routes

       # OR

       ./stress-recreate


3. Check the appropriate route status.

```
       # Example check route 280.
       n=280
       for i in `seq 1000`; do
	  echo $(date): $(curl -k -s -o /dev/null  --resolve allow-$n.header.test:80:127.0.0.1  -w "%{http_code}  %{time_connect}:%{time_starttransfer}:%{time_total}\n" http://allow-$n.header.test);
       done
```

