local ui = {}
require("code")
local yui = require("lib.yui")
local InputField = require("lib.InputField")

local field = InputField("", "multiwrap", 400, 400)
local fieldX = 80
local fieldY = 50
local fieldW = 400
local fieldH = 400

field:setDimensions(fieldW, fieldH)

function ui:init()
	gui = yui.Ui:new({
		x = 500,
		y = fieldY + fieldH - 50,
		yui.Rows({
			yui.Button({
				w = 100,
				h = 50,
				text = "run",

				onHit = function()
					run_code()
				end,
				onActionInput = function() end,
			}),
		}),
	})
end

function ui:draw()
	gui:draw()
	love.graphics.setColor(0.2, 0.2, 0.2)
	love.graphics.rectangle("fill", fieldX, fieldY, fieldW, fieldH)

	love.graphics.setColor(0, 0, 1)
	for _, x, y, w, h in field:eachSelection() do
		love.graphics.rectangle("fill", fieldX + x, fieldY + y, w, h)
	end

	love.graphics.setColor(1, 1, 1)
	for _, text, x, y in field:eachVisibleLine() do
		love.graphics.print(text, love.math.newTransform(fieldX + x, fieldY + y))
	end

	local x, y, curr_h = field:getCursorLayout()
	love.graphics.rectangle("fill", fieldX + x, fieldY + y, 1, curr_h)
end

function ui:update(dt)
	gui:update(dt)
	text = field:getVisibleText()
	load_code(text, { print = print })
end

function ui:keypressed(key, isRepeat)
	field:keypressed(key, isRepeat)
end
function ui:textinput(text)
	field:textinput(text)
end
function ui:mousepressed(mx, my, mbutton, pressCount)
	field:mousepressed(mx - fieldX, my - fieldY, mbutton, pressCount)
end
function ui:mousemoved(mx, my)
	field:mousemoved(mx - fieldX, my - fieldY)
end
function ui:mousereleased(mx, my, mbutton)
	field:mousereleased(mx - fieldX, my - fieldY, mbutton)
end
function ui:wheelmoved(dx, dy)
	field:wheelmoved(dx, dy)
end

return ui
