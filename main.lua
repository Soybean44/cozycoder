local InputField = require("lib.InputField")
local ui = require("ui")

local field = InputField("", "multiwrap", 400, 400)
local fieldX = 80
local fieldY = 50
local fieldW = 400
local fieldH = 400

field:setDimensions(fieldW, fieldH)

love.keyboard.setKeyRepeat(true)

function love.load()
	ui:init()
end
function love.keypressed(key, scancode, isRepeat)
	ui:keypressed(key, isRepeat)
end
function love.textinput(text)
	ui:textinput(text)
end
function love.mousepressed(mx, my, mbutton, pressCount)
	ui:mousepressed(mx - fieldX, my - fieldY, mbutton, pressCount)
end
function love.mousemoved(mx, my)
	ui:mousemoved(mx - fieldX, my - fieldY)
end
function love.mousereleased(mx, my, mbutton)
	ui:mousereleased(mx - fieldX, my - fieldY, mbutton)
end
function love.wheelmoved(dx, dy)
	ui:wheelmoved(dx, dy)
end
function love.draw()
	ui:draw()
end
function love.update(dt)
	ui:update(dt)
end
