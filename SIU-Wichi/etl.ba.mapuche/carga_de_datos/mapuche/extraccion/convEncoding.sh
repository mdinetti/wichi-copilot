#!/bin/bash
srcEncoding="ISO-8859-1"
destEncoding="UTF-8"
cmdIconv=/usr/bin/iconv
cmdFile=/usr/bin/file
cmdLs=/bin/ls
cmdTouch=/usr/bin/touch
cmdBaseName=/usr/bin/basename

if [[ $# != 2 ]]; then
	echo "Este script convierte archivos de texto de $srcEncoding a $destEncoding."
	echo "Uso: $0 ruta_origen ruta_destino"
	exit 1;
fi

fromDir="$1"
toDir="$2"

echo
echo
if [ ! -x $cmdIconv ]; then
	echo "Error: no se puede ejecutar $cmdIconv."
	exit 1;
fi
if [ ! -d "$fromDir" ]; then
	echo "Error: $fromDir no existe o no es un directorio."
	exit 1;
fi
if [ ! -d "$toDir" ]; then
	echo "Error: $toDir no existe o no es un directorio."
	exit 1;
fi
if [[ "$fromDir" == "$toDir" ]]; then
	echo "Los directorios de origen y destino no pueden ser el mismo."
	exit 1;
fi
wd=$PWD
cd "$fromDir"
files=$($cmdLs)
if [ -z "$files" ]; then
	echo "El directorio $fromDir existe pero no contiene archivos. Este script no convierte de manera recursiva. Especifique el directorio que contiene los archivos a convertir."
	exit 1;
fi

echo "Los siguientes archivos van a ser convertidos de $srcEncoding a $destEncoding."
echo
if [ -x $cmdFile ]; then
	for file in $files; do
		$cmdFile $file;
	done;
else
	echo "$files"
fi
echo
echo "Si hay archivos en un formato que no sea ASCII ni $srcEncoding, los archivos de destino no serán correctos."
echo "Si hay archivos en $toDir, serán sobreescritos."
echo

cd "$wd"
for file in $files; do
	echo "$toDir/$file"
	$cmdTouch "$toDir"/$file
	$cmdIconv --from $srcEncoding --to $destEncoding -o "$toDir"/$file "$fromDir"/$file
done

