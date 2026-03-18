# Red Hat Offline Knowledge Portal - Helm Chart

This repository contains the Helm chart for the Red Hat Offline Knowledge Portal.

## Installation

```bash
helm template . --set accessKey="$(cat ~/rhokp-api-key)" --set clusterDomain=$(oc get dns.config/cluster -o jsonpath='{.spec.baseDomain}') | oc apply -f -
```

For more information, please refer to the [Red Hat Offline Knowledge Portal](https://access.redhat.com/products/red-hat-offline-knowledge-portal) documentation.