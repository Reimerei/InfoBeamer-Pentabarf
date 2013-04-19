#!/bin/bash

rsync info-beamer@netzwerkrecherche.org:events.csv events.csv -zv
./extract_json.py
