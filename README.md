# 青龙面板

该项目为个人自用青龙面板主库，

## 部署
### 一键部署脚本

### docker-compose 部署

```yml
version: '2.9.0'
services:
  ql:
    image: whyour/qinglong:latest
    container_name: ql
    network_mode: bridge
    restart: always
    volumes:
      - "./ql/config:/ql/config"
      - "./ql/log:/ql/log"
      - "./ql/db:/ql/db"
    ports:
      - "5700:5700"
```

## 常用命令

```sh
# 添加单个仓库的指定脚本
ql repo <repo_url> <whitelist> <blacklist> <dependence> <branch> <extensions>
```

- repo_url: 仓库地址
- whitelist: 拉取仓库时的白名单，即就是需要拉取的脚本的路径包含的字符串，多个竖线分割
- blacklist: 拉取仓库时的黑名单，即就是需要拉取的脚本的路径不包含的字符串，多个竖线分割
- dependence: 拉取仓库需要的依赖文件，会直接从仓库拷贝到scripts下的仓库目录，不受黑名单影响，多个竖线分割
- extensions: 拉取仓库的文件后缀，多个竖线分割
