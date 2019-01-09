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

|  Arquivo          |   Descrição                                                                                             |
| ----------------- |:-------------------------------------------------------------------------------------------------------:|
| nodes.yaml        | Lista dos nós que estão sendo gerenciados e uma lista das receitas que devem ser executadas em cada nó. |
| config.rb         | Configurações que serão utilizadas pelo chef-solo.                                                      |
| config/ambiente   | Configurações de ip e ssh que dever ser utilizadas pelo chake para realizar ssh nos nós.                |
| config/roles      | Roles que serão utilizados pelo chef-solo.                                                              |
| cookbooks         | Diretório com as receitas que serão executadas nos nós.                                                 |
| Vagrantfile       | Arquivo de confiuração do Vagrant. Pode ser usado para rodar e VMs/Containers localmente.               |
| scripts           | Pasta com scripts para utilização no processo de deploy.                                                |
