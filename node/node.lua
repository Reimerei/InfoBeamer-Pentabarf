gl.setup(1920, 1440)

font = resource.load_font("OpenSans-Regular.ttf")
font_bold = resource.load_font("OpenSans-Bold.ttf")
font_italic = resource.load_font("OpenSans-Italic.ttf")

yellow =  resource.load_image("yellow.png")

font_r = 75 / 255
font_g = 75 / 255
font_b = 74 / 255
font_a = 1

-- load json with data
json = require "json"

util.file_watch("data.json", function(content)
    talks = json.decode(content)
end)

-- invoke the autoloader
util.auto_loader(_G)

function node.render()
	
	-- First the stuff we will always draw	
	gl.clear(255, 255, 255, 1) -- white

    yellow:draw(0, 0, WIDTH, 60)
    
    font_bold:write(30, 90, "LiMA13  FAIR | ÄNDERN ", 60, font_r, font_g, font_b, font_a)
    font_italic:write(30, 160, "Deutschlands größter linksalternativer Medienkongress", 50, font_r, font_g, font_b, font_a)

    --font:write(50, 230, "Programm", 60, font_r, font_g, font_b, font_a)

    render_slot(50, 350, 1)
    render_slot(50, 900, 2)
    --render_slot(50, 950)

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

    font:write(pos_x + 650, pos_y + 12 , talks[n][5] .. " bis " .. talks[n][6], 50, font_r, font_g, font_b, font_a)

    font_bold:write(pos_x + 50, pos_y + 100 , talks[n][2], 50, font_r, font_g, font_b, font_a)

    font_italic:write(pos_x + 50, pos_y + 160 , talks[n][3], 45, font_r, font_g, font_b, font_a)

    font:write(pos_x + 50, pos_y + 240 , talks[n][4], 50, font_r, font_g, font_b, font_a)
    --font:write(pos_x + 50, pos_y + 300 , "Christoph Nitz | Linke Medienakademie e.V.", 50, font_r, font_g, font_b, font_a)
    --font:write(pos_x + 50, pos_y + 360 , "Gerd-Rüdiger Stephan | Rosa Luxemburg Stiftung (RLS)", 50, font_r, font_g, font_b, font_a)

end

