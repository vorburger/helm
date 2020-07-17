#!/usr/bin/env bash
#
# Install https://mojaloop.io using its released Helm charts from remote repo to a local minikube.
# Pre-requisits for this script: Working minikube + helm (for now; TODO containerize)
# Initially contributed by Michael http://Vorburger.ch

set -euox pipefail
cd "$(dirname "$0")"

minikube --profile=mojaloop start --kubernetes-version v1.15.12

minikube -p mojaloop addons enable ingress

helm init

./install-remote.sh
# TODO helm install --wait?

# TODO curl --header "Host: ml-api-adapter.local" $(minikube -p mojaloop ip)/health
# but needs a proper retry-loop... perhaps take from mini-loop if https://github.com/tdaly61/mini-loop/issues/2 clarified

# TODO after https://github.com/mojaloop/postman/issues/147 is clarified,
# add https://github.com/mojaloop/postman#5-running-inside-a-locally-deployed-kubernetes-cluster-of-mojaloop
