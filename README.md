# Easy Login
O propósito dessa aplicação é simular um simples mecanismo de cadastro de usuários e autenticação, e exibir na tela home a localização do usuário.

A aplicação é acessivel pelo navegador.

A persistencia dos dados é feita usando apenas e memoria da aplicação.

O backend é construído com Ruby on Rails.

## Sumário
Foi utilizado o padrão de serviço, onde toda a lógica relacionada a uma ação é delegada a um serviço.

Vale destacar o uso de algumas gems importantes no projeto:

- [Faker](https://github.com/faker-ruby/faker): Usada para gerar dados durante os testes.
- [Dry-validation](https://github.com/dry-rb/dry-validation): Adiciona uma camada de validação à aplicação, permitindo que a lógica de validação seja extraída dos modelos e colocada em contratos.
- [Rspec](https://github.com/rspec/rspec-rails): Para escrever testes da aplicação.
- [Rubocop](https://github.com/rubocop/rubocop): Para garantir que a aplicação siga os padrões de código definidos.
- [Vcr](https://github.com/vcr/vcr): Para registrar as interações HTTP do seu conjunto de testes e reproduzir durante futuras execuções de testes para testes rápidos, determinísticos e precisos.

## Rodando a aplicação
A aplicação pode ser executada usando Docker ou localmente na máquina host.

### No Docker

No diretório `bin`, existem alguns scripts utilitários para uso com o Docker Compose:
- `bin/docker-build`: Constrói a imagem da aplicação.
- `bin/docker-doc`: Gera a documentação da aplicação.
- `bin/docker-lint`: Executa o RuboCop na aplicação.
- `bin/docker-start`: Inicia o container da aplicação em segundo plano.
- `bin/docker-stop`: Interrompe o container da aplicação.
- `bin/docker-test`: Executa os testes da aplicação.
- `bin/docker-up`: Inicia o container da aplicação no terminal atual.

#### Requisitos
- Docker
- Docker Compose
- Token da ipinfo (IPINFO_TOKEN) obtido em https://ipinfo.io.

#### Executando a Aplicação

Primeiro é necessário criar o arquivo de variaveis de ambiente copiando do arquivo `.env-example` para `.env`.
Entao e necessario alterar o `.env` e colocar os valores em:

```
IPINFO_TOKEN - Token da IPINFO para recuperar os dados de localização.
```

Depois que o arquivo .env estiver configurado, você pode construir a imagem da aplicação executando o seguinte comando:
```
./bin/docker-build
```

E depois disso, você pode iniciar a aplicação com o comando:
```
./bin/docker-start
```

A aplicação estará disponível em `http://localhost:3000`.

Por padrão, a aplicação estará acessível na porta 3000, mas isso pode ser alterado modificando a porta no arquivo `.env`.

#### Testando a Aplicação

Para rodar os testes, rode o comando:
```
./bin/docker-test
```

### No ambiente local

In the `bin` directory, there are some utility scripts for use with Docker Compose:
- `bin/doc`: Generates the application's documentation.
- `bin/lint`: Runs RuboCop on the application.
- `bin/dev`: Starts the application container in the background.
- `bin/test`: Runs the application's tests.

#### Requisitos
- Ruby 3.3.4
- Rails 8
- Token da ipinfo (IPINFO_TOKEN) obtido em https://ipinfo.io.

Primeiro, é necessário criar o arquivo de variáveis de ambiente copiando o arquivo `.env-example` para `.env`.
Em seguida, é necessário editar o arquivo `.env` e definir os valores das seguintes variáveis:

```
IPINFO_TOKEN - Token da IPINFO para recuperar os dados de localização.
```

Depois que o arquivo .env estiver configurado, você pode iniciar a aplicação com o comando:
```
./bin/dev
```

A aplicação estará disponível em `http://localhost:3000`.

Por padrão, a aplicação estará acessível na porta 3000, mas isso pode ser alterado modificando a porta no arquivo `.env`.

#### Testando a Aplicação

Para rodar os testes, rode o comando:
```
./bin/test
```
