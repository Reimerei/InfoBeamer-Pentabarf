gl.setup(1920, 1440)

font = resource.load_font("OpenSans-Regular.ttf")
font_bold = resource.load_font("OpenSans-Bold.ttf")
font_italic = resource.load_font("OpenSans-Italic.ttf")

yellow =  resource.load_image("yellow.png")

font_r = 75 / 255
font_g = 75 / 255
font_b = 74 / 255
font_a = 1

function node.render()
	
	-- First the stuff we will always draw	
	gl.clear(255, 255, 255, 1) -- white

    yellow:draw(0, 0, WIDTH, 60)

    font_bold:write(30, 90, "LiMA13  FAIR | ÄNDERN ", 60, font_r, font_g, font_b, font_a)
    font_italic:write(30, 160, "Deutschlands größter linksalternativer Medienkongress", 50, font_r, font_g, font_b, font_a)

    --font:write(50, 230, "Programm", 60, font_r, font_g, font_b, font_a)

    render_slot(50, 350)
    render_slot(50, 900)
    --render_slot(50, 950)

end

function render_slot(pos_x, pos_y)

	
	yellow:draw(pos_x, pos_y, pos_x + 600, pos_y + 70)

    font_bold:write(pos_x + 10, pos_y + 12 , "LiMAsalon HG 239", 50, font_r, font_g, font_b, font_a)

    font:write(pos_x + 650, pos_y + 12 , "8:00 bis 9:30", 50, font_r, font_g, font_b, font_a)

    font_bold:write(pos_x + 50, pos_y + 100 , "Eröffnung der LiMAwerkstattwoche mit \"wonderland - Wunderland\"", 50, font_r, font_g, font_b, font_a)

    font_italic:write(pos_x + 50, pos_y + 160 , "Künstler der Ausstellung im Deutschen Bundestag stellen das Konzept vor", 45, font_r, font_g, font_b, font_a)

    font:write(pos_x + 50, pos_y + 240 , "Wolfgang Gehrcke (MdB)", 50, font_r, font_g, font_b, font_a)
    font:write(pos_x + 50, pos_y + 300 , "Christoph Nitz | Linke Medienakademie e.V.", 50, font_r, font_g, font_b, font_a)
    font:write(pos_x + 50, pos_y + 360 , "Gerd-Rüdiger Stephan | Rosa Luxemburg Stiftung (RLS)", 50, font_r, font_g, font_b, font_a)

end

