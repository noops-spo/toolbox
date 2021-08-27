FROM debian:stable-slim
RUN apt-get update && apt-get install -y procps grep jq curl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
&& chmod +x kubectl && mv ./kubectl /usr/bin/kubectl
RUN echo "kubectl exec -it cardano-mainnet-relay-0 cardano-cli" >> /usr/bin/cardano-cli && chmod +x /usr/bin/cardano-cli
