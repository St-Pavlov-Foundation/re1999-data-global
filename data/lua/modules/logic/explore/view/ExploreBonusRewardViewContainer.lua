module("modules.logic.explore.view.ExploreBonusRewardViewContainer", package.seeall)

local var_0_0 = class("ExploreBonusRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "mask/#scroll_view"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "mask/#scroll_view/Viewport/Content/rewarditem"
	var_1_0.cellClass = ExploreBonusRewardItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 1470
	var_1_0.cellHeight = 140
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0
	var_1_0.frameUpdateMs = 100

	return {
		ExploreBonusRewardView.New(),
		LuaListScrollView.New(ExploreTaskModel.instance:getTaskList(0), var_1_0)
	}
end

return var_0_0
