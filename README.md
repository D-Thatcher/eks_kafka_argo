# EKS_KAFKA_STARTER
## Getting started
- ensure the following cli tools are up-to-date `aws-cli`, `kubectl`, `terrarform`
- deploy an Elastic Kubernetes Cluster: `make deploy_infrastructure`
- authenticate to your cluster: `make auth_kubectl`
- confirm your access: `kubectl get nodes`
- port-forward the Argo UI: `make proxy_argo`
- in a sepeparate terminal, get your argo user password: `get_argo_secret`
- in a browser, visit `https://localhost:8080` and login in with the user `admin` and your password
- to deploy a test NGINX app: `make deploy_example_app`
    - it'll populate the app on the Argo UI, and you  can view its exernal service's URL with: `make get_example_app_url`
    - remove the example app: `make remove_example_app`
- deploy the Strimzi Kafka Operator: `make deploy_kafka_operator`
- deploy an example Kafka cluster: `make deploy_kafka_cluster`
- clean up all resources, including the underlying kubernetes cluster: `make clean`