local Basics = require(script.Basics)
local Decorators = require(script.Decorators)
local DefaultSettings = require(script.Default.Settings)

local Errors = {
	UnableToSetActiveSelection = "Unable to set active selection: %s",
	BindWrong = "Unable to bind function '%s': %s",
}

local Builder = {}
Builder.__index = Builder

function Builder:_SettingsExists(): boolean
	if not self.settings and #self.settings == 0 then
		return false
	end

	return true
end

function Builder:_OnSelection(deselection: boolean): ()
	print("New selection/deselection: " .. self.activeSelection.Name)

	if self._onSelectFn then
		task.spawn(self._onSelectFn, self.activeSelection, deselection)
	end

	-- Before applying everything
	if not self:_SettingsExists() then
		return
	end

	-- Apply selection decorators
	if self.settings.selection.showHighlight then
		Decorators:ToggleHighlight(self.activeSelection)
	end

	if self.settings.selection.showBox then
		Decorators:ToggleSelectionBox(self.activeSelection)
	end
end

function Builder.Init(settings: { [string]: any }?)
	print("Initialized Builder plugin!") -- DEBUG

	local self = {}
	
	self.activeSelection = nil
	self._onSelectFn = nil
	self.settings = DefaultSettings
	print(self.settings, DefaultSettings)

	Decorators = Decorators.Init(script.Parent:FindFirstChild("Decorators"))

	setmetatable(self, Builder)

	return self
end

function Builder:Resize(resizeFactor: number)
	if not self.activeSelection then
		return
	end

	Basics.Resize(self.activeSelection, 0, Vector3.new(0, 0, 1) * resizeFactor)
end

---Binds a function that will be called when a BasePart/Model is selected!
---@param fn function
---@return nil
function Builder:BindOnSelect(fn: (object: BasePart | Model, isDeselected: boolean) -> ())
	assert(fn, Errors.BindWrong:format("OnSelect", "Function passed is nil!"))
	assert(
		typeof(fn) == "function",
		Errors.BindWrong:format("OnSelect", "Function passed is not a function!")
	)

	self._onSelectFn = fn
end

---@param mouse PluginMouse
---@return BasePart? | Model?
function Builder:GetSelectionFromMouse(mouse: PluginMouse): (BasePart | Model)?
	local selection = mouse.Target

	if not selection then
		return nil
	end

	if not selection:IsA("BasePart") or not selection:IsA("Model") then
		self:SetActiveSelection(selection)
	end

	return selection
end

---This sets an active selection that we will use on different actions
---@param selection BasePart | Model
function Builder:SetActiveSelection(selection: BasePart | Model): ()
	if not self.settings.selection.enabled then
		return
	end

	assert(
		selection:IsA("BasePart") or selection:IsA("Model"),
		Errors.UnableToSetActiveSelection:format("Selection is not a BasePart or a Model")
	)

	self.activeSelection = selection
	self:_OnSelection()
end

return Builder
