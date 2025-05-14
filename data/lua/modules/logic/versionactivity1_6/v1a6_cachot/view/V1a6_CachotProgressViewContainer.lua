module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotProgressViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._scrollParam = arg_1_0:getMixContentParam()
	arg_1_0._scrollView = LuaMixScrollView.New(V1a6_CachotProgressListModel.instance, arg_1_0._scrollParam)

	return {
		V1a6_CachotProgressView.New(),
		arg_1_0._scrollView
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

function var_0_0.getMixContentParam(arg_3_0)
	local var_3_0 = MixScrollParam.New()

	var_3_0.scrollGOPath = "Left/#go_progress/#scroll_view"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = V1a6_CachotProgressItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirH
	var_3_0.startSpace = 2.5
	var_3_0.endSpace = 50

	return var_3_0
end

return var_0_0
