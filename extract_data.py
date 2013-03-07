#!/usr/bin/python

###########################################################
##  This script gets the csv export from pentabarf, 
##  extracts the neccessary data and saves it as a json
###########################################################

import csv
import json
import datetime
import codecs

# parses csv file and returns array with data
def load_csv(filename):

	file = open(filename, 'rt')

	reader = None
	data = []

	try:
		reader = csv.reader(file)

		for row in reader:

			data.append(row)
		
	finally:
		file.close()

	#sort users by invite_code
	return data

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
#5	Start time
#6	End Time

def extract_data(data) :

	display_data = []

	row_count = 0

	#now = datetime.datetime.now()
	now = datetime.datetime(2013, 03, 13, 18, 0)
	print "The time is " + str(now)

	for row in data :

		# check date
		date = row[7].split('-')
		time = row[8].split(':')
		duration = row[10].split(':')

		if len(date) == 3 and len(time) == 3 and len(duration) == 3:

			start = datetime.datetime(int(date[0]), int(date[1]), int(date[2]), int(time[0]), int(time[1]))
			end = start + datetime.timedelta(hours = int(duration[0]), minutes = int(duration[1]))

			if now >= start and now <= end :

				display_row = [row[9], row[1], row[2], row[5], start.strftime('%H:%M'), end.strftime('%H:%M')]
				display_data.append(display_row)

		else :

			print "Invalid row: " + str(row_count)

		row_count += 1

	return display_data

def write_json(filename, data):

	#w = codecs.open(filename , "w", "utf-8")
	w = open(filename, "w")

	#writer = codecs.getwriter('utf-8')(file(filename,'w'))

	try:

		w.write("[")

		l=0

		for line in data :

			w.write("[")

			c=0
			for cell in line :

				c += 1
				if c < len(line) :
					w.write("\"" + cell + "\", ")
				else :
					w.write("\"" + cell + "\"")

			l += 1
			if l < len(data) :
				w.write("], ")
			else :
				w.write("]")

		w.write("]")

	finally:
		w.close()

	
data = load_csv("export.csv")
del data[0]

display_data = extract_data(data)

write_json("node/data.json", display_data)


