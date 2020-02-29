#!/bin/bash

uid_base=17300

cat > docker-compose.yml << EOF
version: "3"
services:
EOF

for i in $(seq 1 $1); do
    cat >> docker-compose.yml << EOF
    judgehost_$i:
        image: chielonewctle/domjudge-judgehost:latest
        networks:
            - domserver_domjudge_net
        env_file:
            - judgehost.env
        environment:
            - DAEMON_ID=$(expr $i - 1)
            - RUN_USER_UID_GID=$(expr $uid_base + $i)
        volumes:
            - /sys/fs/cgroup:/sys/fs/cgroup:ro
        pid: host
        privileged: true
EOF
done

cat >> docker-compose.yml << EOF
networks:
    domserver_domjudge_net:
        external: true
EOF
