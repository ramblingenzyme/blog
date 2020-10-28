#!/usr/bin/env bash
set -eo pipefail

BUILD_FILE=build.ninja
BUILD_DIR="build"
COPIED_DIRS=( js images css public )
COPIED_FILES=( CNAME keybase.txt )

rm $BUILD_FILE 2>/dev/null || true

write() {
    echo "$@" | tee -a $BUILD_FILE
}

variable() {
    write "$1 = $2"
}

rule() {
    local name=$1
    shift

    write "rule $name"
    write " description = $name \$in \$out"
    write " command = $@"
}

build() {
    local output=$1
    shift

    write "build $output: $@"
}

build_md() {
    local file=""
    local idir=$1
    local odir="$BUILD_DIR/$2"

    if [ -z "$2" ]; then
        odir="$BUILD_DIR"
    fi

    for file in $(find "$idir" -maxdepth 1 -type f -name "*.md" -printf "%f\n"); do
        build \
            $odir/${file%%.*}.html \
            md2html $idir/$file
    done
}

rule \
    md2html \
    pandoc "\$in -o \$out --template \"include/template.html\" --title-prefix \"Ramblings of an Enzyme\"  --highlight-style monochrome -V lang:en"

rule \
    copy \
    cp "\$in \$out"

build_md "src/articles" "blog"
build_md "src"

for DIR in ${COPIED_DIRS[@]}; do
    for FILE in $(find src/$DIR -maxdepth 1 -not -name "*.md" -type f -printf "%f\n"); do
        build $BUILD_DIR/$DIR/$FILE copy src/$DIR/$FILE
    done
done

for FILE in ${COPIED_FILES[@]}; do
    build $BUILD_DIR/$FILE copy src/$FILE
done

for FILE in $(find src -maxdepth 1 -name "*.html" -type f -printf "%f\n"); do
    build $BUILD_DIR/$FILE copy src/$FILE
done

