--[[
    This implements functions such as moving/resizing/rotating
    parts or any type of 3D element in the workspace

    Most of the current functions are empty...
]]
local ChecksAndAsserts = require(script.Parent.ChecksAndAsserts)
local Basics = {}

function Basics.Resize(toResize: BasePart | Model, resizeVector: Vector3, fixedPosition: boolean?)
	assert(
		typeof(toResize) == "Instance" and (toResize:IsA("BasePart") or toResize:IsA("Model")),
		"Expected 'toResize' datatype to be 'BasePart' or 'Model'"
	)

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

function Basics.Move(toMove: BasePart | Model, moveVector: Vector3)
	assert(
		typeof(toMove) == "Instance" and (toMove:IsA("BasePart") or toMove:IsA("Model")),
		"Expected 'toMove' datatype to be 'BasePart' or 'Model'"
	)

	if toMove:IsA("BasePart") then
		toMove.Position += moveVector

		return
	end
end

function Basics.Rotate() end

return Basics
