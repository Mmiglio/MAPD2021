FROM base-image

EXPOSE ${SPARK_MASTER_PORT} 8080

CMD ${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.master.Master >> /dev/null
