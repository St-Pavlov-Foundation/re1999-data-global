module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionOverViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_view"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#scroll_view/Viewport/Content/#go_unlockeditem"
	var_1_0.cellClass = V1a6_CachotCollectionOverItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 3
	var_1_0.cellWidth = 600
	var_1_0.cellHeight = 248
	var_1_0.cellSpaceH = 9
	var_1_0.cellSpaceV = 7
	var_1_0.startSpace = 0
	var_1_0.endSpace = 0
	arg_1_0._scrollView = LuaListScrollView.New(V1a6_CachotCollectionOverListModel.instance, var_1_0)

	return {
		V1a6_CachotCollectionOverView.New(),
		arg_1_0._scrollView
	}
end

function var_0_0.getScrollView(arg_2_0)
	return arg_2_0._scrollView
end

return var_0_0
