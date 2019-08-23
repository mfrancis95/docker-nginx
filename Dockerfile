FROM alpine

RUN apk --no-cache add nginx && addgroup nginx root && cd /etc/nginx && \
    mkdir /var/cache/nginx && \
    chmod g+rwx /var/cache/nginx /var/log/nginx /var/run && \
    echo 'pid /var/run/nginx.pid;' >> nginx.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    sed -i '/user nginx;/d' nginx.conf && sed -i 's/80/8080/' conf.d/default.conf

USER nginx

EXPOSE 8080

ENTRYPOINT nginx -g 'daemon off;'