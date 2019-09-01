# Build production images
docker build -t khteo/multi-client:latest -t khteo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t khteo/multi-server:latest -t khteo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t khteo/multi-worker:latest -t khteo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# Take those images and push them to docker hub
docker push khteo/multi-client:latest
docker push khteo/multi-server:latest
docker push khteo/multi-worker:latest
docker push khteo/multi-client:$SHA
docker push khteo/multi-server:$SHA
docker push khteo/multi-worker:$SHA
# Apply all configs in k8s folder
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=khteo/multi-client:$SHA
kubectl set image deployments/server-deployment server=khteo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=khteo/multi-worker:$SHA
