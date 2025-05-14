module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnlockedViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionUnlockedViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._scrollParam = ListScrollParam.New()
	arg_1_0._scrollParam.scrollGOPath = "#go_info/#scroll_view"
	arg_1_0._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	arg_1_0._scrollParam.prefabUrl = "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem"
	arg_1_0._scrollParam.cellClass = V1a6_CachotCollectionUnLockItem
	arg_1_0._scrollParam.scrollDir = ScrollEnum.ScrollDirV
	arg_1_0._scrollParam.lineCount = 5
	arg_1_0._scrollParam.cellWidth = 280
	arg_1_0._scrollParam.cellHeight = 260
	arg_1_0._scrollParam.cellSpaceH = 0
	arg_1_0._scrollParam.cellSpaceV = 0
	arg_1_0._scrollParam.startSpace = 50
	arg_1_0._scrollParam.endSpace = 0

	return {
		V1a6_CachotCollectionUnlockedView.New(),
		LuaListScrollView.New(V1a6_CachotCollectionUnLockListModel.instance, arg_1_0._scrollParam)
	}
end

function var_0_0.getListScrollParam(arg_2_0)
	return arg_2_0._scrollParam
end

return var_0_0
