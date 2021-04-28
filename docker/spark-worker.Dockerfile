FROM base-image

CMD ${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} >> /dev/null
