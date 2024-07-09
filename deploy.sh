#!/bin/bash

# Variables (reemplaza con tus propios valores)
ACR_NAME="9fggrJpMacrdevopsg1"
NAMESPACE="tech-prod"
EMAIL="ejemplo@outlook.es"

# Obtener el ID completo del registro
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query "id" --output tsv)

# Crear la entidad de servicio con permisos acrpull
PASSWORD=$(az ad sp create-for-rbac --name $ACR_NAME --scopes $ACR_REGISTRY_ID --role acrpull --query "password" --output tsv)
USER_NAME=$(az ad sp list --display-name $ACR_NAME --query "[].appId" --output tsv)

# Crear el namespace si no existe
kubectl create namespace $NAMESPACE || true

# Crear el secreto de Docker en el namespace especificado
kubectl create secret docker-registry acr-secret \
    --namespace $NAMESPACE \
    --docker-server=$ACR_NAME.azurecr.io \
    --docker-username=$USER_NAME \
    --docker-password=$PASSWORD \
    --docker-email=$EMAIL

# Aplicar el archivo de despliegue en el clúster de AKS
kubectl apply -f order-service-deployment.yaml
kubectl apply -f loadbalancer.yaml
