#!/usr/bin/env bash
for file in $(ls md/); do
    echo $file
    pandoc "./md/$file" -o "${file%%.*}.html" -c css/style.css -B include/navbar.html -s
done
