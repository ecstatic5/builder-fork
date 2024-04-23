--[[
    This implements functions such as moving/resizing/rotating
    parts or any type of 3D element in the workspace

    Most of the current functions are empty...
]]

local Basics = {}

function Basics.Resize(toResize: BasePart | Model, operator: number, resizeToVector: Vector3)
	-- TODO: Make operator work as an Enum}
	-- TODO: Make Models work too

	if toResize:IsA("BasePart") then
		toResize.Size += resizeToVector
	end
end

function Basics.Rotate() end

return Basics
