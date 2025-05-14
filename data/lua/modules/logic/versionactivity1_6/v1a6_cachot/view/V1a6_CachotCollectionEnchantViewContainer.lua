module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionEnchantViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "left/#scroll_view"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "left/#scroll_view/Viewport/Content/#go_collectionbagitem"
	var_1_0.cellClass = V1a6_CachotEnchantBagItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 2
	var_1_0.cellWidth = 238
	var_1_0.cellHeight = 245
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = -8.3
	var_1_0.startSpace = 0
	var_1_0.endSpace = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "right/#scroll_view"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "right/#scroll_view/Viewport/Content/#go_collectionenchantitem"
	var_1_1.cellClass = V1a6_CachotCollectionEnchantItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 615
	var_1_1.cellHeight = 235
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0.35
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0
	arg_1_0._collectionScrollView = LuaListScrollView.New(V1a6_CachotEnchantBagListModel.instance, var_1_0)
	arg_1_0._enchantScrollView = LuaListScrollView.New(V1a6_CachotCollectionEnchantListModel.instance, var_1_1)
	arg_1_0._collectionScrollView.onUpdateFinish = arg_1_0.scrollFocusOnSelectCell

	return {
		V1a6_CachotCollectionEnchantView.New(),
		arg_1_0._collectionScrollView,
		arg_1_0._enchantScrollView
	}
end

function var_0_0.scrollFocusOnSelectCell(arg_2_0)
	local var_2_0 = arg_2_0:getFirstSelect()

	if not var_2_0 then
		return
	end

	local var_2_1 = arg_2_0._model:getIndex(var_2_0)
	local var_2_2 = math.ceil(var_2_1 / arg_2_0._param.lineCount) - 1
	local var_2_3 = arg_2_0._param.cellHeight + arg_2_0._param.cellSpaceV
	local var_2_4 = var_2_2 * var_2_3 + arg_2_0._param.startSpace
	local var_2_5 = arg_2_0._csListScroll.VerticalScrollPixel
	local var_2_6 = var_2_4 + var_2_3 - var_2_5

	if var_2_6 > recthelper.getHeight(arg_2_0._csListScroll.transform) or var_2_6 < var_2_3 then
		arg_2_0._csListScroll.VerticalScrollPixel = var_2_4
	end
end

return var_0_0
