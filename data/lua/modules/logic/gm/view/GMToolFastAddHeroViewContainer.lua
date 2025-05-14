module("modules.logic.gm.view.GMToolFastAddHeroViewContainer", package.seeall)

local var_0_0 = class("GMToolFastAddHeroViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "container/#go_addItem/scroll"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "container/#go_addItem/scroll/#go_item"
	var_1_0.cellClass = GMFastAddHeroAddItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 794
	var_1_0.cellHeight = 100
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "container/#go_herolistcontainer/scroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem"
	var_1_1.cellClass = GMFastAddHeroHadHeroItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1500
	var_1_1.cellHeight = 80
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 10

	return {
		LuaListScrollView.New(GMAddItemModel.instance, var_1_0),
		LuaListScrollView.New(GMFastAddHeroHadHeroItemModel.instance, var_1_1),
		GMToolFastAddHeroView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

return var_0_0
