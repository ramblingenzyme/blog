#!/usr/bin/env bash
SOURCE_DIR="src"
INPUT_ARTICLE_DIR="articles"

BUILD_DIR="build"
OUTPUT_ARTICLE_DIR="blog"

IMAGES_DIR="images"

CSS_DIR="css"
CSS="/css/style.css"

UI="./include/navbar.html"
PREFIX="Ramblings of an Enzyme"

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/$OUTPUT_ARTICLE_DIR

cp -r $SOURCE_DIR/$IMAGES_DIR $BUILD_DIR/
cp -r $SOURCE_DIR/$CSS_DIR $BUILD_DIR/
cp $SOURCE_DIR/CNAME $BUILD_DIR/CNAME
cp $SOURCE_DIR/keybase.txt $BUILD_DIR/keybase.txt

for FILE in $(find $SOURCE_DIR/$INPUT_ARTICLE_DIR -type f -printf "%f\n"); do
    echo $FILE
    OUTPUT="./$BUILD_DIR/$OUTPUT_ARTICLE_DIR/${FILE%%.*}.html"
    echo "$SOURCE_DIR/$INPUT_ARTICLE_DIR/$FILE"
    echo $OUTPUT

    pandoc "$SOURCE_DIR/$INPUT_ARTICLE_DIR/$FILE" \
        -o "$OUTPUT" \
        -c "$CSS"     \
        -B "$UI"       \
        --title-prefix "$PREFIX"
done

for FILE in $(find $SOURCE_DIR -maxdepth 1 -name "*.md" -type f -printf "%f\n"); do
    echo $FILE
    OUTPUT="./$BUILD_DIR/${FILE%%.*}.html"

    pandoc "$SOURCE_DIR/$FILE" \
        -o "$OUTPUT" \
        -c "$CSS"     \
        -B "$UI"       \
        --title-prefix "$PREFIX"
done
