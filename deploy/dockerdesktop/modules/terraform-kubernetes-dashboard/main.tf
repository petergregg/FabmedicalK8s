resource "kubernetes_namespace" "kubernetes_dashboard" {
  metadata {
    name = "kubernetes-dashboard"
  }
}

resource "helm_release" "kubernetes_dashboard" {
  depends_on = [
    kubernetes_namespace.kubernetes_dashboard
  ]
  name = "kubernetes-dashboard"
  namespace  = kubernetes_namespace.kubernetes_dashboard.id
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"

  set {
    name="extraArgs[0]"
    value = "--enable-skip-login"
  }
}

resource "kubernetes_service_account" "admin_user" {
  metadata {
    name = "admin-user"
    namespace = kubernetes_namespace.kubernetes_dashboard.id
  }
}

resource "kubernetes_cluster_role_binding" "example" {
  metadata {
    name = "admin-user"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.admin_user.metadata[0].name
    namespace = kubernetes_service_account.admin_user.metadata[0].namespace
  }
}