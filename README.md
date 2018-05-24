# Deploy Insight UI and komodod
Deploy 2 docker container komodod and Insight block explorer with KMD currency

### Dependencies

- git
- docker
- docker-compose

### Variables

Variables should be set in file local_env.sh

| Variable    | Description                                             | Default     | 
|-------------|---------------------------------------------------------|-------------|
| RPCUSER     | Username for RPC connection between Komodod and Insight | rpcuser     |
| RPCPASSWORD | Password for RPC connection between Komodod and Insight | rpcpassword |

### Start docker

This you need run:

```
docker-compose up
```
