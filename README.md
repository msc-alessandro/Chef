# Chef

Este repositório contém scripts para a instalação de *runners* do Gitlab-CI em hosts remotos e localmente. A configuração deste respositório se dá na seguinte forma:

```
├── bootstrap_files
│   └── chefdk_3.6.57-1_amd64.deb
├── config
│   ├── local
│   └── roles
├── config.rb
├── cookbooks
│   ├── basics
│   ├── docker
│   ├── firewalld
│   └── gitlab-ci-runner
├── nodes.d
├── nodes.yaml
├── Rakefile
├── README.md
├── scripts
└── Vagrantfile
```

|    **Arquivo**    |                                            **Descrição**                                                |
| ----------------- | ------------------------------------------------------------------------------------------------------- |
| nodes.yaml        | Lista dos nós que estão sendo gerenciados e uma lista das receitas que devem ser executadas em cada nó. |
| config.rb         | Configurações que serão utilizadas pelo chef-solo.                                                      |
| config/ambiente   | Configurações de ip e ssh que dever ser utilizadas pelo chake para realizar ssh nos nós.                |
| config/roles      | Roles que serão utilizados pelo chef-solo.                                                              |
| cookbooks         | Diretório com as receitas que serão executadas nos nós.                                                 |
| Vagrantfile       | Arquivo de confiuração do Vagrant. Pode ser usado para rodar e VMs/Containers localmente.               |
| scripts           | Pasta com scripts para utilização no processo de deploy.                                                |


## Dependencias de instalação

O Chake e o chef utilizam Ruby como linguagem de script e portanto dependem que o Ruby esteja instalado na máquina de onde os comandos serão executados.

```
Ruby version >= 0
```


## Dependencias de execução

O Chake em si é uma gem (Pacote do Ruby) que utiliza o Rake para a execução dos comandos ( *tasks* ). Portanto ambas as gems devem ser instaladas.

```
gem install chake

gem install rake
```

Para a execução local, foram preparadas VMs e portanto será necessário baixar e instalar o [Vagrant](https://www.vagrantup.com/downloads.html).


## Adicionando nós a stack



## Configuração dos runners



## Executando e criando runners localmente


## Convergindo os ambientes
