# AWS Terraform

This project uses Terraform to automate the deployment and management of AWS infrastructure. It includes configurations for multiple commonly used AWS services, making it suitable for both learning and production deployments.

## Prerequisites

1. [AWS Account](https://aws.amazon.com/)
2. [AWS CLI](https://aws.amazon.com/cli/) installed and configured
3. [Terraform](https://www.terraform.io/downloads.html) (recommended version >= 1.0.0)
4. Proper AWS credentials configuration

## Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd aws-terraform
   ```

2. Initialize Terraform:
   ```bash
   cd main
   terraform init
   ```

3. Review the deployment plan:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Configuration Details

### Network Configuration (network.tf)
- VPC configuration
- Public and private subnets
- Network ACLs and security groups

### EC2 Instances
- `ec2_vpn.tf` and `ec2_vpn_us.tf`: VPN server configurations
- `ec2_database.tf`: Database server configuration
- `ec2_bastion.tf`: Bastion host configuration
- `ec2_server_prompt.tf`: Application server configuration

### Storage Configuration
- `s3.tf`: S3 bucket configuration

### System Management
- `ssm.tf`: AWS Systems Manager configuration
- `ssh_key.tf`: SSH key management

## Variable Configuration

Main variables are defined in `main_variables.tf`, including:
- AWS region settings
- Instance types
- Network CIDR configurations
- Tag settings

## Maintenance and Updates

1. Regular `terraform plan` checks for configuration drift
2. Use `terraform fmt` for code formatting
3. Update Terraform providers and module versions
4. Monitor AWS resource usage

## Contributing

1. Fork this project
2. Create a feature branch
3. Commit your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details

