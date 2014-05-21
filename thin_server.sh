#!/bin/sh
BASEDIR=$(dirname $0)
cd $BASEDIR
/usr/local/bin/bundle exec thin -e production --tag EOTDIGEST --socket tmp/sockets/thin.sock $@
