# desafio-agros

# Objetivo

Desenvolver uma API para Anotações.
Uma anotação é um registro que contém um título, conteúdo e data de criação.
Deve ser possivel criar, editar, excluir e listar anotações.
A API deve ser escrita em Ruby com framework Ruby on Rails.
As anotações devem ser persistidas em Banco de dados
Deverá possuir testes unitários

# Pré-requisitos

* Ruby 3.3.5
* Rails 7.2.1
* PostgreSQL 12

# Instalação

```bash
git clone https://github.com/augusto-pamplona/desafio-agros.git
cd desafio-agros
bundle install
```

# Configuração do Ambiente

Realize o setup do banco de dados com ```rails db:setup``` lembrando que qualquer preferencia referente ao banco,
deve ser atualizado o arquivo ```database.yml```

Tendo feito isso, será possível atualizar o banco com a estrutura da aplicação, rode
```rails db:migrate``` e ```RAILS_ENV=test rails db:migrate```

# Iniciar a Aplicação

```rails s```

# Executar os Testes

```bundle exec rspec```

# Observações

Existe na raiz do projeto um arquivo chamado ```thunder-collection_desafio-agros.json``` que possui uma simples coleção
das actions do controller de annotation (index, show, create, update e delete).
Para usar é necessário que possua ou instale a extensão do Thunder Client no VScode.
