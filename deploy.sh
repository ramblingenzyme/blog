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
            ;;
        *)
            output="./blog/${file%%.*}.html"
    esac
    pandoc "./md/$file"     \
    -o $output              \
    -c css/style.css        \
    -B include/navbar.html  \
    --title-prefix "Ramblings of an Enzyme"
done
