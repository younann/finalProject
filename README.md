# Final Project for DevSecOps Course

Welcome to the final project for the DevSecOps course! This project aims to integrate development, security, and operations practices to create a seamless workflow that enhances software delivery while ensuring security at every stage.

## Project Overview

In this project, we will demonstrate how to implement DevSecOps principles by automating security checks, integrating security tools into the CI/CD pipeline, and fostering a culture of security awareness among team members.

## Key Features

- **Automated Security Testing**: Incorporate tools that automatically test for vulnerabilities in the codebase.
- **Continuous Integration/Continuous Deployment (CI/CD)**: Set up a CI/CD pipeline that includes security checks at every stage.
- **Monitoring and Logging**: Implement monitoring solutions to track application performance and security incidents.
- **Collaboration**: Encourage collaboration between development, security, and operations teams to ensure security is a shared responsibility.

## Features

- **Python Web Application**: A secure web application built using modern Python practices
- **Containerization**: Docker configuration for consistent deployment environments
- **Automated Testing**: Comprehensive test suite with unit and integration tests
- **Security Controls**: Built-in security measures and best practices
- **CI/CD Integration**: Ready-to-use pipeline configurations

## Getting Started

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd <project-directory>
   ```

2. **Set Up Local Development Environment**

   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. **Run the Application**

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

## Terraform script

Connecting to AWS

run
```bash
aws configure
```

```bash
AWS Access Key ID: AKI**********8***
AWS Secret Access Key: ***************************
Default region name: us-west-2
Default output format: json
```

initiate terraform
```bash
terraform init
terraform plan
terraform apply -auto-approve
```
Verify the deployment

```bash
kubectl get pods -n default
```

aws configure


## Jenkins(CI/CD)

Create an AWS instance to run Jenkins-server

Install Java and Jenkins
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


Create a jenkinsfile to run deployment

## Stages:

Connect to AWS ->Build docker image -> Run Unit Tests-> Push it to ECR -> Run Terrform to create resource (Optional) -> Deploy to Kubernetes -> Post-Deployment Test -> Destroy all Resources (Optional)




## Security Features

- Dependency scanning for vulnerabilities
- Secure coding practices implementation
- Container security scanning
- Automated security testing
- Input validation and sanitization

## Development Guidelines

- Follow Python PEP 8 style guide
- Write unit tests for new features
- Perform security testing before submitting PRs
- Keep dependencies updated
- Document code changes

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Conclusion

This project serves as a practical application of the concepts learned throughout the DevSecOps course, showcasing the importance of integrating security into the software development lifecycle.

We hope you find this project insightful and beneficial for your future endeavors in the field of DevSecOps!
