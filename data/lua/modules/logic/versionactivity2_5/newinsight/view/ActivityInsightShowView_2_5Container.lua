-- chunkname: @modules/logic/versionactivity2_5/newinsight/view/ActivityInsightShowView_2_5Container.lua

module("modules.logic.versionactivity2_5.newinsight.view.ActivityInsightShowView_2_5Container", package.seeall)

local ActivityInsightShowView_2_5Container = class("ActivityInsightShowView_2_5Container", BaseViewContainer)

function ActivityInsightShowView_2_5Container:buildViews()
	local views = {}

	table.insert(views, ActivityInsightShowView_2_5.New())

	return views
end

return ActivityInsightShowView_2_5Container
