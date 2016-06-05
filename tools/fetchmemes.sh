#!/bin/sh
# grab list of memes from imgur
curl -H "Authorization: Client-Id MYCLIENTID" https://api.imgur.com/3/memegen/defaults >../MemeMakerKit/memes.json"
