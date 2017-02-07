#!/bin/bash

# Mezcla los comandos =httppie=, =jq= y =csvkit= para descargar las peliculas de *Star Wars* y guardar los campos de =title,episode_id,director,producer,release_date,opening_crawl= en una base de datos =sqlite= llamada =star_wars.db=

http http://swapi.co/api/films/ | jq ‘[.results[] | {title,episode_id,director,producer,release_date,opening_crawl}]’ | in2csv -f json | csvsql --db sqlite:///star_wars.db --table peliculas --insert



#Usando =bash= crea un programa que descargue todas los /resources/ de *SWAPI* y guardalos en =jsons= separados usando como nombres de archivo la llave del =json=. Toma en cuenta la paginacion. Al final deberas de tener solo 7 archivos. Procesa estos archivos con las herramientas del primer inciso de la tarea. Al final deberias de tener 7 tablas en =star_wars.db=

#NOTA: Solo existen 6 resources en SWAPI, no 7
for res in $(http http://swapi.co/api/ | jq -r 'keys[]')
do
	http GET http://swapi.co/api/$res/ | jq '[.results[]]' | in2csv -f json | csvsql --db sqlite:///stars_wars.db --table $res --insert
done