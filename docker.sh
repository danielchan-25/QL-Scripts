docker run -dit \
-v ./ql/config:/ql/config \
-v ./ql/log:/ql/log \
-v ./ql/db:/ql/db -p 5700:5700 \
--name ql \
--restart always \
whyour/qinglong:latest
