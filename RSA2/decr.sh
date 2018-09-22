#!/bin/sh

# variable
RsaCtfTool="../tool/RsaCtfTool/RsaCtfTool.py"
TempDir="../tool/Temp"
Error="/tmp/tmp$3"

# prepare
date
echo "-----BEGIN PUBLIC KEY-----
$1
-----END PUBLIC KEY-----" > "$TempDir/pub-$3.pem"
echo "$2" > "$TempDir/msg-$3"

# crack
date
while [ 1 == 1 ]; do
## BOOMMMMMM
    $RsaCtfTool --publickey "$TempDir/pub-$3.pem" --private 1> "$TempDir/priv-$3.key" 2> "$Error"
    if [ -f "$TempDir/priv-$3.key" ]; then
        result=`cat "$TempDir/priv-$3.key" | wc -l | tr -d " "`
        if [ $(($result)) -lt 4 ]; then
            >&2 printf " [-] Failed once."
            continue
        else
            break
        fi
    else
        continue
    fi
done
date
$RsaCtfTool --dumpkey --key "$TempDir/priv-$3.key" 1> "$TempDir/priv_para-$3.key"

base64 --decode "$TempDir/msg-$3" > "$TempDir/ori_msg-$3"
openssl rsautl -decrypt -inkey "$TempDir/priv-$3.key" -in "$TempDir/ori_msg-$3" -out "$TempDir/ans-$3"
date

# output
cat "$TempDir/ans-$3"
printf "\n"
cat "$TempDir/priv_para-$3.key" | awk -F' ' '/\[\*\] (p|q):/{print $3}'
