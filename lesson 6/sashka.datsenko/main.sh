#!/bin/sh

kubectl exec -it web-app --container web-app-container -- curl http://localhost:8080