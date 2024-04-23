-- Services --
local CoreGui = game:GetService("CoreGui")
-- Modules --
local Roact = require(script.Parent.Roact)
-- Gui --
local Gui = {}

function Gui.Init()
	local main = Roact.createElement("ScreenGui", {}, {
		LilTestText = Roact.createElement("TextLabel", {
			Text = "Testing",
			Size = UDim2.new(0.25, 0, 0.1, 0),
		}),
	})

	Roact.mount(main, CoreGui, "BuilderGui")
end

return Gui
