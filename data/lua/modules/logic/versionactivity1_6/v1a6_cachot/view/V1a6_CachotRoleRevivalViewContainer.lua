module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRevivalViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotRoleRevivalView.New(),
		LuaListScrollView.New(V1a6_CachotRoleRevivalPrepareListModel.instance, arg_1_0:_getPrepareListParam())
	}
end

function var_0_0._getPrepareListParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#go_tipswindow/scroll_view"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[2]
	var_2_0.cellClass = V1a6_CachotRoleRevivalPrepareItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirH
	var_2_0.lineCount = 4
	var_2_0.cellWidth = 624
	var_2_0.cellHeight = 192
	var_2_0.cellSpaceH = 0
	var_2_0.cellSpaceV = 0
	var_2_0.startSpace = 0
	var_2_0.endSpace = 0
	var_2_0.minUpdateCountInFrame = 100

	return var_2_0
end

return var_0_0
