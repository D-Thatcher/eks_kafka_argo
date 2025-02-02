.ONESHELL:

deploy_infrastructure:
	cd infrastructure
	terraform init
	terraform apply

auth_kubectl:
	cd infrastructure
	aws eks --region $$(terraform output -raw region) update-kubeconfig --name $$(terraform output -raw cluster_name)

get_argo_secret:
	kubectl get secret argocd-initial-admin-secret  -n argocd --template={{.data.password}} | base64 --decode

proxy_argo:
	kubectl port-forward svc/argocd-server -n argocd 8080:443

deploy_kafka_operator:
	kubectl apply -f argo/kafka-operator.yaml

deploy_kafka_cluster:
	kubectl apply -f argo/kafka-cluster.yaml

remove_kafka_cluster:
	kubectl delete -f argo/kafka-cluster.yaml

deploy_example_app:
	kubectl apply -f argo/example.yaml

get_example_app_url:
	kubectl get svc -n example

remove_example_app:
	kubectl delete -f argo/example.yaml

produce_messages:
	kubectl -n kafka run kafka-producer -ti --image=quay.io/strimzi/kafka:0.45.0-kafka-3.9.0 --rm=true --restart=Never -- bin/kafka-console-producer.sh --bootstrap-server test-cluster-kafka-bootstrap:9092 --topic my-topic

consume_messages:
	kubectl -n kafka run kafka-consumer -ti --image=quay.io/strimzi/kafka:0.45.0-kafka-3.9.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server test-cluster-kafka-bootstrap:9092 --topic my-topic --from-beginning

clean:
	cd infrastructure
	terraform destroy