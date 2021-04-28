docker build \
 -f base-image.Dockerfile \
 -t base-image .

docker build \
 -f spark-master.Dockerfile \
 -t spark-master .

docker build \
 -f spark-worker.Dockerfile \
 -t spark-worker .

docker build \
 -f spark-jupyter.Dockerfile \
 -t spark-jupyter .
