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

## Adicionando novos ambientes para deploy

Para adicionar um novo ambiente, crie uma nova pasta dentro do diretório config com o nome do ambiente. Neste diretório, devem existir três arquivos, são eles:

```
ips.yaml: Contém os ips dos nós que vão receber as configurações
ssh_config: Contém as configurações para ssh dos nós.
runners.yaml: Contém as configurações dos runners do gitlab que serão aplicadas nos nós.
```

## Adicionando nós a um ambiente

Adicione um novo nó no arquivo nodes.yaml.

```
gitlab-runner:
  run_list:
    - role[gitlab-runner]
```

Adicione o ip do novo nó no arquivo ips.yaml dentro da pasta do ambiente que este novo nó se encontra.

```
gitlab-runner: 10.0.2.10
```

Adicione as configurações de SSH no arquivo `ssh_config` dentro da pasta do ambiente em que o nó se encontra.

```
Host gitlab-runner
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /home/alessandrocb/Projetos/chef/.vagrant/machines/gitlab-runner/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
```

## Configuração dos runners

As configurações dos runners ficam no arquivo `config/<ambiente>/runners.yaml`, esse arquivo tem a seguinte configuração:

```
runners:
  - description: test-runner-1
    options:
      url: 'https://gitlab.com'
      registration_token: 'tZzvXHYxz9LqDRRN4nMv'
      tag_list: [ 'test1', 'tag' ]
      executor: 'docker'
      docker_image: 'node:8'
      retries: 1
  - description: test-runner-2
    options:
      url: 'https://gitlab.com'
      registration_token: 'tZzvXHYxz9LqDRRN4nMv'
      tag_list: [ 'test2', 'tag' ]
      executor: 'docker'
      docker_image: 'node:8'
      retries: 1

```

## Executando e criando runners localmente


## Convergindo os ambientes
