# Akamai Datastream 2 Kafka Connector

## 1. Introduction
Customers want to access, analyze and process their logs to build reports, dashboards or even to get insights in 
real-time to take actions in a fast manner.

What if we could provide an easier and robust way to collect this data?

That's what you'll get here!

This application provides a reliable and scalable way to collect the Akamai CDN logs through Akamai Datastream 2 and 
easily store it into analytics platforms.

## 2. Maintainers
- [Felipe Vilarinho](https://www.linkedin.com/in/fvilarinho)

If you want to collaborate in this project, reach out us by e-Mail.

You can also fork and customize this project by yourself once it's opensource. Follow the requirements below to set up 
your build environment.

## 3. Requirements

### To package and publish
- [`Docker 24.x or later`](https://www.docker.com)
- `Any linux distribution with Kernel 5.x or later` or
- `MacOS - Catalina or later` or
- `MS-Windows 10 or later with WSL2`
- `Dedicated machine with at least 4 CPU cores and 8 GB of RAM`

Just execute the shell script `package.sh` to start the packaging, and execute`publish.sh` to publish the built packages
in the repository.

The following variables must be set in your build environment file that is located in `iac/.env`.

- `DOCKER_REGISTRY_URL`: Define the Docker Registry Repository URL to build and store the container images. (For 
example, to use [Docker HUB](https://hub.docker.com), the value will be `docker.io`. To use 
[GitHub Packages]('https://github.com'), the value will be `ghcr.io`. Please check the instructions of your Docker 
Registry repository).
- `DOCKER_REGISTRY_ID`: Define the Docker Registry Repository Identifier (Usually it's the username, but check the 
instructions of your Docker Registry repository).
- `IDENTIFIER`: Define the identifier (prefix) of the container images.
- `BUILD_VERSION`: Define the version of the container images.

The following environment variable must be set in your operating system.
- `DOCKER_REGISTRY_PASSWORD`: Define the Docker Registry Repository Password.

### To deploy
Just execute the shell script `deploy.sh` (after the setup) to start the provisioning, and execute `undeploy.sh` for
de-provisioning.

After the provisioning is complete, just execute the following commands:
- `export KUBECONFIG=iac/.kubeconfig` to specify how you'll connect in the LKE cluster.
- `kubectl get nodes -o wide` to list the LKE cluster nodes.
- `kubectl get pods -n <namespace> -o wide` to get the details of stack pods.

The ingest URL will be: `https://<load-balancer-ingest-events>/ingest`. 

To view the events ingested, just open your browser and type the URL: `https://<load-balancer-ingest-events>/events`.

Both URLs are protected by authentication.

To access the administration UI, just open your browser and type the URL: `https://<load-balancer-admin>:9443` and the 
login prompt will appear.

## 4. Settings
If you want to customize the stack by yourself, just edit the following files in the `iac` directory:
- `main.tf`: Defines the required provisioning providers.
- `variables.tf`: Defines the specification of the provisioning variables.
- `terraform.tfvars`: Defines the content of the provisioning variables.
- `auth.tf`: Defines the authentication of the stack.
- `certificates.tf`: Defines the TLS certificates of the stack.
- `linode.tf`: Defines how you connect in Akamai Cloud Computing to start the provisioning.
- `linode-lke.tf`: Defines the provisioning of the LKE cluster.
- `linode-lke-stack.tf`: Defines the provisioning of the stack in LKE cluster.
- `linode-lke-storages.yml`: Defines how the stack storages (Block Storage) will be deployed in LKE cluster. 
- `linode-lke-stack-deployments.yml`: Defines how the stack pods will be deployed in LKE cluster.
- `linode-lke-stack-services.yml`: Defines how the stack services will be deployed in LKE cluster.
- `docker-compose.yml`: Defines how the stack will be built.

## 5. Other resources
- [`Akamai Techdocs`](https://techdocs.akamai.com)
- [`Akamai Cloud Computing`](https://www.linode.com)

And that's it! Have fun!