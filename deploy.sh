#!/usr/bin/env bash
for file in $(ls md/); do
    echo $file
    case $file in
        "about.md")
            ;&
        "archive.md")
            ;&
        "index.md")
            output="./${file%%.*}.html"
            css="css/style.css"
            ;;
        *)
            output="./blog/${file%%.*}.html"
            css="../css/style.css"
    esac
    pandoc "./md/$file"     \
    -o $output              \
    -c $css                 \
    -B include/navbar.html  \
    --title-prefix "Ramblings of an Enzyme"
done
