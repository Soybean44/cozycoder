urutora = require("urutora.urutora")
local u = urutora:new()

function love.load()
	local clickMe = u.text()
	u:add(clickMe)
end

function love.update(dt)
	u:update(dt)
end

function love.draw()
	u:draw()
end

function love.mousepressed(x, y, button)
	u:pressed(x, y)
end
function love.mousemoved(x, y, dx, dy)
	u:moved(x, y, dx, dy)
end
function love.mousereleased(x, y, button)
	u:released(x, y)
end
function love.textinput(text)
	u:textinput(text)
end
function love.keypressed(k, scancode, isrepeat)
	u:keypressed(k, scancode, isrepeat)
end
function love.wheelmoved(x, y)
	u:wheelmoved(x, y)
end
