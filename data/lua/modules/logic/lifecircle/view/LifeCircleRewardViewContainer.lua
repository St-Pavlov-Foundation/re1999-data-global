module("modules.logic.lifecircle.view.LifeCircleRewardViewContainer", package.seeall)

local var_0_0 = class("LifeCircleRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_Reward/#scroll_Reward"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = CommonPropListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 5
	var_1_0.cellWidth = 270
	var_1_0.cellHeight = 250
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 30
	var_1_0.startSpace = 0
	var_1_0.endSpace = 56

	return {
		LuaListScrollView.New(CommonPropListModel.instance, var_1_0),
		LifeCircleRewardView.New()
	}
end

return var_0_0
