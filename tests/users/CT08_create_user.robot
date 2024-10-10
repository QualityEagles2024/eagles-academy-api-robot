*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         ../resources/dynamic_variables.py   # Importa o arquivo Python que gera dados dinâmicos
Resource        ../resources/common_keywords.robot  # Importa as keywords comuns

*** Variables ***
${base_url}     https://quality-eagles.qacoders.dev.br/api
${endpoint}     /user/
${mensagem_erro_password_invalido}    Senha precisa ter: uma letra maiúscula, uma letra minúscula, um número, um caractere especial(@#$%) e tamanho entre 8-12.

*** Test Cases ***
Criar Usuário com Password Inválido
    [Documentation]   Testa a criação de um usuário com o campo password inválido e verifica se a API retorna erro 400.
    Criar Sessao
    Realizar Login
    Criar Novo Usuario Com Password Invalido

*** Keywords ***
Criar Novo Usuario Com Password Invalido
    [Documentation]    Envia uma requisição POST para criar um novo usuário com senha inválida
    ${user_data}=  Generate User Data   invalid_password=True
    ${body}=  Create Dictionary    fullName=${user_data["fullName"]}    mail=${user_data["email"]}    password=${user_data["password"]}    accessProfile=ADMIN    cpf=${user_data["cpf"]}    confirmPassword=${user_data["confirmPassword"]}

    ${headers}=  Create Dictionary    accept=application/json    Content-Type=application/json

    ${url_com_token}=  Set Variable    ${base_url}${endpoint}?token=${token}

    # Captura a resposta da API e espera que o código de status seja 400
    ${resposta}=  POST On Session      alias=api_session   url=${url_com_token}  headers=${headers}  json=${body}  expected_status=400

    # Converte a resposta em dicionário para análise
    ${response_body}=  Convert To Dictionary    ${resposta.json()}

    # Obtém a mensagem de erro
    ${error_msg}=  Get From Dictionary    ${response_body}    error

    # Verifica se a mensagem de erro da senha está presente
    Run Keyword If    "'Senha precisa ter: uma letra maiúscula, uma letra minúscula, um número, um caractere especial(@#$%) e tamanho entre 8-12.' in ${error_msg}"
    ...    Log To Console    Erro retornado: ${error_msg[0]}
    ...    ELSE    Fail    A mensagem de erro não corresponde às expectativas. Erro retornado: ${error_msg}
