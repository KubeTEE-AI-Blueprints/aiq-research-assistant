# AIQ Enterprise Agent Blueprint for KubeTEE AI

## Pre-requise in user/miner namespace

- [**KubeTEE NVIDIA RAG Blueprint**](https://github.com/KubeTEE-AI-Blueprints/rag) Stack to vectorize and querying large sets of multi-modal documents.

## KubeTEE provided managed decentralized services
  
- [**NVIDIA NeMo Retriever Microservices**](https://developer.nvidia.com/nemo-retriever?sortBy=developer_learning_library%2Fsort%2Ffeatured_in.nemo_retriever%3Adesc%2Ctitle%3Aasc&hitsPerPage=12)

- [**NVIDIA NIM Microservices**](https://developer.nvidia.com/nim?sortBy=developer_learning_library%2Fsort%2Ffeatured_in.nim%3Adesc%2Ctitle%3Aasc&hitsPerPage=12)

## Optional Autonomous Fine-Tuneing Service

- [**Data Flywheel**](https://github.com/KubeTEE-AI-Blueprints/data-flywheel) production-grade autonomous service that uses the NeMo Microservices to continuously discover and promote more efficient models.
  - Require a dedicated GPU H200 for infenrencing

## User provided APIKEYs

- [**Web search powered by Tavily**](https://tavily.com/)
  - [ ] Future Add-on [DeSearch AI](https://desearch.ai/) SN22 Bittensor


## Technical Diagram  

![Architecture Diagram](https://assets.ngc.nvidia.com/products/api-catalog/aiq/diagram.jpg?)

## Deployment

### Helm Chart Installation

```sh
helm upgrade --install aiq deploy/helm/aiq-aira -n <namespace> --create-namespace \
  -f deploy/helm/aiq-aira/values-staging.yaml
```

### Dynamic Ingress

The ingress hostname is automatically generated based on the deployment namespace:

| Namespace | URL | TLS Secret |
|-----------|-----|------------|
| `aiq` | https://aiq-staging.kubetee.ai | `aiq-tls` |
| `research` | https://research-staging.kubetee.ai | `research-tls` |
| `demo` | https://demo-staging.kubetee.ai | `demo-tls` |

**Pattern:** `{namespace}-staging.kubetee.ai`

### Requirements

- **Ingress Controller:** Traefik (k3s default)
- **TLS:** cert-manager with `letsencrypt-prod` ClusterIssuer
- **Secrets:** `ngc-secret`, `ngc-api`, `tavily-secret` pre-created in namespace

### Override Hostname (optional)

```sh
helm upgrade --install aiq deploy/helm/aiq-aira -n aiq \
  -f deploy/helm/aiq-aira/values-staging.yaml \
  --set frontend.ingress.host=custom.kubetee.ai \
  --set frontend.ingress.tls.secretName=custom-tls
```
