module("modules.logic.store.view.StoreSkinPreviewViewContainer", package.seeall)

local var_0_0 = class("StoreSkinPreviewViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, StoreSkinPreviewRightView.New())
	table.insert(var_1_0, CharacterSkinLeftView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(var_1_0, StoreSkinPreviewSpineGCView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.goodsMO = arg_2_0.viewParam.goodsMO

	local var_2_0 = arg_2_0.goodsMO.config.product
	local var_2_1 = string.splitToNumber(var_2_0, "#")[2]

	if HandbookConfig.instance:getSkinSuitIdBySkinId(var_2_1) ~= nil then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})
	else
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})
	end

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.onPlayOpenTransitionFinish(arg_3_0)
	var_0_0.super.onPlayOpenTransitionFinish(arg_3_0)

	arg_3_0.viewGO:GetComponent(typeof(UnityEngine.Animator)).enabled = true
end

return var_0_0
