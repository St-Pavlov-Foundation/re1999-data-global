-- chunkname: @modules/logic/versionactivity2_7/newinsight/view/ActivityInsightShowView_2_7Container.lua

module("modules.logic.versionactivity2_7.newinsight.view.ActivityInsightShowView_2_7Container", package.seeall)

local ActivityInsightShowView_2_7Container = class("ActivityInsightShowView_2_7Container", BaseViewContainer)

function ActivityInsightShowView_2_7Container:buildViews()
	local views = {}

	table.insert(views, ActivityInsightShowView_2_7.New())

	return views
end

return ActivityInsightShowView_2_7Container
