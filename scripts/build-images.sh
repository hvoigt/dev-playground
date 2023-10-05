#!/bin/bash

(cd kubernetes-the-hard-way-on-docker &&
    (
        cd images/haproxy &&
        docker build -t k8s-haproxy .
    ) &&
    (
        cd images/k8s-ready &&
        docker build -t k8s-ready .
    )
)
