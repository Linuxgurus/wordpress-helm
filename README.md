# WordPress Helm Chart

A comprehensive Helm chart for deploying WordPress on Kubernetes, including MariaDB as the database backend. This chart simplifies the deployment, scaling, and management of WordPress instances.

## Table of Contents

- [WordPress Helm Chart](#wordpress-helm-chart)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Project Structure](#project-structure)
  - [Installation](#installation)
    - [From Helm Repository (Recommended)](#from-helm-repository-recommended)
    - [From Source](#from-source)
      - [1. Clone the repository](#1-clone-the-repository)
      - [2. Install the chart](#2-install-the-chart)
    - [3. Verify the deployment](#3-verify-the-deployment)
  - [Configuration](#configuration)
  - [Persistence](#persistence)
  - [Exposure](#exposure)
    - [Ingress](#ingress)
    - [Gateway API (HTTPRoute)](#gateway-api-httproute)
  - [Contributing](#contributing)
  - [License](#license)

## Overview

This repository contains a Helm chart that deploys:
- **WordPress**: The world's most popular website builder and CMS.
- **MariaDB**: An open-source relational database to store WordPress data.

The chart is designed to be flexible, supporting various ingress options, persistence settings, and auto-scaling.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (optional but recommended for persistence)

## Project Structure

```text
.
├── chart/              # Main Helm chart directory
│   ├── charts/         # Subcharts (if any)
│   ├── templates/      # Kubernetes manifest templates
│   ├── Chart.yaml      # Chart metadata
│   ├── values.yaml     # Default configuration values
│   └── README.md       # Chart-specific documentation
├── AppInfo.txt         # Application metadata for build processes
├── CODE_OF_CONDUCT.md  # Community guidelines
├── CONTRIBUTING.md     # Contribution guidelines
├── LICENSE             # Project license
└── README.md           # Root documentation (this file)
```

## Installation

### From Helm Repository (Recommended)

To install this chart using Helm:

```bash
helm repo add wordpress http://linuxgurus.github.io/wordpress
helm install my-wordpress wordpress/wordpress
```

### From Source

#### 1. Clone the repository

```bash
git clone https://github.com/Linuxgurus/wordpress-helm.git
cd wordpress-helm
```

#### 2. Install the chart

To install the chart with the release name `my-wordpress`:

```bash
helm install my-wordpress ./charts/wordpress
```

### 3. Verify the deployment

```bash
kubectl get pods
```

## Configuration

The following table lists the configurable parameters of the WordPress chart and their default values. You can override these values by creating a `my-values.yaml` file or using the `--set` flag.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of WordPress replicas | `1` |
| `image.repository` | WordPress image repository | `wordpress` |
| `image.tag` | WordPress image tag | (appVersion in Chart.yaml) |
| `service.type` | Kubernetes Service type | `ClusterIP` |
| `wordpress.serverName` | Hostname for the WordPress site | `localhost` |
| `mariadb.storage.size` | MariaDB persistent volume size | `10Gi` |
| `wordpress.persistence.size` | WordPress persistent volume size | `10Gi` |

For more detailed configuration, please refer to the [values.yaml](./charts/wordpress/values.yaml) file.

## Persistence

By default, the chart creates Persistent Volume Claims (PVCs) for both WordPress and MariaDB to ensure data persistence across pod restarts. You can customize the storage class and size in the `values.yaml` file.

## Exposure

### Ingress
You can enable Ingress to expose WordPress externally:
```yaml
ingress:
  enabled: true
  hosts:
    - host: wordpress.example.com
      paths:
        - path: /
```

### Gateway API (HTTPRoute)
This chart also supports the Kubernetes Gateway API:
```yaml
httpRoute:
  enabled: true
  hostnames:
    - wordpress.example.com
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to get started.

## License

This project is licensed under the terms of the LICENSE file included in this repository.
