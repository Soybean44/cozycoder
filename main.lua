local yui = require("yui")
function love.load()
	local w, h = 300, 80
	local x = math.floor((love.graphics.getWidth() - w) / 2)
	local y = math.floor((love.graphics.getHeight() - h) / 2)

	ui = yui.Ui:new({
		x = x,
		y = y,

		yui.Rows({
			yui.Label({
				w = w,
				h = h / 2,
				text = "Hello, World!",
			}),
			yui.Button({
				text = "Close",

				onHit = function()
					love.event.quit()
				end,
			}),
		}),
	})
end

function love.update(dt)
	ui:update(dt)
end

function love.draw()
	ui:draw()
end
