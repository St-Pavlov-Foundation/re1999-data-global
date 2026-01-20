-- chunkname: @modules/logic/activity/view/show/ActivityInsightShowViewContainer.lua

module("modules.logic.activity.view.show.ActivityInsightShowViewContainer", package.seeall)

local ActivityInsightShowViewContainer = class("ActivityInsightShowViewContainer", BaseViewContainer)

function ActivityInsightShowViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityInsightShowView.New())

	return views
end

return ActivityInsightShowViewContainer
