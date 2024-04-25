-- Services --
local SelectionService = game:GetService("Selection")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
-- Modules --
local Initializer = require(script.Parent.Plugin.Initializer)
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

local function OnPluginButtonClick()
	if plugin:IsActivated() then
		plugin:Deactivate()
		mainButton:SetActive(false)
		return
	end

	plugin:Activate(true)

	mainButton:SetActive(true)
end

mainButton.Click:Connect(OnPluginButtonClick)
mouse.Button1Down:Connect(OnMouseButton1Down)
