#!/bin/bash

echo "Prepare environment vairables:"

kubectl apply -f ./aws-secret.yaml
kubectl apply -f ./env-secret.yaml
kubectl apply -f ./env-configmap.yaml

echo "Start deploying - Current Working Directory:"
echo "$PWD"

echo "Deploy API Feed."

kubectl apply -f ./backend-feed-deployment.yaml
# kubectl apply -f ./backend-feed-hpa.yaml
kubectl apply -f ./backend-feed-service.yaml

echo "Finished."
echo "Deploy API User."

kubectl apply -f ./backend-user-deployment.yaml
# kubectl apply -f ./backend-user-hpa.yaml
kubectl apply -f ./backend-user-service.yaml

echo "Finished."
echo "Deploy Frontend."

kubectl apply -f ./frontend-deployment.yaml
# kubectl apply -f ./frontend-hpa.yaml
kubectl apply -f ./frontend-service.yaml

echo "Finished."
echo "Deploy The Reverse Proxy."

kubectl apply -f ./reverseproxy-deployment.yaml
kubectl apply -f ./reverseproxy-service.yaml

kubectl expose deployment frontend --type=LoadBalancer --name=publicfrontend
kubectl expose deployment reverseproxy --type=LoadBalancer --name=publicreverseproxy

echo "Finished deploying process."