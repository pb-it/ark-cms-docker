if [ -z "$CMS_GIT_TAG" ] ; then
    git clone https://github.com/pb-it/wing-cms ;
else
    git clone https://github.com/pb-it/wing-cms -b "$CMS_GIT_TAG" --depth 1 ;
fi
cd wing-cms
npm install