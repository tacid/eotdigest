#!/bin/sh
BASEDIR=$(dirname $0)
cd $BASEDIR
bundle exec thin -e production --tag EOTDIGEST -p 8080 $@
