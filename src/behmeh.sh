#!/bin/bash
sso_url='http://localhost/cgi-bin/behmeh.cgi?'$QUERY_STRING

# $PHANTOM_EXECUTABLE /data/behmeh.js $sso_url <-- TODO: make this work 
/data/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /data/behmeh.js $sso_url

