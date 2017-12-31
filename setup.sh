#!/bin/bash
DEFAULTURL=example.com
GITTRELLIS=git@github.com:roots/trellis.git
GITBEDROCK=git@github.com:roots/bedrock.git
GITSAGE=git@github.com:roots/sage.git


echo "Please enter the site url (example.com):"

read URL
cd ..

if [ -z "$URL" ] 
then
  if [ -d "$URL" ]; then
    # Control will enter here if $DIRECTORY exists.
    echo "The directory $DEFAULTURL exists already! Aborting."
    exit 1
  else
    mkdir $DEFAULTURL
    git clone --depth=1 $GITTRELLIS && rm -rf trellis/.git
    git clone --depth=1 $GITBEDROCK site && rm -rf site/.git
    git clone --depth=1 $GITSAGE site/web/app/themes/sage && rm -rf site/web/app/themes/sage/.git
  fi
else
  if [ -d "$URL" ]; then
    # Control will enter here if $DIRECTORY exists.
    echo "The directory $URL exists already! Aborting."
    exit 1
  else
    mkdir $URL
    git clone --depth=1 $GITTRELLIS && rm -rf trellis/.git
    git clone --depth=1 $GITBEDROCK site && rm -rf site/.git
    git clone --depth=1 $GITSAGE site/web/app/themes/sage && rm -rf site/web/app/themes/sage/.git
  fi
fi

echo "Git repos successfully cloned. Please follow the instructions to create a new project."

cd ..
rm -rf wordpress-starter

echo "Removed wordpress-starter directory and files."

# if git diff --quiet composer.lock; then
#  echo "composer.lock has changes on disk or in the cache -- exiting"
#  echo "composer.lock must be in the state you wish to deploy, and be committed"
#  exit 1;
# fi


# change to deploy directory
#cd $DEPLOYDIR
#
#echo "getting code"
#
#if [ -d "$ENVDIR" ]; then
#  echo "found previous deploy, pulling new"
# cd $ENVDIR
# git remote add origin $DIR
# git pull origin $DEPLOYBRANCH || exit 1
#else
#  echo "NO previous deploy, cloning new"
#  git clone --branch $DEPLOYBRANCH $DIR $ENVDIR || exit 1
#  cd $ENVDIR
#fi
#git remote rm origin  || exit 1
#
#
#echo "performing composer install --no-dev"
#composer install --no-dev
#
#sleep 2
#
#
#echo "OK, does everything look good to deploy?"
#select yn in "Yes" "No"; do
#    case $yn in
#        Yes ) echo "OK, deploying"; break ;;
#        No ) exit 1;;
#    esac
#done
#
#
#
##cd $DEPLOYDIR
#echo "rsync to stage except for settings.php files and files/ "
#echo "wrapper directories around web are also sync'ed to include vendor and config etc.."
##rsync -va --delete --exclude=web/sites/default/files/ --exclude=web/sites/default/settings*.php --exclude=web/themes/custom/iass/iass-010-frontend-prototype/node_modules $ENVDIR/ $DEPLOYTARGET
#echo "don't forget to clear cache and import config on the server"
#echo "for instance: "
#echo "drush @iass-012.stage cr"
#echo "drush @iass-012.stage cim"
#echo "drush @iass-012.stage cr"
