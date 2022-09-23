FROM debian:stable-slim
RUN apt-get update && apt-get install -y procps grep jq curl iproute2 lsof python3
RUN touch /bin/cardano-cli && chmod+x /bin/cardano-cli
COPY scripts /scripts
CMD ["bash", "/scripts/start.sh"]
