module("modules.logic.turnback.view.TurnbackSignInViewContainer", package.seeall)

local var_0_0 = class("TurnbackSignInViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_daylist"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = TurnbackSignInItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 600
	var_1_0.cellSpaceH = 5
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0
	var_1_0.frameUpdateMs = 100
	arg_1_0._scrollView = LuaListScrollView.New(TurnbackSignInModel.instance, var_1_0)
	arg_1_0._scrollParam = var_1_0

	return {
		arg_1_0._scrollView,
		TurnbackSignInView.New()
	}
end

return var_0_0
