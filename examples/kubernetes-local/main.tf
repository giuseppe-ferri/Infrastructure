provider "kubernetes" {
  config_path = "/home/gferri/.kube/config"
  config_context = "minikube"
}

module "enginx_app" {
  source = "../../modules/services/k8s-app"

  name           = "nginx-app"
  image          = "cr.io/k8s-minikube/kicbase:v0.0.46" //nginx
  replicas       = 2
  container_port = 80
}