# Permission-prj
# 🔐 Securely Managing Terraform Credentials in Jenkins for GCP Provisioning

While automating GCP infrastructure provisioning using **Jenkins** and **Terraform**, one of my primary goals was to **avoid hardcoding sensitive credentials** like service account keys directly into the code or repository.

In this project, I demonstrate how to securely use **Jenkins Credentials** and **GCP Secret Manager** to build a **secure, production-friendly Terraform pipeline**.

---

## 🚨 The Problem

Service account keys are often embedded in Terraform files or exposed in Git repositories — which poses a serious **security risk**.

### I wanted to:
- ✅ Store the **Terraform service account key** securely  
- ✅ Let **Jenkins use it without exposing** it in the pipeline or code  
- ✅ **Reuse the same pipeline** across environments (Dev/Test/Prod)

---

## 🔐 Secure Pipeline Process: Step-by-Step

- **Uploaded a Jenkins service account key** to **Jenkins global credentials**
- **Stored the Terraform service account key** securely in **GCP Secret Manager**
- **Used the Jenkins service account** to **fetch the Terraform key dynamically at runtime**
- **Set the key as `GOOGLE_APPLICATION_CREDENTIALS`** so that **Terraform could authenticate with GCP**
- **Deleted the key file securely** after the pipeline run to **prevent long-lived exposure**

---

## 🖼️ Pipeline Architecture Diagram

![Pipeline Flow](path/to/your/diagram.png)

> Replace the above path with the actual path to your image if hosted locally or use the public image link.

---

## 📂 Jenkinsfile

You can view the full `Jenkinsfile` in the GitHub repository, where **credentials are handled securely without any hardcoded values**:

🔗 **[GitHub Repository – Permission-prj](https://github.com/pr149617/Permission-prj.git)**

---

## 🧰 Tools Used

- **Terraform**
- **Google Cloud Platform (GCP)**
- **Jenkins**
- **GCP Secret Manager**
