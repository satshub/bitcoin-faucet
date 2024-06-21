#!/bin/bash

# 检查 Node.js 版本
NODE_VERSION_REQUIRED="18.18.2"
node_version=$(node -v 2>/dev/null)

if [[ $? -ne 0 ]]; then
  echo "Node.js 未安装。"
else
  if [[ $node_version == v$NODE_VERSION_REQUIRED ]]; then
    echo "Node.js 版本为 $NODE_VERSION_REQUIRED。"
  else
    echo "Node.js 版本为 $node_version，不是 $NODE_VERSION_REQUIRED。"
    exit 1
  fi
fi

# 检查 Yarn 是否安装
if command -v yarn >/dev/null 2>&1; then
  echo "Yarn 已安装。"
else
  echo "Yarn 未安装。"
  exit 1
fi

# 检查 TypeScript 编译器 (tsc) 是否安装, 4.5.4版本是可行的
if command -v tsc >/dev/null 2>&1; then
  echo "TypeScript 编译器 (tsc) 已安装。"
else
  echo "TypeScript 编译器 (tsc) 未安装。"
  exit 1
fi

yarn install

cp ./src/config.example.ts ./src/config.ts

# 该index.d.ts 文件中的ObjectID没有实现; tsc编译的时候，会报错，需要删掉；
sed -i "s/ObjectID,//g" "node_modules/@types/mongodb/index.d.ts"

tsc

docker build -t sathub-faucet .
