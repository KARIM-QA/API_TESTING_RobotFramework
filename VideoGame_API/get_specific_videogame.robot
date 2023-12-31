*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    XML    xml.etree.ElementTree as ET
Library    JSONLibrary
Library    BuiltIn
*** Variables ***
${base_url}    http://localhost:8080
${id_videogame}    3

*** Test Cases ***
Get_specified_videogame
   Create Session    mySession    ${base_url}
   ${response} =     Get Request     mySession     /app/videogames/${id_videogame}

   ${status_code}=   convert to string   ${response.status_code}
   Should Be Equal    ${status_code}    200
   Log To Console    Status code is :${status_code}

   ${body}=  convert to string   ${response.content}

  # Parsing du contenu XML
   ${xml_root}=    Parse XML    ${body}

   # Récupération des valeurs à partir des éléments XML
   ${id}=    Get Element Text    ${xml_root.find('id')}
   ${name}=    Get Element Text    ${xml_root.find('name')}
   ${release_date}=    Get Element Text    ${xml_root.find('releaseDate')}
   ${review_score}=    Get Element Text    ${xml_root.find('reviewScore')}

   Log To Console    Video game ID: ${id}
   Log To Console    Video game name: ${name}
   Log To Console    Release date: ${release_date}
   Log To Console    Review score: ${review_score}

  # Création d'un dictionnaire avec les valeurs extraites
   ${game_data}=    Create Dictionary    id=${id}    name=${name}    releaseDate=${release_date}    reviewScore=${review_score}

   # Conversion du dictionnaire en format JSON
   ${json_data}=    Evaluate    json.dumps(${game_data})
   Log To Console    <=##############################################################################################=>
   Log To Console    JSON data: ${json_data}
   Log To Console    <=##############################################################################################=>

