gl.setup(1920, 1080)

font = resource.load_font("MetaOffc-Norm.ttf")
font_bold = resource.load_font("MetaOffc-Bold.ttf")
font_italic = resource.load_font("MetaOffc-NormIta.ttf")
font_bold_italic = resource.load_font("MetaOffc-BoldIta.ttf")

font_r = 0
font_g = 0
font_b = 0
font_a = 1

font_red_r = 192 / 255
font_red_g = 7 / 255
font_red_b = 31 / 255
font_red_a = 1

-- logo
logo = resource.load_image("logo.png")
bg = resource.load_image("bg.png")
line_v = resource.load_image("line_v.png")
line_h = resource.load_image("line_h.png")

-- load json with data
json = require "json"

util.file_watch("k_room.json", function(content)
    k_room = json.decode(content)
end)

util.file_watch("r_room.json", function(content)
    r_room = json.decode(content)
end)

util.file_watch("time.json", function(content)
    time = json.decode(content)
end)

util.file_watch("tweets.json", function(content)
    
    tweets = {}

    for i, tweet in ipairs(json.decode(content))
    do
    	tweets[#tweets + 1] = tweet.text 
	end
end)

function tweet_feeder()
    return tweets
end

tweet_text = util.running_text{
    font = font;
    size = 50;
    speed = 100;
    color = {font_r, font_g, font_b, font_a};
    generator = util.generator(tweet_feeder)
}

-- invoke the autoloader
util.auto_loader(_G)

function node.render()
	
	gl.clear(255, 255, 255, 1) -- white

    bg:draw(0, 0, WIDTH, HEIGHT)

    -- Everything on the right
    rx = 1300
    ry = 60

    line_v:draw(rx, 40, rx + 7, HEIGHT - 90)

    rx = rx + 40

    logo_x = rx + 30
    logo_scale = 1.6
    logo:draw(logo_x, ry, logo_x + (293 * logo_scale) , ry + (103 * logo_scale) )

    ry = ry + (103 * logo_scale) + 30
    
    line_h:draw(rx, ry, WIDTH - 40, ry + 7)

    ry = ry + 40

    font_bold:write(rx + 10, ry, time, 200, font_red_r, font_red_g, font_red_b, font_red_a)

    ry = ry + 220

	line_h:draw(rx, ry, WIDTH - 40, ry + 7)

	ry = ry + 40

	font_bold:write(rx, ry, "R-Räume", 50, font_r, font_g, font_b, font_a)

	ry = ry + 80

	for i, event in ipairs(r_room)
	do
    	font_bold:write(rx, ry, event.room, 30 , font_red_r, font_red_g, font_red_b, font_red_a)
    	
    	for j, title in ipairs(event.title)
    	do
    		font:write(rx + 50, ry, title, 30 , font_red_r, font_red_g, font_red_b, font_red_a)
    		ry = ry + 35
    	end    	

    	if event.startn  ~= ""
    	then
    		font:write(rx, ry, "ab " .. event.startn,  25, font_r, font_g, font_b, font_a)

    		for j, title in ipairs(event.titlen)
        	do
        		font:write(rx + 120, ry, title, 25, font_r, font_g, font_b, font_a)
        		ry = ry + 20
        	end

    	end

    	ry = ry + 25
    	
        
    end

    -- Main Window

    x = 60
    y = 60

    font_bold:write(x, y, "K-Räume", 130, font_r, font_g, font_b, font_a)

    y = y + 170

    for i, event in ipairs(k_room)
	do
    	if 1 == 1
    	then

	    	font_bold:write(x, y, event.room, 60 , font_red_r, font_red_g, font_red_b, font_red_a)	    	
	    	
	    	for j, title in ipairs(event.title)
	    	do
	    		font:write(x + 100, y, title, 60 , font_red_r, font_red_g, font_red_b, font_red_a)
	    		y = y + 63
	    	end	    	

	    	if event.startn  ~= ""
	    	then
	    		font:write(x, y, "ab " .. event.startn,  50, font_r, font_g, font_b, font_a)

	    		for j, title in ipairs(event.titlen)
	        	do
	        		font:write(x + 250, y, title, 50, font_r, font_g, font_b, font_a)
	        		y = y + 40
	        	end

	    	end

	    	y = y + 40
	    end
    end    

    -- Bottom

    bx = x
    by = HEIGHT - 120

    --line_h:draw(40, by, rx - 80, by + 7)

    by = by + 50

    tweet_text:draw(by)


   
end

