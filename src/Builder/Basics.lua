--[[
    This implements functions such as moving/resizing/rotating
    parts or any type of 3D element in the workspace

    Most of the current functions are empty...
]]
local ChecksAndAsserts = require(script.Parent.ChecksAndAsserts)
local Basics = {}

function Basics.Resize(toResize: BasePart | Model, resizeVector: Vector3, fixedPosition: boolean?)
	-- TODO: Make operator work as an Enum
	assert(toResize, "Expected 'BasePart' or 'Model' for 'toResize' argument")

	if toResize:IsA("BasePart") then
		toResize.Size += resizeVector

		if not fixedPosition then
			return
		end

		-- This makes the effect of a "fixed" position when in reality is just some
		-- easy position adjustment
		toResize.Position += resizeVector / 2

		return
	end

	-- TODO: Make models work
end

function Basics.Rotate() end

return Basics
