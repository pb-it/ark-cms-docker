#!/bin/bash

if [ -z "$CMS_GIT_TAG" ] ; then
    buildExtensions=true
else
    #semver=( ${CMS_GIT_TAG//./ } )
    SEMVER_REGEX="^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)(\\-[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?(\\+[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?$"
    if [[ "$CMS_GIT_TAG" =~ $SEMVER_REGEX ]]; then
        major=${BASH_REMATCH[1]}
        minor=${BASH_REMATCH[2]}
        patch=${BASH_REMATCH[3]}
        prere=${BASH_REMATCH[4]}
        build=${BASH_REMATCH[5]}
        if [ "$major" -gt 0 ] || [ $minor -gt 4 ] || ([ $minor -eq 4 ] && [ $patch -ge 2 ]); then
            buildExtensions=true
        fi
    fi
fi

if [ "$buildExtensions" = true ] ; then
    git clone https://github.com/pb-it/ark-cms-extensions
    cd ark-cms-extensions
    ./build.sh >/dev/null
fi