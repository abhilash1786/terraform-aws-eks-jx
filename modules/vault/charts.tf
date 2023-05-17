resource "helm_release" "vault-operator" {
  count            = local.create_vault_resources ? 1 : 0
  name             = "vault-operator28"
  chart            = "vault-operator28"
  namespace        = "jx-vault"
  repository       = "https://kubernetes-charts.banzaicloud.com"
  version          = "1.14.3"
  create_namespace = true
}

resource "helm_release" "vault-instance" {
  count      = local.create_vault_resources ? 1 : 0
  name       = "vault-instance28"
  chart      = "vault-instance28"
  namespace  = "jx-vault"
  repository = "https://jenkins-x-charts.github.io/repo"
  version    = "1.0.24"
  depends_on = [helm_release.vault-operator]
  set {
    name  = "ingress.enabled"
    value = "false"
  }
}
