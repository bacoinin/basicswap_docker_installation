# basicswap_docker_installation

## Run the "download_and_patch_bsx_docker_with_tor.sh" bash script that clones the BasicSwap DEX repo and patches the Tor Dockerfile and the docker-compose_with_tor.yml files

  chmod +x download_and_patch_bsx_docker_with_tor.sh
  ./download_and_patch_bsx_docker_with_tor.sh

## Next go to the basicswap/docker directory and run the BSX preparation via Tor as follows:

  docker compose -f docker-compose_with_tor.yml run -e TOR_PROXY_HOST=172.16.238.200 --rm swapclient \
        basicswap-prepare --usetorproxy --datadir=/coindata --withcoins=bitcoin,particl --usebtcfastsync

## When that is done, you can run the BSX DEX via Tor as follows:

  docker compose -f docker-compose_with_tor.yml up

For additional information/instructions see https://github.com/tecnovert/basicswap/blob/master/doc/tor.md
  
