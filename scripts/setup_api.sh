if [ -z "$API_GIT_TAG" ] ; then API_GIT_TAG="$CMS_GIT_TAG" ; fi
if [ -z "$API_GIT_TAG" ] ; then
    git clone https://github.com/pb-it/wing-cms-api ;
else
    git clone https://github.com/pb-it/wing-cms-api -b "$API_GIT_TAG" --depth 1 ;
fi
cd wing-cms-api
npm install --legacy-peer-deps