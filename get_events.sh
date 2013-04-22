#!/bin/bash

rsync info-beamer@netzwerkrecherche.org:events.csv events.csv -zv

# get location of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR
$DIR/extract_json.py
