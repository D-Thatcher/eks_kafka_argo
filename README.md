# Self-hosted Kafka Cluster using the Strimzi Operator integrated with ArgoCD

## Getting started
- ensure the following cli tools are up-to-date `aws-cli`, `kubectl`, `terrarform`
- deploy an Elastic Kubernetes Cluster: `make deploy_infrastructure`
- authenticate to your cluster: `make auth_kubectl`
- confirm your access: `kubectl get nodes`
- port-forward the Argo UI: `make proxy_argo`
- in a sepeparate terminal, get your argo user password: `make get_argo_secret`
- in a browser, visit `https://localhost:8080` and login in with the user `admin` and your password
- to deploy a test NGINX app: `make deploy_example_app`
    - it'll populate the app on the Argo UI, and you  can view its exernal service's URL with: `make get_example_app_url`
    - remove the example app: `make remove_example_app`
- deploy the Strimzi Kafka Operator: `make deploy_kafka_operator`
- deploy an example Kafka cluster: `make deploy_kafka_cluster`

## PVC Issue
There's a known Argo + Strimzi [issue](https://github.com/orgs/strimzi/discussions/7205) with incorrectly reporting the state of the PVCs 
To mitigate this, we've disabled auto-pruning for this Application. Do not manually prune the PVC even though Argo says it's out-of-sync.
![Image of Kafka Cluster](/assets/cluster.png)

## Test Kafka Producer + Consumer
- run `make produce_messages` to create a producer pod that will connect to the Kafka Cluster
- type some messages in the terminal like this:
![Image of Producer](/assets/producer.png)
- run `make consume_messages` to create a consumer pod that will connect to the Kafka Cluster
- the previous messages will appear in the terminal:
![Image of Consumer](/assets/consumer.png)

## Clean up
- clean up all resources, including the underlying kubernetes cluster: `make clean`

# Links
- [Strimzi Operator](https://strimzi.io/quickstarts/)