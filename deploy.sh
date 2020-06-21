docker build -t abdotalaat/multi-client:latest -t abdotalaat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abdotalaat/multi-server:latest -t abdotalaat/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abdotalaat/multi-worker:latest -t abdotalaat/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push abdotalaat/multi-client:latest
docker push abdotalaat/multi-server:latest
docker push abdotalaat/multi-worker:latest

docker push abdotalaat/multi-client:$SHA
docker push abdotalaat/multi-server:$SHA
docker push abdotalaat/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abdotalaat/multi-server:$SHA
kubectl set image deployments/client-deployment client=abdotalaat/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abdotalaat/multi-worker:$SHA