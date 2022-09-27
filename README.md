# AWS-Teste-Galp

### Ferramentas utilizadas
- [Packer](https://www.packer.io/)
- [Terraform](https://www.terraform.io/)
- [Makefile](https://devhints.io/makefile)
- [Git](https://git-scm.com/)
## Para execução do projeto é utilizado o comando `make apply`, nesse comando executa um compilado de outros comandos:
- 	`packer build Golden_Image/builder.json` -  esse comando ira criar a ami de acordo com as configuração já configuradas no arquivo builder.json 
- `terraform init` - Após as criação da imagem será iniciado o terraform
-	`terraform plan -var-file="backend.tfvars" -out="backplan.tfplan"` será executado plan do terraform com os valores necessarios para sua execução , após finalizar , será gerado um arquivo tfplan.
- `terraform apply "backplan.tfplan"` - como tfplan, que seria o "roteiro" de execução para o terraform , o ambiente será provisionado conforme módulos criados nesse projeto.
-------------------------
## Esse projeto consiste na criação dos seguintes recursos:
>1 Load Balancer
>
>1 Internet gateway
>
>1 Nat gateway
>
>No maximo 3 subnets publicas
>
>No maximo 3 subnets publicas
>
>2 Route tables
>
> 1 imagem criada vo Packer
> 
> 1 bastion para gerenciar as instancias privadas
> 
> Até 3 instancias privadas com a ami criada
