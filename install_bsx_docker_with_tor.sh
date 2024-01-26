#!/bin/bash

set -e

# Set the location of the coinswaps folder
export COINDATA_PATH=${HOME}/coinswaps

# Create the initial files and folder in the coinswap
mkdir -p $COINDATA_PATH/tor
touch $COINDATA_PATH/tor/torrc

# Get the BasicSwap repository
git clone https://github.com/tecnovert/basicswap.git
cd basicswap/docker

# Modify the tor Dockerfile
sed -i 's|CMD tor -f /etc/tor/torrc|CMD tor -f /etc/tor/torrc --allow-missing-torrc --SocksPort 0.0.0.0:9050|' tor/Dockerfile

# Modify the docker-compose file:
sed -i '/stop_grace_period: 5m/a \ \ \ \ \ \ \ \ depends_on:\n \ \ \ \ \ \ \ \ \ \ \ - tor' docker-compose_with_tor.yml

# Prepare the BasicSwap installation. 
# See the readme file https://github.com/tecnovert/basicswap/blob/master/doc/install.md for more info on how to add/remove more coins
docker compose -f docker-compose_with_tor.yml run -e TOR_PROXY_HOST=172.16.238.200 --rm swapclient \
        basicswap-prepare --usetorproxy --datadir=/coindata --withcoins=bitcoin,particl --usebtcfastsync
