# TEST DEVOPS IT

## Prerequisites
- AKS

## Creando un clúster de AKS

En este caso, si no tienes un cluster de AKS, puedes aprovisionarlo con los siguientes comandos.
```sh
terraform init -upgrade
terraform plan
terraform apply
```
A su vez, puedes obtener la configuración del archivo kubectl con el siguiente comando.
```sh
echo "$(terraform output kube_config)" > ./azurek8s
```
