#!/usr/bin/env bash
BUILD_DIR="build"
ARTICLE_DIR="blog"
CSS="/css/style.css"

for file in $(find md/articles/ -type f -printf "%f\n"); do
    echo $file
    output="./$BUILD_DIR/$ARTICLE_DIR/${file%%.*}.html"
    css="../css/style.css"

    pandoc "md/articles/$file"  \
        -o $output              \
        -c $CSS                 \
        -B include/navbar.html  \
        --title-prefix "Ramblings of an Enzyme"
done

for file in $(find md/ -maxdepth 1 -type f -printf "%f\n"); do
    echo $file
    output="./$BUILD_DIR/${file%%.*}.html"
    css="css/style.css"

    pandoc "md/$file"           \
        -o $output              \
        -c $CSS                 \
        -B include/navbar.html  \
        --title-prefix "Ramblings of an Enzyme"
done
