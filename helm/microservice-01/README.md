# Werf Template for k8s Deployment

### Contains:
- Several Containers in the One Pod
- Service with several ports 
- Ingress (internal or external)
- Autoscaling
- HTTPS certificates (selfsigned or letsencrypt)

### Using in the same project with Werf:
- Add Oft-e Helm repo if is not have it
   + `helm repo list` - see list of the repos
   + `helm repo add oft-e https://docker.oft-e.com/chartrepo/helm --username ucni --password Ucni1736` - add repo
- Create the folder `mkdir .helm` in the project dir
- Make **values** from this template: `helm show values oft-e/microservice-01 > .helm/values.yaml`
- Edit `.helm/values.yaml` file according to your needs
- Create `.helm/Chart.yaml` file like this:


      apiVersion: v2
      name: mychart
      maintainers:
      - name: Oft-e
        email: admin@corp.oft-e.com

      dependencies:
      - name: microservice-01
        version: 1.0
        repository: "https://docker.oft-e.com/chartrepo/helm"
        export-values:
          - parent: werf
            child: werf
          - parent: deployment
            child: deployment
          - parent: pod
            child: pod
          - parent: ingress
            child: ingress
          - parent: cert
            child: cert

- Run this `werf helm dependency update .helm/` for update dependences
- Add this line **.helm/charts/*** to the **.gitignore** file: `echo ".helm/charts/*" >> .gitignore`



See more details: https://werf.io
 
