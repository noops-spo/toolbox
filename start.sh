apt-get install -yqq chron
crontab -l | { cat; echo "0 * * * * docker exec cardano-relay ./scripts/topologyUpdater.sh > /var/log/cardano.log"; } | crontab -
