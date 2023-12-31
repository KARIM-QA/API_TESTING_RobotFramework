*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    http://localhost:8080
${id_videogame}     20
${name_videogame}   Farlight84
${output_message}   Record Added Successfully
*** Test Cases ***
Add_new_videogame
   Create Session    mySession    ${base_url}
   ${header}=     Create Dictionary    Content-Type=application/json; charset=utf-8
   ${body_to_send}=   Create Dictionary  id=${id_videogame}  name=${name_videogame}   releaseDate=2022-15-01T00:00:00+04:00   reviewScore=99  category=FPS  rating=Universal

   ${response}=   Post Request    mySession     /app/videogames    data=${body_to_send}    headers=${header}
   Log To Console    code response generated is : ${response.status_code}
   Log To Console    content of response is: ${response.content}

#Validations
   ${status_code}=  convert to string  ${response.status_code}
   should be equal   ${status_code}    200
   ${response_body}=    convert to string    ${response.content}
   Should Contain    ${response_body}   ${output_message}