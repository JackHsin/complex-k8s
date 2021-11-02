docker build -t jackhsin/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jackhsin/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jackhsin/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jackhsin/multi-client:latest
docker push jackhsin/multi-server:latest
docker push jackhsin/multi-worker:latest

docker push jackhsin/multi-client:$SHA
docker push jackhsin/multi-server:$SHA
docker push jackhsin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jackhsin/multu-server:$SHA
kubectl set image deployments/client-deployment client=jackhsin/multu-client:$SHA
kubectl set image deployments/worker-deployment worker=jackhsin/multu-worker:$SHA