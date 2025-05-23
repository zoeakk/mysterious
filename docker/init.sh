#!/bin/bash

BASE_DIR=./mysterious
PLATFORM=$1

if test -d $BASE_DIR; then
  echo "$BASE_DIR is exist"
  exit
fi

mkdir $BASE_DIR

# 创建执行，日志目录
mkdir -p ${BASE_DIR}/logs

# 创建mysql目录
mkdir -p ${BASE_DIR}/mysql/sql
cp init.sql ${BASE_DIR}/mysql/sql/
mkdir -p ${BASE_DIR}/mysql/data

# 创建redis目录
mkdir -p ${BASE_DIR}/redis/data
mkdir -p ${BASE_DIR}/redis/logs
mkdir -p ${BASE_DIR}/redis/conf
cp redis.conf ${BASE_DIR}/redis/conf/

# 创建nginx目录, 配置文件，静态资源目录
mkdir -p ${BASE_DIR}/nginx/conf.d
cp 1234.conf ${BASE_DIR}/nginx/conf.d/
cp 9998.conf ${BASE_DIR}/nginx/conf.d/
mkdir -p ${BASE_DIR}/nginx/html
cp -r dist ${BASE_DIR}/nginx/html/

# 创建压测数据，报告目录
mkdir -p ${BASE_DIR}/mysterious-data

# 创建基础jmx模板文件，在线编辑脚本用
mkdir -p ${BASE_DIR}/mysterious-jmx
cp jmx/*.jmx ${BASE_DIR}/mysterious-jmx/

# copy compose文件和env文件
cp docker-compose.yml ${BASE_DIR}/

if [ "$PLATFORM" = "amd64" ]; then
  cp amd64.env ${BASE_DIR}/.env
elif [ "$PLATFORM" = "arm64" ]; then
  cp arm64.env ${BASE_DIR}/.env
fi
