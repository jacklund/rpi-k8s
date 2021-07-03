#!/bin/bash

# Script to create secret containing telegram token

echo -n 'token: '
read -r token

echo -n 'bot_ident: '
read -r bot_ident

tmpfile=$(mktemp)
echo '{' > $tmpfile
echo '  "telegram": {' >> $tmpfile
echo "    \"token\": \"${token}\"," >> $tmpfile
echo "    \"bot_ident\": \"${bot_ident}\"" >> $tmpfile
echo '  }' >> $tmpfile
echo '}' >> $tmpfile

kubectl create secret generic graphite-beacon --from-file=telegram.json=$tmpfile

rm -f $tmpfile
