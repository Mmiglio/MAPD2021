FROM continuumio/miniconda3:4.9.2

ARG shared_workspace=/opt/workspace
ENV SHARED_WORKSPACE=${shared_workspace}

# -- Layer: java
RUN mkdir -p /usr/share/man/man1
RUN apt-get -y update && \
    apt-get install --no-install-recommends -y \
    "openjdk-11-jre-headless" \
    ca-certificates-java && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# -- Layer: spark
ARG spark_version=3.1.1
ARG hadoop_version=3.2

RUN apt-get update -y && \
    apt-get install -y curl && \
    curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz && \
    tar -xf spark.tgz && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version} /usr/bin/ && \
    mkdir /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/logs && \
    rm spark.tgz

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_HOME /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}
ENV PYSPARK_PYTHON python
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
ENV PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH

# -- Install pyarrow
RUN pip install pyarrow numpy pandas

# -- Install proc tools
RUN apt-get update && apt-get install -y procps && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]
