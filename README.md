# README

## Comandos necessários

### Esta api rails é baseada em docker e docker-compose

***
* Buildar a api: docker-compose build
* Iniciar a api: docker-compose up
* Parar a api: docker-compose down
* Reiniciar a api: docker-compose restart
### Setup do banco de dados
* Abra um novo terminal e rode
* docker-compose run web rails db:setup

### Rodar os testes atuomatizados
* Abra um novo terminal e rode
* docker-compose run web rails rspec