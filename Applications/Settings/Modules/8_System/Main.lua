
local GUI = require("GUI")
local MineOSInterface = require("MineOSInterface")
local MineOSPaths = require("MineOSPaths")
local MineOSCore = require("MineOSCore")
local computer = require("computer")
local unicode = require("unicode")

local module = {}

local mainContainer, window, localization = table.unpack({...})

--------------------------------------------------------------------------------

module.name = localization.system
module.margin = 3
module.onTouch = function()
	window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, localization.systemArchitecture))

	local CPUComboBox = window.contentLayout:addChild(GUI.comboBox(1, 1, 36, 3, 0xE1E1E1, 0x696969, 0xD2D2D2, 0xA5A5A5))
	local architectures, architecture = computer.getArchitectures(), computer.getArchitecture()
	for i = 1, #architectures do
		CPUComboBox:addItem(architectures[i]).onTouch = function()
			computer.setArchitecture(architectures[i])
			computer.shutdown(true)
		end

		if architecture == architectures[i] then
			CPUComboBox.selectedItem = i
		end
	end

	window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, localization.systemRAM))

	local RAMComboBox = window.contentLayout:addChild(GUI.comboBox(1, 1, 36, 3, 0xE1E1E1, 0x696969, 0xD2D2D2, 0xA5A5A5))
	RAMComboBox.dropDownMenu.itemHeight = 1

	local function update()
		local libraries = {}
		for key, value in pairs(package.loaded) do
			if _G[key] ~= value then
				table.insert(libraries, key)
			end
		end
		
		table.sort(libraries, function(a, b) return unicode.lower(a) < unicode.lower(b) end)

		RAMComboBox:clear()
		for i = 1, #libraries do
			RAMComboBox:addItem(libraries[i])
		end

		MineOSInterface.mainContainer:drawOnScreen()
	end

	window.contentLayout:addChild(GUI.button(1, 1, 36, 3, 0xE1E1E1, 0x696969, 0x696969, 0xE1E1E1, localization.systemUnload)).onTouch = function()
		package.loaded[RAMComboBox:getItem(RAMComboBox.selectedItem).text] = nil
		update()
	end

	local switch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, localization.systemUnloading .. ":", MineOSCore.properties.packageUnloading)).switch
	switch.onStateChanged = function()
		MineOSCore.properties.packageUnloading = switch.state
		MineOSCore.setPackageUnloading(MineOSCore.properties.packageUnloading)
		MineOSCore.saveProperties()
	end

	window.contentLayout:addChild(GUI.textBox(1, 1, 36, 1, nil, 0xA5A5A5, {localization.systemInfo}, 1, 0, 0, true, true))

	update()

	MineOSInterface.mainContainer:drawOnScreen()
end

--------------------------------------------------------------------------------

return module

