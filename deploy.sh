#!/usr/bin/env bash
set -eo pipefail

SOURCE_DIR="src"
INPUT_ARTICLE_DIR="articles"

BUILD_DIR="build"
OUTPUT_ARTICLE_DIR="blog"

PUBLIC_DIR="public"
IMAGES_DIR="images"
JS_DIR="js"

CSS_DIR="css"

PREFIX="Ramblings of an Enzyme"
TEMPLATE="./include/template.html"

build_file() {
    pandoc "$1" \
        -o "$2" \
        --template "$TEMPLATE" \
        --title-prefix "$PREFIX" \
        --highlight-style monochrome \
        -V lang:en
}

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/$OUTPUT_ARTICLE_DIR

cp -r $SOURCE_DIR/$JS_DIR $BUILD_DIR/
cp -r $SOURCE_DIR/$IMAGES_DIR $BUILD_DIR/
cp -r $SOURCE_DIR/$CSS_DIR $BUILD_DIR/
cp -r $SOURCE_DIR/$PUBLIC_DIR $BUILD_DIR/

cp $SOURCE_DIR/CNAME $BUILD_DIR/CNAME
cp $SOURCE_DIR/keybase.txt $BUILD_DIR/keybase.txt

for FILE in $(find $SOURCE_DIR/$INPUT_ARTICLE_DIR -type f -printf "%f\n"); do
    OUTPUT="./$BUILD_DIR/$OUTPUT_ARTICLE_DIR/${FILE%%.*}.html"

    build_file "$SOURCE_DIR/$INPUT_ARTICLE_DIR/$FILE" "$OUTPUT"
done

for FILE in $(find $SOURCE_DIR -maxdepth 1 -name "*.md" -type f -printf "%f\n"); do
    OUTPUT="./$BUILD_DIR/${FILE%%.*}.html"

    build_file "$SOURCE_DIR/$FILE" "$OUTPUT"
done

for FILE in $(find $SOURCE_DIR -maxdepth 1 -name "*.html" -type f -printf "%f\n"); do
    cp "$SOURCE_DIR/$FILE" "$BUILD_DIR/$FILE";
done
