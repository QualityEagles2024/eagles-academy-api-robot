*** Settings ***
Library         RequestsLibrary
Library         Collections

*** Variables ***
${base_url}     https://quality-eagles.qacoders.dev.br/api
${email}        sysadmin@qacoders.com
${password}     1234@Test
${token}        None

*** Test Cases ***
Login com Credenciais Válidas
    [Documentation]    Faz login e armazena o token de autenticação
    Criar Sessao
    Realizar Login
    Validar Token Obtido

*** Keywords ***
Criar Sessao
    ${headers}=  Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session  alias=api_session    url=${base_url}    headers=${headers}    verify=true

Realizar Login
    ${body}=     Create Dictionary     mail=${email}     password=${password}
    ${resposta}=  POST On Session     alias=api_session   url=/login/  json=${body}
    Status Should Be    200
    ${token}=    Get From Dictionary    ${resposta.json()}    token
    Log To Console    Token obtido: ${token}

Validar Token Obtido
    Should Not Be Empty    ${token}    Token não deve estar vazio
