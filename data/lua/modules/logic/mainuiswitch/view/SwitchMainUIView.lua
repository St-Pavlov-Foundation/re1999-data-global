-- chunkname: @modules/logic/mainuiswitch/view/SwitchMainUIView.lua

module("modules.logic.mainuiswitch.view.SwitchMainUIView", package.seeall)

local SwitchMainUIView = class("SwitchMainUIView", MainUIPartView)

function SwitchMainUIView:addEvents()
	self:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, self.refreshMainUI, self)
end

function SwitchMainUIView:removeEvents()
	self:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, self.refreshMainUI, self)
end

return SwitchMainUIView
