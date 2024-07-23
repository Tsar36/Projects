# Kubernetes Deployment with Kustomize

This repository contains Kubernetes configurations for deploying your application across different environments using Kustomize. The environments include development, staging, and production.

## Prerequisites

- Kubernetes cluster (minikube, GKE, EKS, AKS, etc.)
- `kubectl` command-line tool installed and configured to communicate with your cluster.
- `kustomize` (included in `kubectl` v1.14+)

## Directory Structure
```
.k8s/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
├── overlays/
│   ├── dev/
│   │   ├── kustomization.yaml
│   │   └── migration-configmap.yaml
│   ├── stage/
│   │   └── kustomization.yaml
│   └── prod/
│       └── kustomization.yaml
└── README.md
```

## Base Configuration

The base configuration includes the general deployment and service definitions for your application.

- **k8s/base/deployment.yml**: Defines the deployment of your application.
- **k8s/base/service.yml**: Defines the service to expose your application.
- **k8s/base/kustomization.yml**: Kustomize file to manage base resources.

## Development Overlay

The development overlay extends the base configuration to include database migration processing.

- **k8s/overlays/dev/migration-configmap.yml**: ConfigMap containing the migration script.
- **k8s/overlays/dev/kustomization.yml**: Kustomize file to add the InitContainer for database migrations.

## Staging Overlay

The staging overlay extends the development configuration to include additional settings such as replicas and readiness probes.

- **k8s/overlays/stage/kustomization.yml**: Kustomize file to set replicas to 2 and add a readiness probe.

## Production Overlay

The production overlay extends the staging configuration by removing the database migration processing.

- **k8s/overlays/prod/kustomization.yml**: Kustomize file to remove the InitContainer for database migrations.

## Applying Configurations

To apply the configurations for a specific environment, navigate to the respective directory and run the following command:

### Development

```sh
kubectl apply -k overlays/dev
```
### Staging

```sh
kubectl apply -k overlays/stage
```
### Production

```sh
kubectl apply -k overlays/prod
```

## Explanation

	•	Base Deployment and Service: Defined in the base directory.
	•	Dev Overlay: Adds an InitContainer to handle database migrations.
	•	Stage Overlay: Extends the dev overlay by setting replicas to 2 and adding a readiness probe.
	•	Prod Overlay: Extends the stage overlay by removing the InitContainer used for database migrations.


# Notes

	•	Ensure that the Docker images (my-app-image:latest and my-db-migration-image:latest) are available in the container registry accessible by your Kubernetes cluster.
	•	Modify the command field in 'db-migration.yaml' to match your actual database migration command. For example, using a custom migration script:

## Cleanup

To delete the resources created by this Kustomization, run:
```
kubectl delete -k ./base
kubectl delete -k ./overlays/staging
kubectl delete -k ./overlays/production
```

# Conclusion

This setup helps manage a Kubernetes deployment along with a database migration job for development and staging environments using Kustomize. The production environment is configured without the database migration job. Feel free to adjust the configuration files to suit your specific requirements.

P.S. 
In the folder 'scripts' are a few examples of migrate.sh scripts for different scenarios. These scripts assume that the necessary tools are installed in the Docker image and the environment variables are set appropriately.

## :)
