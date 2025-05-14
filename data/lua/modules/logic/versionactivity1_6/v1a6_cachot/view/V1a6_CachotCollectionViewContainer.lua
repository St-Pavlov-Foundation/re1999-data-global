module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = MixScrollParam.New()

	var_1_0.scrollGOPath = "left/#scroll_view"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "left/#scroll_view/Viewport/Content/#go_collectionitem"
	var_1_0.cellClass = V1a6_CachotCollectionLineItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.startSpace = 0
	var_1_0.endSpace = 0

	return {
		V1a6_CachotCollectionView.New(),
		LuaMixScrollView.New(V1a6_CachotCollectionListModel.instance, var_1_0)
	}
end

return var_0_0
