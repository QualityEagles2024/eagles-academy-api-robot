*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         resources/dynamic_variables.py  # Importa o arquivo Python para gerar dados dinâmicos
Resource        resources/common_keywords.robot  # Importa as keywords comuns

*** Variables ***
${base_url}     https://quality-eagles.qacoders.dev.br/api
${endpoint}     /user/

*** Test Cases ***
Criar Usuário Válido
    Criar Sessao
    Realizar Login
    Criar Novo Usuario Com Dados Dinâmicos  full_name_empty=${FALSE}  # Usuário válido


*** Keywords ***
Criar Novo Usuario Com Dados Dinâmicos
    [Arguments]   ${full_name_empty}=False
    [Documentation]    Envia uma requisição POST para criar um novo usuário com dados dinâmicos
    ${user_data}=  Generate User Data  full_name_empty=${full_name_empty}  # Chama a função Python para gerar dados dinâmicos
    ${body}=  Create Dictionary    fullName=${user_data["fullName"]}    mail=${user_data["email"]}    password=${user_data["password"]}    accessProfile=ADMIN    cpf=${user_data["cpf"]}    confirmPassword=${user_data["confirmPassword"]}

    ${headers}=  Create Dictionary    accept=application/json    Content-Type=application/json

    ${url_com_token}=  Set Variable    ${base_url}${endpoint}?token=${token}
    ${resposta}=  POST On Session      alias=api_session   url=${url_com_token}  headers=${headers}  json=${body}

    Status Should Be  201
    Log To Console    Usuário criado: ${resposta.json()}
