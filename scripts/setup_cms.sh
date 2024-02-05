#!/bin/bash

if [ -z "$CMS_GIT_SRC" ] ; then
    repo=https://github.com/pb-it/ark-cms
else
    repo=$CMS_GIT_SRC
fi

if [ -z "$CMS_GIT_TAG" ] ; then
    buildStep=true
    git clone "$repo"
else
    #semver=( ${CMS_GIT_TAG//./ } )
    SEMVER_REGEX="^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)(\\-[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?(\\+[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?$"
    if [[ "$CMS_GIT_TAG" =~ $SEMVER_REGEX ]]; then
        major=${BASH_REMATCH[1]}
        minor=${BASH_REMATCH[2]}
        patch=${BASH_REMATCH[3]}
        prere=${BASH_REMATCH[4]}
        build=${BASH_REMATCH[5]}
        if [ "$major" -gt 0 ] || [ $minor -gt 5 ] || ([ $minor -eq 5 ] && [ $patch -ge 8 ]); then
            buildStep=true
        fi
    fi
    git clone "$repo" -b "$CMS_GIT_TAG" --depth 1
fi
cd ark-cms
npm install
if [ "$buildStep" = true ] ; then
    npm run build
fi
