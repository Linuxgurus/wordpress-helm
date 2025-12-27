locals {
  hosts = concat([var.hostname], var.extra_hostnames)
  helm_values = {
    wordpress = {
      serverName = var.hostname
    }
    ingress = {
      enabled   = true
      className = var.ingress_class
      annotations = {
        "cert-manager.io/cluster-issuer"            = var.cert_issuer
        "external-dns.alpha.kubernetes.io/hostname" = var.hostname
        "nginx.ingress.kubernetes.io/proxy-body-size" = "32m"
      }
      hosts = [
        for host in local.hosts : {
          host = host
          paths = [
            {
              path     = "/"
              pathType = "Prefix"
            }
          ]
        }
      ]
      tls = [
        {
          secretName = "cert-${var.hostname}"
          hosts      = local.hosts
        }
      ]
    }
  }
}
