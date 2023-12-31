*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    XML    xml.etree.ElementTree as ET
Library    JSONLibrary
Library    BuiltIn
#Library    XML
*** Variables ***
${base_url}    http://localhost:8080

*** Test Cases ***
Get_List_videosgames
   Create Session    mySession    ${base_url}
   ${response} =     Get Request     mySession     /app/videogames

   ${status_code}=   convert to string   ${response.status_code}
   Should Be Equal    ${status_code}    200
   Log To Console    Status code is :${status_code}

   ${body}=    convert to string   ${response.content}
   #Log To Console    list videos games is : ${body}

   #################################################################################################
   # Parsing du contenu XML
   ${xml_root}=    Parse XML    ${body}

   # Récupération de tous les éléments <videoGame>
   ${video_games}=    Get Elements    ${xml_root}    videoGame

   # Parcours de tous les éléments <videoGame>
   FOR    ${video_game}    IN    @{video_games}

       ${id}=    Get Element Text    ${video_game}    id
       ${name}=  Get Element Text    ${video_game}    name
       ${release_date}=    Get Element Text    ${video_game}    releaseDate
       ${review_score}=    Get Element Text    ${video_game}    reviewScore
       ${category}=     Get Element Attribute    ${video_game}    category
       ${rating}=      Get Element Attribute    ${video_game}     rating

       Log To Console    Video game ID: ${id}
       Log To Console    Video game name: ${name}
       Log To Console    Release date: ${release_date}
       Log To Console    Review score: ${review_score}
       Log To Console    Category: ${category}
       Log To Console    Rating: ${rating}

      # Ajout de la séparation "/****************************************************************/" après chaque itération
       Log To Console    <=#######################################################################=>
   END

  # Création d'un dictionnaire avec les valeurs extraites
   ${game_data}=    Create Dictionary    id=${id}    name=${name}    releaseDate=${release_date}    reviewScore=${review_score}    category=${category}    rating = ${rating}

   # Conversion du dictionnaire en format JSON
   ${json_data}=    Evaluate    json.dumps(${game_data})

   Log To Console    JSON data: ${json_data}










