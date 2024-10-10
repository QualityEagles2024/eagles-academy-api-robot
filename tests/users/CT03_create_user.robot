*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         ../../resources/dynamic_variables.py   # Importa o arquivo Python que gera dados dinâmicos
Resource        ../../resources/common_keywords.robot  # Importa as keywords comuns


*** Variables ***
${base_url}     https://quality-eagles.qacoders.dev.br/api
${endpoint}     /user/
${mensagem_erro_iniciais}    Informe o nome e sobrenome com as iniciais em letra maiúscula e sem caracteres especiais.
${mensagem_erro_duas_palavras}    O campo nome completo deve ter pelo menos duas palavras.

*** Test Cases ***
Criar Usuário com Primeiro Nome Faltando
    [Documentation]   Testa a criação de um usuário com o campo nome completo faltando e verifica se a API retorna erro.
    Criar Sessao
    Realizar Login
    Criar Novo Usuario Com Nome Faltando

*** Keywords ***
Criar Novo Usuario Com Nome Faltando
    [Documentation]    Envia uma requisição POST para criar um novo usuário com nome completo faltando
    ${user_data}=  Generate User Data  full_name_empty=False  # Gera os dados com o nome completo faltando
    ${body}=  Create Dictionary    fullName=${user_data["lastName"]}    mail=${user_data["email"]}    password=${user_data["password"]}    accessProfile=ADMIN    cpf=${user_data["cpf"]}    confirmPassword=${user_data["confirmPassword"]}

    ${headers}=  Create Dictionary    accept=application/json    Content-Type=application/json

    ${url_com_token}=  Set Variable    ${base_url}${endpoint}?token=${token}

    # Captura a resposta da API e espera que o código de status seja 400
    ${resposta}=  POST On Session      alias=api_session   url=${url_com_token}  headers=${headers}  json=${body}  expected_status=400

    # Converte a resposta em dicionário para análise
    ${response_body}=  Convert To Dictionary    ${resposta.json()}

    # Obtém a mensagem de erro
    ${error_msg}=  Get From Dictionary    ${response_body}    error

    # Verifica se alguma das mensagens de erro está presente
    Run Keyword If    "'Informe o nome e sobrenome com as iniciais em letra maiúscula e sem caracteres especiais.' in ${error_msg} or 'O campo nome completo deve ter pelo menos duas palavras.' in ${error_msg}"
    ...    Log To Console    Erro retornado: ${error_msg[0]}
    ...    ELSE    Fail    A mensagem de erro não corresponde às expectativas. Erro retornado: ${error_msg}
