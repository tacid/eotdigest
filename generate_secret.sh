#!/bin/sh
secret_file="config/secrets.yml"

if [ -f ${secret_file} ]; then
    echo You already has ${secret_file} file
    exit 0
else
    SECRET=`bundle exec rake secret`
    RETVAL=$?
    [ $RETVAL -eq 0 ] || exit $RETVAL
    echo "production:" > ${secret_file}
    echo "  secret_key_base: $SECRET" >> ${secret_file}
fi
