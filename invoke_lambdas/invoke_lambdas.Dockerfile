FROM alpine:latest
RUN ["apk", "update"]
RUN ["apk", "add", "curl"]
ENTRYPOINT ["/invoke_lambdas_script.sh"]
