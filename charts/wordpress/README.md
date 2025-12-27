# WordPress Helm Chart

A Helm chart for deploying WordPress on Kubernetes with MariaDB.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure

## Installation

```bash
helm install my-release .
```

## Configuration

The following table lists the configurable parameters of the WordPress chart and their default values.

### Global parameters

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `replicaCount` | Number of WordPress replicas | `1` |
| `image.repository` | WordPress image repository | `wordpress` |
| `image.tag` | WordPress image tag (overrides `appVersion`) | `""` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `imagePullSecrets` | Secret names for private registries | `[]` |
| `nameOverride` | String to partially override wordpress.fullname | `""` |
| `fullnameOverride` | String to fully override wordpress.fullname | `""` |

### Service Account parameters

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `serviceAccount.create` | Create a service account | `true` |
| `serviceAccount.automount` | Automount API credentials | `true` |
| `serviceAccount.annotations` | Annotations for the service account | `{}` |
| `serviceAccount.name` | Name of the service account | `""` |

### Ingress parameters

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `ingress.enabled` | Enable ingress controller resource | `false` |
| `ingress.className` | Ingress Class name | `""` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress host configuration | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` |
| `ingress.tls` | Ingress TLS configuration | `[]` |

### Gateway API (HTTPRoute) parameters

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `httpRoute.enabled` | Enable HTTPRoute resource | `false` |
| `httpRoute.parentRefs` | Gateways to attach to | `[{"name":"gateway","sectionName":"http"}]` |
| `httpRoute.hostnames` | Hostnames for the route | `["chart-example.local"]` |
| `httpRoute.rules` | Rules for the route | `[{"matches":[{"path":{"type":"PathPrefix","value":"/headers"}}]}]` |

### WordPress parameters

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `wordpress.serverName` | Hostname for WordPress | `localhost` |
| `wordpress.existingSecret` | Name of an existing secret containing DB credentials | `""` |
| `wordpress.persistence.enabled` | Enable persistence | `true` |
| `wordpress.persistence.accessModes` | Persistence access modes | `["ReadWriteOnce"]` |
| `wordpress.persistence.size` | Persistence size | `10Gi` |
| `wordpress.persistence.storageClass` | Storage class for persistence | `nil` |

### MariaDB parameters

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `mariadb.replicaCount` | Number of MariaDB replicas | `1` |
| `mariadb.image.repository` | MariaDB image repository | `mariadb` |
| `mariadb.image.tag` | MariaDB image tag | `12.1.2` |
| `mariadb.auth.database` | Name of the database | `wordpress` |
| `mariadb.auth.username` | Database username | `wordpress` |
| `mariadb.storage.size` | MariaDB persistence size | `10Gi` |

### Probes and Resources

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `livenessProbe` | Liveness probe configuration | (see values.yaml) |
| `readinessProbe` | Readiness probe configuration | (see values.yaml) |
| `resources` | Pod resource limits and requests | `{}` |
| `autoscaling.enabled` | Enable horizontal pod autoscaling | `false` |

Refer to `values.yaml` for the full list of configurable parameters and their documentation.

## Persistence

The chart provides persistence for:
- MariaDB data
- WordPress uploads, themes, and plugins (`/var/www/html`)

## Gateway API Support

This chart includes optional support for Kubernetes Gateway API via `httpRoute`. Ensure you have a Gateway API compatible controller installed.

## License

This project is licensed under the GNU General Public License v2.0 - see the [LICENSE](LICENSE) file for details.
