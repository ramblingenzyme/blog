#!/usr/bin/env bash
SOURCE_DIR="src"
INPUT_ARTICLE_DIR="articles"

BUILD_DIR="build"
OUTPUT_ARTICLE_DIR="blog"

IMAGES_DIR="images"
JS_DIR="js"

CSS_DIR="css"

PREFIX="Ramblings of an Enzyme"
TEMPLATE="./include/template.html"

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/$OUTPUT_ARTICLE_DIR

cp -r $SOURCE_DIR/$JS_DIR $BUILD_DIR/
cp -r $SOURCE_DIR/$IMAGES_DIR $BUILD_DIR/
cp -r $SOURCE_DIR/$CSS_DIR $BUILD_DIR/

cp $SOURCE_DIR/CNAME $BUILD_DIR/CNAME
cp $SOURCE_DIR/keybase.txt $BUILD_DIR/keybase.txt

for FILE in $(find $SOURCE_DIR/$INPUT_ARTICLE_DIR -type f -printf "%f\n"); do
    OUTPUT="./$BUILD_DIR/$OUTPUT_ARTICLE_DIR/${FILE%%.*}.html"
    echo "$FILE : $SOURCE_DIR/$INPUT_ARTICLE_DIR/$FILE : $OUTPUT"

    pandoc "$SOURCE_DIR/$INPUT_ARTICLE_DIR/$FILE" \
        -o "$OUTPUT" \
        --template "$TEMPLATE" \
        --title-prefix "$PREFIX" \
        --highlight-style monochrome \
        -V lang:en
done

for FILE in $(find $SOURCE_DIR -maxdepth 1 -name "*.md" -type f -printf "%f\n"); do
    OUTPUT="./$BUILD_DIR/${FILE%%.*}.html"
    echo "$FILE : $SOURCE_DIR/$FILE : $OUTPUT"

    pandoc "$SOURCE_DIR/$FILE" \
        -o "$OUTPUT" \
        --template "$TEMPLATE" \
        --title-prefix "$PREFIX" \
        --highlight-style monochrome \
        -V lang:en
done
