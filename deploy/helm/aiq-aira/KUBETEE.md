# AIQ Enterprise Agent Blueprint for KubeTEE AI

## Pre-requise in user/miner namespace

- [**NVIDIA RAG Blueprint**](https://github.com/KubeTEE-AI-Blueprints/rag) Stack to vectorize and querying large sets of multi-modal documents.

## KubeTEE provided managed decentralized services
  
- [**NVIDIA NeMo Retriever Microservices**](https://developer.nvidia.com/nemo-retriever?sortBy=developer_learning_library%2Fsort%2Ffeatured_in.nemo_retriever%3Adesc%2Ctitle%3Aasc&hitsPerPage=12)

- [**NVIDIA NIM Microservices**](https://developer.nvidia.com/nim?sortBy=developer_learning_library%2Fsort%2Ffeatured_in.nim%3Adesc%2Ctitle%3Aasc&hitsPerPage=12)

- [**Web search powered by Tavily**](https://tavily.com/)
  - [ ] Add [DeSearch AI](https://desearch.ai/) SN22 Bittensor

- [**Data Flywheel**](https://github.com/KubeTEE-AI-Blueprints/data-flywheel) production-grade autonomous service that uses the NeMo Microservices to continuously discover and promote more efficient models.

## Technical Diagram  

![Architecture Diagram](https://assets.ngc.nvidia.com/products/api-catalog/aiq/diagram.jpg?)

## Deployment Helm Chart

```sh
helm upgrade --install aiq deploy/helm/aiq-aira -n aiq -f deploy/helm/aiq-aira/values-staging.yaml
```
