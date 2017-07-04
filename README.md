# ethbase
A boilerplate development environment for Ethereum. Note: due to some known issues with `pyethereum` and some of its dependencies, you may see some warnings during the docker build. If you believe any of theses wanrings or errors are causing problems, please create a github issue.

# Usage

## Requirements

 * [git](https://git-scm.com/) to clone this repo
 * [Docker](https://www.docker.com/community-edition). If you haven't used Docker, it may be worth it to follow the [getting started](https://docs.docker.com/get-started/) guide.

## Installation
Ensure the docker daemon is running and execute these commands in the shell:
```
git pull https://github.com/Marto32/ethbase.git
cd ethbase
docker build -t ethereum/dev .
```

## Run the container
### Pyethapp
If you want to run the container and use the `pyethapp` console, run the following commands:
```
docker run -it --entrypoint /bin/bash -p 30304:30303 pyethapp/dev:bash
# Once in the container:
$ cd /apps/pyethapp
$ pyethapp account new
$ pyethapp -d /data --profile testnet run --console
```

### Jupyter
If you want to run the container to prototype applications that use the ethereum blockchain, run:
```
docker run -it -p 8888:8888 ethereum/dev
```

## Etherscan
Within the Jupyter notebook, you can use the [etherscan apis](https://etherscan.io/apis) to build scripts that interact with the blockchain.

# Removal
To remove containers and images ensure you're in your local bash environment and run:
```
docker rm $(docker ps -aq)
docker rmi $(docker images -aq)
```

That's it!

# Ethereum packages installed

 * [pyethapp](https://github.com/ethereum/pyethapp)
 * [pyethereum](https://github.com/ethereum/pyethereum)
 * [pyrlp](https://github.com/ethereum/pyrlp)
 * [pydevp2p](https://github.com/ethereum/pydevp2p)

# Misc Info
You can find tutorials on the [main ethereum page](https://ethereum.org/) and information about Solitiy (the most widely supported high-level contract language) [here](https://solidity.readthedocs.io/en/latest/).
