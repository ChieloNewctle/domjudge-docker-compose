#!/bin/bash

ver=$(date "+%Y.%m.%d-%H.%M.%S")

export time_zone=$(cat /etc/timezone)

var_mask='${time_zone}'

declare -A password_vars=(
    [mysql_password]=24
    [mysql_root_password]=32
    [judgehost_password]=32
    [domserver_admin_password]=24
    [domserver_cds_password]=32
    [cds_admin_password]=24
    [cds_pres_admin_password]=24
    [cds_balloon_password]=24
    [cds_presentation_password]=16
)

random_password() {
    dd if=/dev/urandom | tr -dc A-Za-z0-9 | head -c${1:-$1}
}

if [ -z "$1" ]; then
    for i in "${!password_vars[@]}"; do
        var_mask="${var_mask} \${$i}"
        eval export $i=$(random_password ${password_vars[$i]})
    done

    touch vars-$ver.sh
    for i in "${!password_vars[@]}"; do
        echo $i=$(eval echo \${$i}) >> vars-$ver.sh
    done
    sort -o vars-$ver.sh vars-$ver.sh
else
    source $1
    for i in "${!password_vars[@]}"; do
        var_mask="${var_mask} \${$i}"
        eval export $i
    done
fi

declare -a dest=(
    domserver/domserver.env
    domserver/start.sh
    domserver/add_cds_user.php
    judgehost/judgehost.env
    cds/cdsConfig.xml
    cds/server.xml
    cds/users.xml
)

for i in ${dest[@]}; do
    envsubst "$var_mask" < "templates/$(basename $i)" > $i
    chmod --reference="templates/$(basename $i)" $i
done
