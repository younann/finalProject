# DevSecOps Pipeline Project

Welcome to my DevSecOps Pipeline Project! This project demonstrates a comprehensive implementation of DevSecOps principles through a practical Python web application with a complete CI/CD pipeline that integrates security at every stage.

## Project Overview

This project showcases how to implement DevSecOps practices by:

- Building a secure Python web application
- Setting up automated security testing
- Creating a robust CI/CD pipeline with Jenkins
- Deploying to AWS using Terraform and Kubernetes
- Implementing monitoring and security controls

## Key Components

- **Python Web Application**: A secure web application built with modern Python practices
- **Docker Containerization**: Consistent deployment environments
- **AWS Infrastructure**: Cloud-based deployment using Terraform
- **Kubernetes Orchestration**: Container management and scaling
- **Jenkins Pipeline**: Automated CI/CD workflow with security gates
- **Security Testing**: Integrated security scanning and testing

## Getting Started

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd finalproj
   ```

2. **Set Up Local Development Environment**

   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. **Run the Application Locally**

   ```bash
   python -m app.main
   ```

4. **Run Tests**
   ```bash
   python -m pytest tests/
   ```

## Docker Support

Build and run the application using Docker:

```bash
docker build -t python-devsecops .
docker run -p 8000:8000 python-devsecops
```

## AWS Deployment

### Configure AWS CLI

```bash
aws configure
```

Enter your AWS credentials when prompted:

```
AWS Access Key ID: [Your Access Key]
AWS Secret Access Key: [Your Secret Key]
Default region name: us-west-2
Default output format: json
```

### Deploy with Terraform

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Verify Kubernetes Deployment

```bash
kubectl get pods -n default
```

## CI/CD Pipeline with Jenkins

The project includes a complete Jenkins pipeline that automates the entire deployment process.

### Jenkins Setup

```bash
sudo apt update -y
sudo apt install openjdk-11-jdk

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install jenkins -y

sudo systemctl start jenkins
sudo systemctl enable jenkins
```

### Pipeline Stages

The Jenkinsfile defines a complete pipeline with the following stages:

1. **Connect to AWS**: Authenticate with AWS services
2. **Build Docker Image**: Create a containerized version of the application
3. **Run Unit Tests**: Execute automated tests with security checks
4. **Push to ECR**: Upload the Docker image to Amazon ECR
5. **Deploy Infrastructure**: Run Terraform to provision AWS resources
6. **Deploy to Kubernetes**: Deploy the application to a Kubernetes cluster
7. **Post-Deployment Tests**: Verify the deployment and run security scans
8. **Resource Cleanup**: Optional stage to destroy resources when needed

## Security Features

- Dependency scanning for vulnerabilities
- SAST (Static Application Security Testing)
- Container security scanning
- Infrastructure as Code security validation
- Input validation and sanitization
- Secrets management
- Compliance checks

## Development Guidelines

- Follow Python PEP 8 style guide
- Write unit tests for new features
- Perform security testing before submitting PRs
- Keep dependencies updated
- Document code changes

## Project Structure

```
finalproj/
├── app/                # Python web application
├── tests/              # Test suite
├── Dockerfile          # Container definition
├── Jenkinsfile         # CI/CD pipeline definition
├── terraform/          # IaC for AWS resources
├── kubernetes/         # K8s deployment manifests
├── requirements.txt    # Python dependencies
└── README.md           # This file
```

## Future Enhancements

- Implement advanced monitoring with Prometheus and Grafana
- Add automated vulnerability management
- Integrate compliance as code
- Expand test coverage
- Add blue/green deployment strategy
