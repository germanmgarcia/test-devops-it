# TEST DEVOPS IT

## Prerrequisitos
- AKS

## Creando un clúster de AKS

En esta caso, empecé aprovisionando la infraestructura necesaria para los ejercicios solicitados, un AKS y un ACR.
Si no tienes un cluster de AKS, puedes aprovisionarlo con los siguientes comandos desde la ruta /terraform.
```sh
terraform init -upgrade
terraform plan
terraform apply
```
Y obtener la configuración del archivo kubectl con el siguiente comando.
```sh
echo "$(terraform output kube_config)" > ./azurek8s
```
Nota: Si viera << EOT al principio y EOT al final, quite estos caracteres del archivo. 

Con esto, ya tendríamos nuestra infraestructura montada, para empezar a probar, lo siguente es negenerar un Pipeline, en Azure DevOPs.

## Pipeline Azure DevOps

Lo primero, es tener configurado un pool de agentes, en este caso utilice mi propia maquina local, en caso de no tener una configuración Default
con una maquina ubuntu, siéntase libre de cambiarlo por una de este sistema y que tenga Python 3.10.12 para poder ejecutar el Pipeline correctamente.
Solo debe modificar: 
```sh
pool:
  name: Default
```
por el pool que desee, por ejemplo:
```sh
pool:
  vmImage: 'ubuntu-latest'
```
También es necesario que configure el servicio de conexión al ACR.
En Pipeline solo tiene dos pasos, uno ejecuta solamente las pruebas unitarios y el siguiente construye la imagen necesaria para implementarla en AKS.
Las variables que necesita configurar en el pipeline son:
|  1 |  2 |
|--------------|--------------|
| acrLoginServer | Es el logín server del ACR, ejemplo: 8pkpz2wbacrdevopsg1.azurecr.io |
