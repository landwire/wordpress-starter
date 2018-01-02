#!/bin/bash
DEFAULTURL=example.com
DEFAULTFOLDER=example
DEFAULTTHEME=sagechild
GITTRELLIS=git@github.com:roots/trellis.git
GITBEDROCK=git@github.com:roots/bedrock.git
GITSAGE=git@github.com:roots/sage.git


echo "Please enter the site folder name ($DEFAULTFOLDER):"
read FOLDER

echo "Please enter the site url ($DEFAULTURL):"

read URL
cd ..

if [ -z "$FOLDER" ] ; then
  FOLDER=$DEFAULTFOLDER
  echo "FOLDER = $FOLDER"
fi

if mkdir -p "$FOLDER" ; then
  echo "1"
  cd $FOLDER
  git clone --depth=1 $GITTRELLIS && rm -rf trellis/.git
  cd trellis
  cd group_vars
  cd development
  sed -i '' -e "s/example.com/$FOLDER/g" vault.yml
  sed -i '' -e "s/example.com/$FOLDER/g" wordpress_sites.yml
  sed -i '' -e "s/example.test/$URL/g" wordpress_sites.yml

  cd ../../../
  git clone --depth=1 $GITBEDROCK site && rm -rf site/.git

  cd site/web/app/themes
  echo "Please enter the theme name ($DEFAULTTHEME):"
  read THEME

  if [ -z "$THEME" ] ; then
    THEME=$DEFAULTTHEME
  fi

  composer create-project roots/sage $THEME dev-master

  sleep 2

  cd $THEME
  yarn
  sleep 2
  yarn build
  sleep 2

  cd ../../../../../
  cd trellis
  vagrant up

  sleep 2

  # launch the browser
  OS=$(uname -s)
  case "$OS" in
    Darwin)
      open "http://$URL"
      ;;
    Linux)
      xdg-open "http://$URL"
    ;;
  esac

else
  echo "The directory $URL exists already! Aborting."
  exit 1
fi

#if [[ "$PWD" =~ "$URL" ]]; then
#  cd ..
#  rm -rf wordpress-starter
#
#  echo "Removed wordpress-starter directory and files."
#fi