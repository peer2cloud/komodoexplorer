#!/bin/bash
set -e
nginx_index_file="/opt/www/index.html"
function createconfig {
    if [[ $# -ne 2 ]]; then
        echo "ERROR: For call functions createconfig use:"
        echo "createconfig coins ports" 
        exit 1
    fi
    path="/etc/nginx/conf.d"
    file="$1.conf"
    echo "...Checking ${path}/${file}"
    ports=($2)
    name=${1,,}
    echo "$1 - <a href='http://$name.komodo.build'>$name.komodo.build</a><br>" >> $nginx_index_file
    echo "Create nginx config fo $1"
    cat <<EOF > ${path}/${file}
#Config $1
######################################
server {
    listen  80;
    server_name $1.komodo.build;

    error_log /dev/stderr info;
    access_log /dev/stdout;
    log_not_found off;

    root /home/user/isight;

    location / {
        set \$upstream http://127.0.0.1:${ports[2]};
        proxy_pass \$upstream;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_set_header X-Real-IP  \$remote_addr;
        proxy_set_header X-Forwarded-For \$remote_addr;
    }
}
EOF
}

source /coinlist
echo "<html>" > $nginx_index_file
createconfig KMD "8232 8332 3001"
for i in "${!coin[@]}"
do
#    str=(${coin[$i]})
    createconfig {$i,,} "${coin[$i]}"
done
echo "</html>" >> $nginx_index_file
#rm /etc/nginx/conf.d/*
cat <<EOF > /etc/nginx/conf.d/00-default.conf
#Config $1
######################################
server {
    listen  80;
    server_name _;

    error_log /dev/stderr info;
    access_log /dev/stdout;
    log_not_found off;
    root /opt/www/;
    location / {
        index  index.html;
    }
}
EOF

exec nginx -g 'daemon off;'

