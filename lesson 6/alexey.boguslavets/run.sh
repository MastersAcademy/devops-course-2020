# kubectl port-forward pod/alex-pod 9000 8080 
kubectl exec -it alex-pod -- curl http://localhost:8080

