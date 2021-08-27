FROM debian:stable-slim
RUN apt-get update && apt-get install -y procps grep jq curl iproute2 lsof
RUN apt install -yqq chron
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
&& chmod +x kubectl && mv ./kubectl /usr/bin/kubectl
RUN echo "kubectl exec cardano-mainnet-relay-0 -c cardano-mainnet-relay -- cardano-cli" >> /usr/bin/cardano-cli && chmod +x /usr/bin/cardano-cli
RUN crontab -l | { cat; echo "0 * * * * docker exec cardano-relay ./scripts/topologyUpdater.sh > /var/log/cardano.log"; } | crontab -
