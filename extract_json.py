#!/usr/bin/python

###########################################################
##  This script gets the csv export from pentabarf, 
##  extracts the neccessary data and saves it as a json
###########################################################

import csv
import datetime
import textwrap
import os
import time
import json

max_title = 60
max_subtitle = 140

# parses csv file and returns array with data
def load_csv(filename):

	file = open(filename, 'rt')

	reader = None
	data = []


	try:
		reader = csv.reader(file)

		for i, row in enumerate(reader):

			date = row[7].split('-')
			time = row[8].split(':')
			duration = row[10].split(':')

			if len(date) == 3 and len(time) == 3 and len(duration) == 3:

				nrow = {}
				nrow['start'] = datetime.datetime(int(date[0]), int(date[1]), int(date[2]), int(time[0]), int(time[1]))
				nrow['end'] = nrow['start'] + datetime.timedelta(hours = int(duration[0]), minutes = int(duration[1]))
				nrow['speakers'] = row[5]
				nrow['room'] = row[9]
				nrow['title'] = row[1]
				nrow['subtitle'] = row[2]

				data.append(nrow)
			else :
				print "Invalid row" + str(i)
		
	finally:
		file.close()

	#sort users by invite_code
	return sorted(data, key=lambda x: x['room'])

# Columns in pentabarf export
#0	ID
#1	Event title
#2	Subtitle of the event
#3	Slug
#4	Event Origin
#5	Speakers
#6	Event state
#7	Day
#8	Start time
#9	Room
#10	Duration
#11	Public event
#12	Track
#13	Abstract
#14	Full Description
#15	Submission of paper for proceedings
#16	Submission of presentation slides
#17	Language used for presentation
#18	Event type
#19	Notes
#20	Resources

# Columns in json
#0  Room
#1	Event title
#2	Subtitle of the event
#3	Speakers
#4	Start time
#5	End Time
#6	next Event title
#7	next Subtitle of the event
#8	next Speakers
#9	next Start time
#10	next End Time

def get_current_events(data) :

	#now = datetime.datetime.now()
	now = datetime.datetime(2013, 06, 14, 11, 01)
	print "The time is " + str(now)

	current_events = []

	# find events that are currently running
	for row in data :

		if now >= row['start'] and now <= row['end'] :

			rowj = {}

			rowj['title'] = textwrap.wrap(clean(row['title']), max_title)
			rowj['subtitle'] = textwrap.wrap(clean(row['subtitle']), max_subtitle)
			rowj['speakers'] = row['speakers'].split(", ")
			rowj['room'] = clean(row['room'])[:2]
			rowj['start'] = row['start'].strftime('%H:%M')
			rowj['end'] = row['end'].strftime('%H:%M')
			rowj['titlen'] = [""]
			rowj['startn'] = ""

			# find next event
			for rown in data :

				starte = row['start'].replace(hour=23, minute=59)

				if row['room'] == rown['room'] :

					if rown['start'].date() == row['start'].date() and rown['start'] >= row['end'] :
						# we have an event that happens later this day, now save the earliest only
						if  rown['start'] < starte :
							starte = rown['start']	

							rowj['titlen'] = textwrap.wrap(clean(rown['title']), max_title)
							rowj['subtitlen'] = textwrap.wrap(clean(rown['subtitle']), max_subtitle)
							rowj['speakersn'] = rown['speakers'].split(", ")
							rowj['startn'] = rown['start'].strftime('%H:%M')
							rowj['endn'] = rown['end'].strftime('%H:%M')

			current_events.append(rowj)		

	return current_events

def clean(string):
	ret = string.replace("\"", "")
	ret = ret.replace("\'", "")
	ret = ret.replace("AUSGEBUCHT!!! ", "")
	ret = ret.replace("AUSGEBUCHT!!!", "")

	if len(ret) == 0 :
		ret = " "

	return ret


def write_json(filename, data):

	js = "["

	for event in data :

		js += ",{" 

		for key, value in event.iteritems() :

			js += ",\"%s\": " % key

			if isinstance(value, list) :
				js += "["
				for item in value :
					js += ", \"%s\"" % item

				js += "]"
			else :
				js += "\"%s\"" % value		

		js += "}"
	js += "]"

	w = open(filename, "w")

	try:
		w.write(js)

	finally:
		w.close()

#os.system("INFOBEAMER_FULLSCREEN=1 info-beamer node/")
#os.system("info-beamer node/ &")

csv = load_csv("events.csv")
del csv[0]

events = get_current_events(csv)

k_data = []
r_data = []

for row in events :

	if row['room'].startswith("R") :
		r_data.append(row)
	elif row['room'].startswith("K") :
		k_data.append(row)

write_json("node/r_room.json", r_data)
write_json("node/k_room.json", k_data)


#write_json("node/r_room.json", r_data)
#write_json("node/k_room.json", k_data)


print "Extraction finished"


