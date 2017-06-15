#! /bin/bash
geth \
  --identity "TestNode" \
  --rpc \
  --rpcport "8000" \
  --rpccorsdomain "*" \
  --datadir "~/data" \
  --port "30303" \
  --nodiscover \
  --rpcapi "db,eth,net,web3" \
  --networkid 1999 \
  --ipcdisable \
  console

