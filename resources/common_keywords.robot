
*** Keywords ***
Criar Sessao
    ${headers}=  Create Dictionary    accept=application/json    Content-Type=application/json
    # Timeout aumentado para 120 segundos (2 minutos)
    Create Session  alias=api_session    url=${base_url}    headers=${headers}    timeout=120    verify=true

Realizar Login
    ${body}=     Create Dictionary     mail=sysadmin@qacoders.com     password=1234@Test
    ${resposta}=  POST On Session     alias=api_session   url=/login/  json=${body}
    Status Should Be    200
    ${token}=    Get From Dictionary    ${resposta.json()}    token
    Set Global Variable    ${token}    ${token}
    Log To Console    Token obtido: ${token}
