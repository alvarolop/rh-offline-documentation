# 📖 Red Hat Offline Documentation

## ✈️ The Problem

This month I'm traveling to the US for **RH One** and I need some documentation to read on the plane to fall asleep 😴. I realized that downloading Red Hat documentation isn't that well structured for offline reading.

## 💡 The Solution

I found two nice ways to get offline documentation:

---

### 1️⃣ Red Hat Offline Knowledge Portal (RHOKP)

A secure, offline version of Red Hat's proprietary knowledge content. It's a pocket library that includes:

- 📚 Knowledgebase articles
- 📄 Product documentation  
- 🔒 CVEs & Errata

It runs as a single container image, compatible with OpenShift, Podman, or any OCI-compliant runtime.

👉 **More info:** [Red Hat Offline Knowledge Portal](https://access.redhat.com/products/red-hat-offline-knowledge-portal)

> ⚠️ **Note:** Requires Red Hat Satellite Infrastructure Subscription (SKU MCT3718)

**Run it:**

```bash
podman run --rm -p 8080:8080 -p 8443:8443 \
--env "ACCESS_KEY=$(cat ~/rhokp-api-key)" \
-d registry.redhat.io/offline-knowledge-portal/rhokp-rhel9:latest
```

Wait a minute and access the documentation at [http://127.0.0.1:8080](http://127.0.0.1:8080).

---

### 2️⃣ Download PDFs with Script

For a simpler approach, I created a script that downloads documentation PDFs from YAML manifests.

```bash
./download-docs.sh Red_Hat_Advanced_Cluster_Security_for_Kubernetes.yaml
./download-docs.sh Red_Hat_OpenShift_AI_Self-Managed.yaml
./download-docs.sh Red_Hat_OpenShift_Container_Platform.yaml
./download-docs.sh Red_Hat_OpenShift_Data_Foundation.yaml
./download-docs.sh Red_Hat_OpenShift_GitOps.yaml
./download-docs.sh Red_Hat_OpenShift_Logging.yaml
./download-docs.sh Red_Hat_OpenShift_Monitoring_stack.yaml
./download-docs.sh Red_Hat_OpenShift_Pipelines.yaml
```

---

## 🛫 Happy reading and safe travels!
