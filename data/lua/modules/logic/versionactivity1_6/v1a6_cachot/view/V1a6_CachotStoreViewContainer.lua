module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotStoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_store"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#scroll_store/Viewport/#go_storeItem/#go_storegoodsitem"
	var_1_0.cellClass = V1a6_CachotStoreItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 356
	var_1_0.cellHeight = 376
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 10
	var_1_0.startSpace = 30
	var_1_0.frameUpdateMs = 100

	return {
		V1a6_CachotStoreView.New(),
		LuaListScrollView.New(V1a6_CachotStoreListModel.instance, var_1_0),
		V1a6_CachotCurrencyView.New("top")
	}
end

return var_0_0
