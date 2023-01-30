#!/bin/sh
##############################
# Date: 2023/01/30
# Author: cc
# Function: Install Qinglong
##############################

if [ $(uname -i) != 'x86_64' ];
then
	echo "[ERROR] Please use x86_ 64 architecture machine."
	exit 1
fi

if [ ! -f /etc/redhat-release ];
then
	echo "[ERROR] Please check whether the operating system is CentOS."
	exit 1
fi

docker_file="/etc/docker"

yum install -y curl 
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
mkdir -p ${docker_file}

systemctl enable docker && systemctl start docker
docker pull whyour/qinglong

docker run -dit \
-v ${docker_file}/config:/ql/config \
-v ${docker_file}/log:/ql/log \
-v ${docker_file}/db:/ql/db -p 5700:5700 \
--name ql --restart always whyour/qinglong

sleep 10

cat << EOF

################################
#                              #
#    Installation succeeded    #
#                              #
################################

Please visit:   http://IP:5700/

EOF
