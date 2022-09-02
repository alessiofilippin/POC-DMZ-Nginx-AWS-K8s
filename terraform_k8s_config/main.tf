# Private Nginx using Cluster IP
data "kubectl_path_documents" "docs_private_nginx_ingress" {
    pattern = "${path.module}/yamls/nginx_priv.yml"
}

resource "kubectl_manifest" "deploy_private_nginx" {
    count     = length(data.kubectl_path_documents.docs_private_nginx_ingress.documents)
    yaml_body = element(data.kubectl_path_documents.docs_private_nginx_ingress.documents, count.index)
}

# Public Nginx Ingress using AWS LB SVC
data "kubectl_path_documents" "docs_public_nginx_ingress" {
    pattern = "${path.module}/yamls/nginx_pub.yml"
}

resource "kubectl_manifest" "deploy_public_nginx_ingress" {
    count     = length(data.kubectl_path_documents.docs_public_nginx_ingress.documents)
    yaml_body = element(data.kubectl_path_documents.docs_public_nginx_ingress.documents, count.index)

    depends_on = [
      kubectl_manifest.deploy_private_nginx
    ]
}
