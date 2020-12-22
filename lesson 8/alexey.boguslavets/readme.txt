kubectl set image deploy/alex-deploy *=boguslavets/ma.devops.boguslavets:2.0
kubectl port-forward alex-deploy-7c4bc64859-h4bxx 8080:8080
