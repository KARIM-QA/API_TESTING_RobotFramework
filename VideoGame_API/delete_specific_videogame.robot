*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    http://localhost:8080
${id_videogame}   20
${output_message}   Record Deleted Successfully

*** Test Cases ***
Delete_List_videosgame
   Create Session    mySession    ${base_url}
   ${response} =     delete Request     mySession     /app/videogames/${id_videogame}

   ${body}=    convert to string   ${response.content}
   Should Contain    ${body}    ${output_message}

