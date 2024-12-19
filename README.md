# Element84 DevOps Project

This project automates the deployment of infrastructure and services on AWS using Terraform and GitHub Actions. It includes the following components:

1. **Terraform Infrastructure**: Creates resources such as S3 buckets, a DynamoDB table, an API Gateway, and a Lambda function.
2. **AWS Lambda Function**: Merges datasets stored in S3 and uploads the processed data back to S3.
3. **GitHub Actions CI/CD Workflow**: Automates the deployment process, including Terraform execution, Lambda deployment, and file uploads.

---

## **Project Structure**

```
project-root/
├── infra/
│   ├── backend.tf           # Terraform backend configuration
│   ├── main.tf              # Main infrastructure resources
│   ├── outputs.tf           # Terraform outputs
│   ├── variables.tf         # Terraform variables
│   ├── lambda_function.py   # Lambda function code
│   └── files/               # Dataset files
│       ├── SF_HOMELESS_ANXIETY.csv
│       └── SF_HOMELESS_DEMOGRAPHICS.csv
├── .github/
│   └── workflows/
│       └── deploy.yml       # GitHub Actions workflow
└── README.md                # Documentation
```

---

## **Setup Instructions**

### **1. Prerequisites**
Ensure the following tools are installed on your local machine:
- [Terraform](https://www.terraform.io/downloads.html) (version 1.5.3 or higher)
- [AWS CLI](https://aws.amazon.com/cli/)
- Git

### **2. Configure AWS Access**
Generate an AWS Access Key and Secret Key with sufficient permissions to manage S3, DynamoDB, Lambda, and API Gateway resources:
1. Go to the **AWS Console**.
2. Navigate to **IAM > Users**.
3. Select your user, then go to **Security Credentials**.
4. Generate and copy the **Access Key ID** and **Secret Access Key**.

Add these credentials to your GitHub repository as secrets:
1. Go to **Settings > Secrets and Variables > Actions**.
2. Add two secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID.
   - `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key.

### **3. Project Deployment**

#### **Step 1: Push Code to GitHub**
Ensure your project files are structured as shown above. Push them to the `main` branch of your GitHub repository:
```bash
git add .
git commit -m "Initial commit with infrastructure setup"
git push origin main
```

#### **Step 2: Monitor GitHub Actions**
1. Navigate to the **Actions** tab in your GitHub repository.
2. Select the **"Deploy Infrastructure and Lambda"** workflow.
3. Monitor each step as the workflow:
   - Initializes Terraform.
   - Deploys the backend (S3 and DynamoDB).
   - Creates the remaining resources (Lambda, API Gateway, datasets S3 bucket).
   - Uploads the Lambda function.
   - Uploads the dataset files to S3.

#### **Step 3: Verify Resources in AWS**
- **S3 Buckets**:
  - `element84-terraform-state`: Contains the Terraform state file.
  - `element84-datasets`: Contains the raw datasets and the processed dataset (`processed/merged_data.csv`).
- **DynamoDB Table**:
  - `element84-terraform-locks`: Used for Terraform state locking.
- **Lambda Function**:
  - `merge-homeless-data`: Deployed with the correct permissions and environment variables.
- **API Gateway**:
  - `HomelessDataAPI`: Exposes an endpoint to trigger the Lambda function.

#### **Step 4: Test the API**
1. Copy the API Gateway URL from the Terraform outputs or GitHub Actions logs.
2. Test the API endpoint using `curl` or Postman:
   ```bash
   curl https://<api-gateway-url>/data
   ```
3. Verify the processed dataset is uploaded to `processed/merged_data.csv` in the datasets S3 bucket.

---

## **Workflow Explanation**

### **GitHub Actions Workflow**
The `deploy.yml` workflow automates the following:

1. **Checkout Code**:
   - Pulls the latest code from the repository.
2. **Terraform Deployment**:
   - Initializes the Terraform backend.
   - Deploys the backend resources (S3 for Terraform state, DynamoDB for state locking).
   - Deploys the remaining infrastructure (datasets S3 bucket, Lambda function, API Gateway).
3. **Lambda Packaging and Deployment**:
   - Zips the `lambda_function.py` file.
   - Deploys the Lambda function using the AWS CLI.
4. **File Uploads**:
   - Uploads `SF_HOMELESS_ANXIETY.csv` and `SF_HOMELESS_DEMOGRAPHICS.csv` to the `raw/` folder in the datasets S3 bucket.

---

## **Troubleshooting**

### **Common Issues**

1. **GitHub Actions Fails at "Terraform Init"**:
   - Ensure the `element84-terraform-state` bucket and `element84-terraform-locks` DynamoDB table exist.
   - Re-run the workflow if necessary.

2. **Lambda Function Error**:
   - Verify the S3 permissions in the IAM role assigned to the Lambda function.
   - Ensure `pandas` is packaged with the Lambda function.

3. **API Gateway Returns Errors**:
   - Ensure the Lambda function is successfully deployed.
   - Check the API Gateway route and integration in the AWS Console.

4. **Dataset Files Missing**:
   - Verify the `Upload Files to S3` step in the workflow logs.

---

## **Enhancements**
- Add monitoring for the Lambda function using CloudWatch.
- Implement automated tests for the API endpoint.
- Optimize dataset processing in the Lambda function.

---



