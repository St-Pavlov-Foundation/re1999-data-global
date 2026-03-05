-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorEpisodeLevelViewContainer.lua

module("modules.logic.versionactivity3_3.igor.view.IgorEpisodeLevelViewContainer", package.seeall)

local IgorEpisodeLevelViewContainer = class("IgorEpisodeLevelViewContainer", BaseViewContainer)

function IgorEpisodeLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, IgorEpisodeLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function IgorEpisodeLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function IgorEpisodeLevelViewContainer:onContainerInit()
	local activityId = self.viewParam and self.viewParam.activityId

	if not activityId then
		return
	end

	ActivityEnterMgr.instance:enterActivity(activityId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		activityId
	})
end

return IgorEpisodeLevelViewContainer
