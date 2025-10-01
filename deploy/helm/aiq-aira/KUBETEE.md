# AIQ Enterprise Agent Blueprint for KubeTEE AI

## Pre-requise

- [**NVIDIA RAG Blueprint**](https://github.com/NVIDIA-AI-Blueprints/rag) Provides a solution for querying large sets of on-premise multi-modal documents.

## KubeTEE provided services:
  
- [**NVIDIA NeMo Retriever Microservices**](https://developer.nvidia.com/nemo-retriever?sortBy=developer_learning_library%2Fsort%2Ffeatured_in.nemo_retriever%3Adesc%2Ctitle%3Aasc&hitsPerPage=12)

- [**NVIDIA NIM Microservices**](https://developer.nvidia.com/nim?sortBy=developer_learning_library%2Fsort%2Ffeatured_in.nim%3Adesc%2Ctitle%3Aasc&hitsPerPage=12) 
  Used through the RAG blueprint for multi-modal document ingestion.
  Provides the foundational LLMs used for report writing and reasoning, including the llama-3.3-nemotron-super-49b-v1.5 reasoning model.

- [**Web search powered by Tavily**](https://tavily.com/)
  Supplements on-premise sources with real-time web search.

## Technical Diagram  

![Architecture Diagram](https://assets.ngc.nvidia.com/products/api-catalog/aiq/diagram.jpg?)

## Deployment Helm Chart

```sh
helm upgrade --install aiq ./aiq-research-assistant/deploy/helm/aiq-aira -n aiq --create-namespace -f ./aiq-research-assistant/deploy/helm/aiq-aira/values-staging.yaml
```
