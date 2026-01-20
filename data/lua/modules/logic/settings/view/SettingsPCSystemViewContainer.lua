-- chunkname: @modules/logic/settings/view/SettingsPCSystemViewContainer.lua

module("modules.logic.settings.view.SettingsPCSystemViewContainer", package.seeall)

local SettingsPCSystemViewContainer = class("SettingsPCSystemViewContainer", BaseViewContainer)

function SettingsPCSystemViewContainer:buildViews()
	local views = {}

	table.insert(views, SettingsPCSystemView.New())

	return views
end

function SettingsPCSystemViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return SettingsPCSystemViewContainer
