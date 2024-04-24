local Basics = require(script.Basics)
local Decorators = require(script.Decorators)
local DefaultSettings = require(script.Default.Settings)
local Errors = require(script.Parent.Constants.Errors)

local Builder = {}
Builder.__index = Builder

function Builder:_SettingsExists(): boolean
	if not self.settings and #self.settings == 0 then
		return false
	end

	return true
end

function Builder:_OnSelection(deselection: boolean): ()
	print("New selection/deselection: " .. self.selectedInstance.Name)

	if self._onSelectFn then
		task.spawn(self._onSelectFn, self.selectedInstance, deselection)
	end

	self.isSelected = not deselection

	-- Before applying everything
	if not self:_SettingsExists() then
		return
	end

	-- Apply selection decorators
	if self.settings.selection.showHighlight then
		Decorators:ToggleHighlight(self.selectedInstance)
	end

	if self.settings.selection.showBox then
		Decorators:ToggleSelectionBox(self.selectedInstance)
	end
end

function Builder.Init(settings: { [string]: any }?)
	local self = {}

	self.selectedInstance = nil
	self.isSelected = false
	self._onSelectFn = nil
	self.settings = DefaultSettings
	print(self.settings, DefaultSettings)

	Decorators = Decorators.Init(workspace.Terrain) -- TESTING

	setmetatable(self, Builder)

	return self
end

function Builder:Resize(resizeFactor: number)
	if not self.selectedInstance or not self.isSelected then
		return
	end

	Basics.Resize(self.selectedInstance, Vector3.new(0, 0, 1) * resizeFactor, true)
end

function Builder:Move(moveFactor: number)
	if not self.selectedInstance or not self.isSelected then
		return
	end

	Basics.Move(self.selectedInstance, Vector3.new(0, 0, 1) * moveFactor)
end

---Binds a function that will be called when a BasePart/Model is selected!
---@param fn function
---@return nil
function Builder:BindOnSelect(fn: (object: BasePart | Model, isDeselected: boolean) -> ())
	assert(fn, Errors.BIND_WRONG_ERROR:format("OnSelect", "Function passed is nil!"))
	assert(
		typeof(fn) == "function",
		Errors.BIND_WRONG_ERROR:format("OnSelect", "Function passed is not a function!")
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
		self:SetSelection(selection)
	end

	return selection
end

---This sets a selection that we will use on different actions
---@param selection BasePart | Model
function Builder:SetSelection(selection: BasePart | Model)
	if not self.settings.selection.enabled then
		return
	end

	assert(
		selection:IsA("BasePart") or selection:IsA("Model"),
		Errors.UNABLE_TO_SET_SELECTION_INSTANCE_ERROR:format(
			"Selection is not a BasePart or a Model"
		)
	)

	if self.selectedInstance and self.selectedInstance ~= selection then
		-- Deselect current one and select the new one
		self:_OnSelection(true)

		self.selectedInstance = selection -- Apply new one
		self:_OnSelection(false)

		return
	elseif self.selectedInstance and self.selectedInstance == selection then
		-- Deselection
		self:_OnSelection(true)
		self.selectedInstance = nil

		return
	end

	-- Normal selection
	self.selectedInstance = selection
	self:_OnSelection(false)
end

return Builder
