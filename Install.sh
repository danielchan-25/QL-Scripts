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

tee ${docker_file}/daemon.json <<-'EOF'
{
  "registry-mirrors": [
    "https://0b27f0a81a00f3560fbdc00ddd2f99e0.mirror.swr.myhuaweicloud.com",
    "https://ypzju6vq.mirror.aliyuncs.com",
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn"
  ]
}
EOF

systemctl enable docker && systemctl restart docker
docker pull whyour/qinglong:latest

docker run -dit \
-v ${docker_file}/config:/ql/config \
-v ${docker_file}/log:/ql/log \
-v ${docker_file}/db:/ql/db -p 5700:5700 \
--name ql --restart always whyour/qinglong:latest

sleep 10

cat << EOF

################################
#                              #
#    Installation succeeded    #
#                              #
################################

Please visit:   http://IP:5700/

EOF
