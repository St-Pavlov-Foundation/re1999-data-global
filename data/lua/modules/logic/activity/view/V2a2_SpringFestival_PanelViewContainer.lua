-- chunkname: @modules/logic/activity/view/V2a2_SpringFestival_PanelViewContainer.lua

module("modules.logic.activity.view.V2a2_SpringFestival_PanelViewContainer", package.seeall)

local V2a2_SpringFestival_PanelViewContainer = class("V2a2_SpringFestival_PanelViewContainer", V2a2_SpringFestival_SignItemViewContainer)

function V2a2_SpringFestival_PanelViewContainer:onGetMainViewClassType()
	return V2a2_SpringFestival_PanelView
end

return V2a2_SpringFestival_PanelViewContainer
