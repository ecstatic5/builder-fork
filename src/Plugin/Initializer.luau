local Initializer = {}

function Initializer.GetSettings(plugin: Plugin) end

function Initializer.ApplyDecoratorFolders()
	local decoratorsFolder = Instance.new("Folder")

	-- This is probably gonna change into making most of the Decorators inside the Gui
	decoratorsFolder.Name = "Decorators"
	decoratorsFolder.Parent = script.Parent.Parent
	-- Expected to be at the top of the plugin
end

return Initializer
