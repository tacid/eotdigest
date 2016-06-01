#!/bin/sh
BASEDIR=$(dirname $0)
cd $BASEDIR
if [ -f ./thin-config.ini ]; then
  . ./thin-config.ini
  : ${name:=eotdigest}
  : ${bind:=0.0.0.0}
  : ${port:=3000}
  : ${environment:=production}
  bundle exec thin -e $environment --tag "$name" -a $bind -p $port $@
  exit $?

else
  echo "Error! Please configure thin-config.ini file"
  exit 1
fi;
