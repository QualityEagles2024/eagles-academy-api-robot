

---

# Projeto de Testes Automatizados com Robot Framework

## Descrição

Este projeto realiza testes automatizados de API para validar a criação de usuários em um sistema específico. Os testes cobrem diferentes cenários de validação, como criação de usuários com nome completo em diferentes formatos, senhas que não atendem aos critérios de segurança, e-mails inválidos, entre outros.

## Tecnologias Utilizadas

- **Robot Framework**: Framework para automação de testes.

- **RequestsLibrary**: Biblioteca para testes de API HTTP.

- **Faker**: Biblioteca para geração de dados dinâmicos como nomes, e-mails e CPFs.

- **Python**: Linguagem utilizada para criar funções auxiliares que geram dados de teste.

## Pré-requisitos

Certifique-se de ter o Python 3.7 ou superior instalado.

Instale as dependências do projeto listadas no arquivo `requirements.txt`:

```bash

pip install -r requirements.txt

```

## Instalação e Configuração

1\. Clone este repositório:

   ```bash

   git clone https://github.com/seu-usuario/seu-repositorio.git

   ```

2\. Acesse o diretório do projeto:

   ```bash

   cd seu-repositorio

   ```

3\. Instale as dependências do Python:

   ```bash

   pip install -r requirements.txt

   ```

## Estrutura do Projeto

- `tests/`: Contém os casos de teste escritos em Robot Framework.

  - `CT04_create_user.robot`: Testa a criação de usuário com nome completo usando iniciais minúsculas.

  - `CT07_create_user.robot`: Testa a criação de usuário com senha inválida.

  - `CT06_create_user.robot`: Testa a criação de usuário com e-mail inválido.

  - `CT08_create_user.robot`: Testa a criação de usuário com o campo `confirmPassword` vazio.

- `resources/`: Contém recursos reutilizáveis como variáveis, keywords e funções Python para geração de dados dinâmicos.

  - `dynamic_variables.py`: Arquivo Python para gerar dados dinâmicos (nomes, e-mails, CPFs, senhas).

- `common_keywords.robot`: Keywords comuns para criação de sessão, login e manipulação de variáveis.

## Como Executar os Testes

Para executar todos os testes de uma vez:

```bash

robot tests/

```

Para executar um teste específico:

```bash

robot tests/users/CT04_create_user.robot

```

## Principais Cenários de Teste

- **Nome Completo com Iniciais Minúsculas**: Valida que a API retorna erro 400 quando o nome completo possui iniciais minúsculas.

- **E-mail Inválido**: Valida que a API retorna erro 400 quando o e-mail informado não possui um formato válido.

- **Senha Inválida**: Valida que a API retorna erro 400 quando a senha não atende aos critérios de segurança (uma letra maiúscula, uma minúscula, um número, um caractere especial e tamanho entre 8-12).

- **Campo CPF Vazio**: Valida que a API retorna erro 400 quando o campo `cpf` é enviado vazio.

- **Campo confirmPassword Vazio**: Valida que a API retorna erro 400 quando o campo `confirmPassword` é enviado vazio.

## Estrutura do Arquivo `requirements.txt`

O arquivo `requirements.txt` lista todas as dependências do projeto:

```

certifi==2024.8.30

charset-normalizer==3.3.2

Faker==30.1.0

idna==3.10

python-dateutil==2.9.0.post0

requests==2.32.3

robotframework==7.1

robotframework-requests==0.9.7

six==1.16.0

typing_extensions==4.12.2

urllib3==2.2.3

```

Para instalar as dependências, utilize:

```bash

pip install -r requirements.txt

```

## Contribuindo

1\. Faça um fork do repositório.

2\. Crie uma branch para a sua feature (`git checkout -b minha-feature`).

3\. Faça o commit das suas alterações (`git commit -m 'Adiciona nova feature'`).

4\. Faça o push para a branch (`git push origin minha-feature`).

5\. Abra um Pull Request.

## Executando a Pipeline com GitHub Actions

Este projeto está configurado para ser integrado ao GitHub Actions, onde os testes são automaticamente executados em cada push ou pull request. Certifique-se de que os testes estejam passando antes de enviar suas alterações para o repositório remoto.

## Licença

Este projeto é distribuído sob a licença MIT. Consulte o arquivo `LICENSE` para obter mais informações.

---

Esse `README.md` serve como uma documentação completa para desenvolvedores que desejam entender e contribuir com o projeto, incluindo desde a instalação até a execução dos testes e a integração contínua com GitHub Actions. Certifique-se de personalizar detalhes como URLs e nomes de repositórios antes de usar.
