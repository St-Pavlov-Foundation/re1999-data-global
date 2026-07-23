-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/TravelGoResultViewContainer.lua

module("modules.logic.versionactivity3_7.travelgo.view.TravelGoResultViewContainer", package.seeall)

local TravelGoResultViewContainer = class("TravelGoResultViewContainer", BaseViewContainer)

function TravelGoResultViewContainer:buildViews()
	local views = {
		TravelGoResultView.New()
	}

	return views
end

return TravelGoResultViewContainer
