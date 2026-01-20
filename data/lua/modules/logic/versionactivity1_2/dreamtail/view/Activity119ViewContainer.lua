-- chunkname: @modules/logic/versionactivity1_2/dreamtail/view/Activity119ViewContainer.lua

module("modules.logic.versionactivity1_2.dreamtail.view.Activity119ViewContainer", package.seeall)

local Activity119ViewContainer = class("Activity119ViewContainer", BaseViewContainer)

function Activity119ViewContainer:buildViews()
	return {
		Activity119View.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Activity119ViewContainer:buildTabViews(tabContainerId)
	local navigateView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 169)

	return {
		navigateView
	}
end

function Activity119ViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.DreamTail)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.DreamTail
	})
end

function Activity119ViewContainer:playOpenTransition()
	local data = Activity119Model.instance:getData()
	local config = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, data.lastSelectDay)
	local anim = "nomal"

	if data.lastSelectModel == 2 and DungeonModel.instance:hasPassLevel(config.normalCO.id) then
		anim = "hard"
	end

	Activity119ViewContainer.super.playOpenTransition(self, {
		anim = anim
	})
end

function Activity119ViewContainer:playCloseTransition()
	local data = Activity119Model.instance:getData()
	local anim = "normalclose"

	if data.lastSelectModel == 2 then
		anim = "hardclose"
	end

	Activity119ViewContainer.super.playCloseTransition(self, {
		anim = anim
	})
end

return Activity119ViewContainer
