-- chunkname: @modules/logic/bossrush/view/V1a4_BossRushMainViewContainer.lua

module("modules.logic.bossrush.view.V1a4_BossRushMainViewContainer", package.seeall)

local V1a4_BossRushMainViewContainer = class("V1a4_BossRushMainViewContainer", BaseViewContainer)

function V1a4_BossRushMainViewContainer:buildViews()
	local helpShowView = HelpShowView.New()

	helpShowView:setHelpId(HelpEnum.HelpId.BossRushViewHelp)
	helpShowView:setDelayTime(0.5)

	local activityMainView = BossRushModel.instance:getActivityMainView()
	local mainViewClass = activityMainView and activityMainView.MainViewClass or V1a4_BossRushMainView
	local mainView = mainViewClass.New()
	local views = {
		mainView,
		TabViewGroup.New(1, "top_left"),
		helpShowView
	}

	return views
end

function V1a4_BossRushMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.BossRushViewHelp, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonView
		}
	end
end

function V1a4_BossRushMainViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.BossRush)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.BossRush
	})
end

return V1a4_BossRushMainViewContainer
