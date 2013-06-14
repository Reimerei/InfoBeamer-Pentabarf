#!/usr/bin/python

import sys
import json
import twitter
import urllib
import datetime
import os
from cStringIO import StringIO

#api = twitter.Api(debugHTTP=True,use_gzip_compression=True)



#tweets_user = [dict(
#    text = tweet.text,
#    time = datetime.datetime.fromtimestamp(tweet.created_at_in_seconds).strftime("%H:%M"),
#    sec = tweet.created_at_in_seconds,
#    ) for tweet in api.GetUserTimeline(
#        id = sys.argv[1],
#        count = 5,
#	include_rts = True,
#    )]


#tweets = sorted(tweets_user, key=lambda x: x['sec'])

#for n, tweet in enumerate(tweets):
#    img = "profile%02d" % (n+1)
#    image = Image.open(StringIO(urllib.urlopen(tweet['image']).read()))
#    image.convert('RGB').save(img, 'JPEG')
#    tweet['image'] = img
#    print tweet['time'], repr(tweet['text'])

#full_path = os.path.realpath(__file__)
#path = os.path.dirname(full_path) + "/node/tweets.json"

#file(path, "wb").write(json.dumps(tweets,ensure_ascii=False).encode("utf8"))

print "Twitter changed their API m)"