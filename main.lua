local ui = require("ui")

local width, height = love.window.getDesktopDimensions()

love.keyboard.setKeyRepeat(true)

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setMode(width, height, { fullscreen = false, resizable = true })
	ui:init(width, height)
end
function love.keypressed(key, scancode, isRepeat)
	ui:keypressed(key, isRepeat)
end
function love.textinput(text)
	ui:textinput(text)
end
function love.mousepressed(mx, my, mbutton, pressCount)
	ui:mousepressed(mx, my, mbutton, pressCount)
end
function love.mousemoved(mx, my)
	ui:mousemoved(mx, my)
end
function love.mousereleased(mx, my, mbutton)
	ui:mousereleased(mx, my, mbutton)
end
function love.wheelmoved(dx, dy)
	ui:wheelmoved(dx, dy)
end
function love.draw()
	ui:draw()
end
function love.resize(w, h)
	if w and h then
		ui:resize(w, h)
	end
end
function love.update(dt)
	ui:update(dt)
end
