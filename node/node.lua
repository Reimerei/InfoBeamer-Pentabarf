gl.setup(1920, 1440)

font = resource.load_font("OpenSans-Regular.ttf")
font_bold = resource.load_font("OpenSans-Bold.ttf")
font_italic = resource.load_font("OpenSans-Italic.ttf")

yellow =  resource.load_image("yellow.png")

font_r = 75 / 255
font_g = 75 / 255
font_b = 74 / 255
font_a = 1

slide_delay=7 -- seconds

-- Logo
logo = resource.load_image("logo.png")

-- load json with data
json = require "json"

util.file_watch("data.json", function(content)
    talks = json.decode(content)
end)

-- invoke the autoloader
util.auto_loader(_G)

function node.render()
	
	gl.clear(255, 255, 255, 1) -- white

    yellow:draw(0, 0, WIDTH, 60)

    logo:draw(30, 90, 230, 290)

    font_bold:write(270, 130, "LiMA13  FAIR | ÄNDERN ", 60, font_r, font_g, font_b, font_a)
    font_italic:write(270, 200, "Deutschlands größter linksalternativer Medienkongress", 50, font_r, font_g, font_b, font_a)

    --font:write(50, 230, "Programm", 60, font_r, font_g, font_b, font_a)

    slide_cnt = math.floor((sys.now() / (slide_delay / 2 )))

    slide_num = math.floor((slide_cnt % talks[1]) / 2) *  2  + 2
    
    if slide_num > 1
    then  	    
	    if slide_num <= talks[1]+1
	    then
	    	render_slot(50, 350, slide_num)
	    end
	    if slide_num+1 <= talks[1]+1
	    then
	    	render_slot(50, 900, slide_num + 1)
	    end
	else
		font_bold:write(500, 700, "Kein Programm" , 100, font_r, font_g, font_b, font_a)
	end
end

function render_slot(pos_x, pos_y, n)
	-- Columns in json-data
	--1 Room
	--2	Event title
	--3	Subtitle of the event
	--4	Speakers
	--5	Start time
	--6	End Time
	
	yellow:draw(pos_x, pos_y, pos_x + 600, pos_y + 70)

    font_bold:write(pos_x + 10, pos_y + 12 , talks[n][1], 50, font_r, font_g, font_b, font_a)

    --font:write(pos_x + 650, pos_y + 12 , talks[n][5] .. " bis " .. talks[n][6], 50, font_r, font_g, font_b, font_a)
    font:write(pos_x + 650, pos_y + 12 , "bis " .. talks[n][6], 50, font_r, font_g, font_b, font_a)

    pos = pos_y + 100
    if talks[n][2][1] > 0 
    then
	    font_bold:write(pos_x + 50, pos, talks[n][2][2], 50, font_r, font_g, font_b, font_a)
	end
	    pos = pos + 60

    if talks[n][2][1] > 1 
    then
	    font_bold:write(pos_x + 50, pos, talks[n][2][3], 50, font_r, font_g, font_b, font_a)
    	pos = pos + 60
	end

	if talks[n][3][1] > 0 
    then
		font_italic:write(pos_x + 50, pos , talks[n][3][2], 45, font_r, font_g, font_b, font_a)
	end
    pos = pos + 45

	if talks[n][3][1] > 1 
    then
	    font_italic:write(pos_x + 50, pos, talks[n][3][3], 45, font_r, font_g, font_b, font_a)
    	pos = pos + 45
	end	
	pos = pos + 30

	if talks[n][4][1] > 0
    then
    	font:write(pos_x + 50, pos , talks[n][4][2], 50, font_r, font_g, font_b, font_a)
    end
    pos = pos + 55
    
    if talks[n][4][1] > 1 
    then
	    font:write(pos_x + 50, pos , talks[n][4][3], 50, font_r, font_g, font_b, font_a)
    	pos = pos + 55
	end

	if talks[n][4][1] > 2 
    then
	    font:write(pos_x + 50, pos , "...", 50, font_r, font_g, font_b, font_a)
    	pos = pos + 55
	end
end

