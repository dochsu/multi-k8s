docker build -t dochsu/multi-client:latest -t dochsu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dochsu/multi-server:latest -t dochsu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dochsu/multi-worker:latest -t dochsu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dochsu/multi-client:latest
docker push dochsu/multi-server:latest
docker push dochsu/multi-worker:latest

docker push dochsu/multi-client:$SHA
docker push dochsu/multi-server:$SHA
docker push dochsu/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=dochsu/multi-client:$SHA
kubectl set image deployments/server-deployment server=dochsu/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dochsu/multi-worker:$SHA