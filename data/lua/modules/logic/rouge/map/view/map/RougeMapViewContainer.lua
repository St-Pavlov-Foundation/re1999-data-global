module("modules.logic.rouge.map.view.map.RougeMapViewContainer", package.seeall)

local var_0_0 = class("RougeMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeMapView.New())
	table.insert(var_1_0, RougeMapDragView.New())
	table.insert(var_1_0, RougeMapInputView.New())
	table.insert(var_1_0, RougeMapCoinView.New())
	table.insert(var_1_0, RougeMapNodeRightView.New())
	table.insert(var_1_0, RougeMapLayerRightView.New())
	table.insert(var_1_0, RougeMapLayerLineView.New())
	table.insert(var_1_0, RougeMapEntrustView.New())
	table.insert(var_1_0, RougeMapEliteFightView.New())
	table.insert(var_1_0, RougeMapVoiceView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_LeftTop"))
	table.insert(var_1_0, RougeBaseDLCViewComp.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	arg_2_0.navigateView:setHelpId(HelpEnum.HelpId.RougeMapViewHelp)
	arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

	return {
		arg_2_0.navigateView
	}
end

function var_0_0._overrideClose(arg_3_0)
	RougeMapHelper.backToMainScene()
	RougeStatController.instance:statEnd(RougeStatController.EndResult.Close)
end

return var_0_0
