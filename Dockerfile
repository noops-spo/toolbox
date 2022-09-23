FROM debian:stable-slim
RUN apt-get update && apt-get install -y procps grep jq curl iproute2 lsof python3 cron
RUN touch /bin/cardano-cli && chmod+x /bin/cardano-cli
RUN mkdir /home/cardano
WORKDIR /home/cardano

#Topology updater download
RUN curl -s -o topologyUpdater.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/topologyUpdater.sh && \
curl -s -o env https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/env && \
chmod 750 topologyUpdater.sh

# Add the cron job
RUN crontab -l | { cat; echo "* * * * * cd /home/cardano && bash topologyUpdater.sh > /proc/1/fd/1 2>&1"; } | crontab -

#Cron
RUN chmod 0644 topologyUpdater.sh

# Run the command on container startup
COPY scripts /scripts
CMD ["bash", "/scripts/start.sh"]
