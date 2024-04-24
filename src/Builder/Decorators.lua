-- Modules --
local ChecksAndAsserts = require(script.Parent.ChecksAndAsserts)
-- Decorators --
local Decorators = {}
Decorators.__index = Decorators

local Errors = {
	NilProperties = "Properties argument is nil or doesn't exist!",
	PropertiesAreNotA = "Properties argument is a '%s'! Expected to be a '%s'",
}

function Decorators:_CreateHighlight(properties: { [string]: any })
	ChecksAndAsserts:AssertType(properties, "table", Errors.PropertiesAreNotA)

	local highlight = Instance.new("Highlight")
	highlight.Parent = workspace.Terrain
	-- For now i will be saving decorators in the Terrain since
	-- i dont have anything else to save them
	highlight.Adornee = properties.applyTo

	return highlight
end

function Decorators:_CreateSelectionBox(properties: { [string]: any })
	local selectionBox = Instance.new("SelectionBox")

	selectionBox.Parent = workspace.Terrain
	selectionBox.Adornee = properties.applyTo
	selectionBox.LineThickness = properties.thickness

	return selectionBox
end

function Decorators:_FindDecoratorForInstance(findFor: BasePart | Model, type: string): Instance?
	for _, decorator in self.decoratorsFolder:GetChildren() do
		if not decorator:IsA(type) then
			continue
		end

		if decorator.Adornee == findFor then
			return decorator
		end
	end

	return nil
end

function Decorators.Init(decoratorsFolder: Folder, settings: { [string]: any })
	local self = {}
	self.decoratorsFolder = decoratorsFolder
	self.settings = {}

	setmetatable(self, Decorators)

	return self
end

function Decorators:ToggleHighlight(toHighlight: BasePart | Model)
	-- Search for an already created highlight decorator
	local highlight: Highlight? = self:_FindDecoratorForInstance(toHighlight, "Highlight")

	if highlight then
		highlight.Enabled = false

		return
	end

	highlight = self:_CreateHighlight({
		applyTo = toHighlight,
	})
end

function Decorators:ToggleSelectionBox(toSetBox: BasePart | Model)
	local selectionBox: SelectionBox? = self:_FindDecoratorForInstance(toSetBox, "SelectionBox")

	if selectionBox then
		selectionBox.Visible = false

		return
	end

	selectionBox = self:_CreateSelectionBox({
		thickness = 0.025,
		applyTo = toSetBox,
	})
end

return Decorators
