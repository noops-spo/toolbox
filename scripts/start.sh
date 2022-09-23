nohup python3 /scripts/monitor-topoupdater.py &
while true
do
    bash topologyUpdater.sh
    sleep 3600
done
