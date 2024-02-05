#!/bin/bash

if [ -z "$API_GIT_SRC" ] ; then
    repo=https://github.com/pb-it/ark-cms-api
else
    repo=$API_GIT_SRC
fi

if [ -z "$API_GIT_TAG" ] ; then API_GIT_TAG="$CMS_GIT_TAG" ; fi
if [ -z "$API_GIT_TAG" ] ; then
    git clone "$repo" ;
else
    git clone "$repo" -b "$API_GIT_TAG" --depth 1 ;
fi
cd ark-cms-api
npm install --legacy-peer-deps