#!/bin/bash

NODE_IMAGE=ubuntu:20.04
NETWORK_NAME=kubernetes-the-hard-way

docker network delete $NETWORK_NAME

for i in 0 1 2; do
    docker stop master-${i}
done


handle_nodes() {
    node_type=$1
    for i in 0 1 2; do
        docker stop $node_type-${i}
    done

    for i in 0 1 2; do
        docker run --rm \
            --name "$node_type-${i}" \
            --hostname "$node_type-${i}" \
            --network $NETWORK_NAME \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -d \
            $NODE_IMAGE /sbin/init
        done
}

handle_nodes master
handle_nodes worker
