module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionBagViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionBagViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = arg_1_0:getScrollParam()

	arg_1_0._scrollView = LuaListScrollView.New(V1a6_CachotCollectionBagListModel.instance, var_1_0)

	return {
		V1a6_CachotCollectionBagView.New(),
		arg_1_0._scrollView
	}
end

function var_0_0.getScrollView(arg_2_0)
	return arg_2_0._scrollView
end

function var_0_0.getScrollParam(arg_3_0)
	if not arg_3_0._scrollParam then
		arg_3_0._scrollParam = ListScrollParam.New()
		arg_3_0._scrollParam.scrollGOPath = "left/#scroll_view"
		arg_3_0._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		arg_3_0._scrollParam.prefabUrl = arg_3_0._viewSetting.otherRes[1]
		arg_3_0._scrollParam.cellClass = V1a6_CachotCollectionBagItem
		arg_3_0._scrollParam.scrollDir = ScrollEnum.ScrollDirV
		arg_3_0._scrollParam.lineCount = 4
		arg_3_0._scrollParam.cellWidth = 248
		arg_3_0._scrollParam.cellHeight = 256
		arg_3_0._scrollParam.cellSpaceH = 0
		arg_3_0._scrollParam.cellSpaceV = 0
		arg_3_0._scrollParam.startSpace = 0
		arg_3_0._scrollParam.endSpace = 0
	end

	return arg_3_0._scrollParam
end

return var_0_0
