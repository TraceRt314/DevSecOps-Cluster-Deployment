# DevSecOps-Cluster-Deployment

<p align="center">
  <a href="https://github.com/huzmgod/DevSecOps-Cluster-Deployment/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/huzmgod/DevSecOps-Cluster-Deployment?style=for-the-badge&logo=github" alt="License">
  </a>
  <a href="https://github.com/huzmgod/DevSecOps-Cluster-Deployment/issues">
    <img src="https://img.shields.io/github/issues/huzmgod/DevSecOps-Cluster-Deployment?style=for-the-badge&logo=github" alt="Issues">
  </a>
  <a href="https://github.com/huzmgod/DevSecOps-Cluster-Deployment/pulls">
    <img src="https://img.shields.io/github/issues-pr/huzmgod/DevSecOps-Cluster-Deployment?style=for-the-badge&logo=github" alt="Pull Requests">
  </a>
</p>

## Description

Welcome to the **DevSecOps-Cluster-Deployment** monorepo. This repository is designed to provide a comprehensive solution for deploying and managing DevSecOps clusters and tools. Utilizing Infrastructure as Code (IaC), Ansible, Python, and various other technologies, this repo supports the deployment of AKS, EKS, and bare-metal environments. It also includes scripts for cluster setup, tool installation, security hardening, and monitoring.

## Tech Stack

- **Infrastructure as Code (IaC):** Terraform
- **Configuration Management:** Ansible
- **Scripting:** Python, Bash
- **Cloud Providers:** Azure AKS, AWS EKS

## Essential Tools

- **Monitoring Tools:** Prometheus, Grafana
- **CI/CD Tools:** Jenkins, GitHub Actions, GitLab CI, ArgoCD
- **Backup Tools:** Velero
- **Defect Management Tools:** DefectDojo
- **Dependency Management Tools:** Dependency-Track, Dependabot
- **Image Security Tools:** Trivy
- **Secret Management Tools:** Vault

## Repository Structure

```plaintext
DevSecOps-Cluster-Deployment/
├── README.md
├── .github/
│   ├── workflows/
│   │   ├── aks-deployment.yml
│   │   ├── eks-deployment.yml
│   │   ├── bare-metal-deployment.yml
│   │   ├── tools-installation.yml
│   │   ├── cluster-security.yml
│   │   ├── monitoring-setup.yml
├── infrastructure/
│   ├── aks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   ├── bare-metal/
│   │   ├── ansible/
│   │   │   ├── playbooks/
│   │   │   │   ├── cluster-setup.yml
│   │   │   │   ├── node-configuration.yml
│   │   │   │   ├── README.md
├── tools/
│   ├── installation/
│   │   ├── prometheus/
│   │   │   ├── install-prometheus.yml
│   │   │   ├── README.md
│   │   ├── grafana/
│   │   │   ├── install-grafana.yml
│   │   │   ├── README.md
│   │   ├── README.md
├── security/
│   ├── hardening/
│   │   ├── aks-hardening.yml
│   │   ├── eks-hardening.yml
│   │   ├── bare-metal-hardening.yml
│   │   ├── README.md
├── monitoring/
│   ├── prometheus/
│   │   ├── prometheus-config.yml
│   │   ├── README.md
│   ├── grafana/
│   │   ├── grafana-config.yml
│   │   ├── README.md
├── scripts/
│   ├── python/
│   │   ├── cluster_health_check.py
│   │   ├── security_audit.py
│   │   ├── README.md
│   ├── bash/
│   │   ├── deploy.sh
│   │   ├── cleanup.sh
│   │   ├── README.md
```

## Workflows

### .github/workflows

1. **aks-deployment.yml:** Workflow for AKS cluster deployment.
2. **eks-deployment.yml:** Workflow for EKS cluster deployment.
3. **bare-metal-deployment.yml:** Workflow for bare-metal cluster deployment.
4. **tools-installation.yml:** Workflow for installing tools like Prometheus, Grafana, etc.
5. **cluster-security.yml:** Workflow for security hardening of clusters.
6. **monitoring-setup.yml:** Workflow for setting up monitoring tools.

## Contribution Guidelines

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/huzmgod/DevSecOps-Cluster-Deployment/blob/master/LICENSE) file for details.

## Contact

For any issues, questions, or suggestions, please open an issue in this repository.