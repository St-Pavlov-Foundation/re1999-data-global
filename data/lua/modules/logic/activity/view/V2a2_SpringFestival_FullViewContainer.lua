-- chunkname: @modules/logic/activity/view/V2a2_SpringFestival_FullViewContainer.lua

module("modules.logic.activity.view.V2a2_SpringFestival_FullViewContainer", package.seeall)

local V2a2_SpringFestival_FullViewContainer = class("V2a2_SpringFestival_FullViewContainer", V2a2_SpringFestival_SignItemViewContainer)

function V2a2_SpringFestival_FullViewContainer:onGetMainViewClassType()
	return V2a2_SpringFestival_FullView
end

return V2a2_SpringFestival_FullViewContainer
