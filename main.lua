local InputField = require("lib.InputField")
local yui = require("lib.yui")

local field = InputField("", "multiwrap", 400, 400)
local fieldX = 80
local fieldY = 50
local fieldW = 400
local fieldH = 400

field:setDimensions(fieldW, fieldH)

local program, err

love.keyboard.setKeyRepeat(true)

function load_code(code, environment)
	if setfenv and loadstring then
		local f, err = loadstring(code)
		if f then
			setfenv(f, environment)
			return f, nil
		else
			return nil, err
		end
	else
		return assert(load(code, nil, "t", environment))
	end
end
function run_code()
	if program then
		if not pcall(program) then
			print("THE USER IS TRYING TO HACK US HELPPPP!!!")
		end
	else
		print(err)
	end
end
function love.load()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()

	ui = yui.Ui:new({
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
			}),
		}),
	})
end
function love.keypressed(key, scancode, isRepeat)
	field:keypressed(key, isRepeat)
end
function love.textinput(text)
	field:textinput(text)
end
function love.mousepressed(mx, my, mbutton, pressCount)
	field:mousepressed(mx - fieldX, my - fieldY, mbutton, pressCount)
end
function love.mousemoved(mx, my)
	field:mousemoved(mx - fieldX, my - fieldY)
end
function love.mousereleased(mx, my, mbutton)
	field:mousereleased(mx - fieldX, my - fieldY, mbutton)
end
function love.wheelmoved(dx, dy)
	field:wheelmoved(dx, dy)
end
function love.draw()
	ui:draw()
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
function love.update(dt)
	ui:update(dt)
	text = field:getVisibleText()
	program, err = load_code(text, { print = print })
end
