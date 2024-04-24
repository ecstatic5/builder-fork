-- Services --
local SelectionService = game:GetService("Selection")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
-- Modules --
local Initializer = require(script.Parent.Plugin.Initializer)
Initializer.ApplyDecoratorFolders()
local Builder = require(script.Parent.Builder).Init()
-- Plugin --
local toolbar = plugin:CreateToolbar("Builder")
local mainButton = toolbar:CreateButton(0, "Enables Builder Plugin", "Builder", "Start Builder")

local mouse = plugin:GetMouse()

if not RunService:IsEdit() and not RunService:IsStudio() then
	return
end

local function OnMouseButton1Down()
	if not plugin:IsActivated() then
		return
	end

	Builder:GetSelectionFromMouse(mouse)
end

Builder:BindOnSelect(function(object, isDeselected)
	print(object.Name, isDeselected)
end)

task.spawn(function()
	while task.wait(0.01) do
		if
			UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt)
			and UserInputService:IsKeyDown(Enum.KeyCode.Up)
		then
			Builder:Resize(0.1)
		end
	end
end)

mouse.Button1Down:Connect(OnMouseButton1Down)

mainButton.Click:Connect(function()
	if plugin:IsActivated() then
		plugin:Deactivate()
		mainButton:SetActive(false)
		return
	end

	plugin:Activate(true)
	Initializer.GetSettings(plugin)

	mainButton:SetActive(true)
end)
