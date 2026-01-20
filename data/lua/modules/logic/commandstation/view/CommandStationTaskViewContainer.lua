-- chunkname: @modules/logic/commandstation/view/CommandStationTaskViewContainer.lua

module("modules.logic.commandstation.view.CommandStationTaskViewContainer", package.seeall)

local CommandStationTaskViewContainer = class("CommandStationTaskViewContainer", BaseViewContainer)

function CommandStationTaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Right/#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = CommandStationTaskItem.prefabPath
	scrollParam.cellClass = CommandStationTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local scrollParam2 = ListScrollParam.New()

	scrollParam2.scrollGOPath = "Right/Progress/#scroll_view"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "Right/Progress/#scroll_view/Viewport/Content/#go_rewarditem"
	scrollParam2.cellClass = CommandStationBonusItem
	scrollParam2.scrollDir = ScrollEnum.ScrollDirH

	local animationDelayTimes = {}

	for i = 1, 30 do
		local delayTime = (i - 1) * 0.06

		animationDelayTimes[i] = delayTime
	end

	return {
		LuaListScrollViewWithAnimator.New(CommandStationTaskListModel.instance, scrollParam, animationDelayTimes),
		LuaMixScrollView.New(CommandStationBonusListModel.instance, scrollParam2),
		CommandStationTaskView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function CommandStationTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.CommandStationTask)

		return {
			self.navigateView
		}
	end
end

return CommandStationTaskViewContainer
