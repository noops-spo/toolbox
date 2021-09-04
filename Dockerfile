FROM debian:stable-slim
RUN apt-get update && apt-get install -y procps grep jq curl iproute2 lsof cron python3
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
&& chmod +x kubectl && mv ./kubectl /usr/bin/kubectl
RUN echo "kubectl exec relay-0 -c cardano-mainnet-relay -- cardano-cli" >> /usr/bin/cardano-cli && chmod +x /usr/bin/cardano-cli
RUN crontab -l | { cat; echo "0 * * * * bash /data/script/topologyUpdater.sh"; } | crontab -
COPY scripts /scripts
CMD ["bash", "/scripts/start.sh"]
