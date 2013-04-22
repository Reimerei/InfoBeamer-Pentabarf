#!/usr/bin/python
import  datetime, json, os

now = datetime.datetime.now()

time = now.strftime('%H:%M')

full_path = os.path.realpath(__file__)
path = os.path.dirname(full_path) + "/node/time.json"

w = open(path, "w")
w.write(json.dumps(time))
w.close