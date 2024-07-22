# Kubernetes Deployment with DB Migration for Development, Staging, and Production

## Task:
* Create a basic k8s deployment for the application
* With the help of kustomization, expand by adding DB migration processing for dev
* Extend Stage from dev by adding replicas:2 and readinessProbe
* Prod to expand from stage by removing DB migration processing

This project sets up a basic Kubernetes deployment for an application and includes a database migration job for the development and staging environments using Kustomize. The production environment excludes the database migration job.

## Directory Structure
```
.
├── base
│   ├── deployment.yaml
│   ├── db-migration.yaml
│   ├── kustomization.yaml
├── overlays
│   ├── staging
│   │   ├── kustomization.yaml
│   │   ├── deployment-patch.yaml
│   ├── production
│   │   ├── kustomization.yaml
└── README.md
```

## Files

- **base**:
  - `deployment.yaml`: Defines the main application deployment.
  - `db-migration.yaml`: Defines a job to handle database migration.
  - `kustomization.yaml`: Kustomize configuration for the base resources.
- **overlays/staging**:
  - `deployment-patch.yaml`: Patch for staging to set replicas and readiness probe.
  - `kustomization.yaml`: Kustomize configuration for staging overlay.
- **overlays/production**:
  - `kustomization.yaml`: Kustomize configuration for production overlay, removing the DB migration job.
- `README.md`: This README file.

## Prerequisites

- Kubernetes cluster (minikube, GKE, EKS, AKS, etc.)
- `kubectl` command-line tool installed and configured to communicate with your cluster.
- `kustomize` (included in `kubectl` v1.14+)

## Instructions

### Apply Development Configuration

Navigate to the base directory and run:

```
kubectl apply -k ./base
```

## Apply Staging Configuration

Navigate to the staging overlay directory and run:
```
kubectl apply -k ./overlays/staging
```
## Apply Production Configuration

Navigate to the production overlay directory and run:
```
kubectl apply -k ./overlays/production
```

# Notes

	•	Ensure that the Docker images (my-app-image:latest and my-db-migration-image:latest) are available in the container registry accessible by your Kubernetes cluster.
	•	Modify the command field in db-migration-job.yaml to match your actual database migration command. For example, using a custom migration script:

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

Feel free to adjust the README further as needed! :)
