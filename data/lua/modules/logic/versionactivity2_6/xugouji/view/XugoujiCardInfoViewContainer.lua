module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardInfoViewContainer", package.seeall)

local var_0_0 = class("XugoujiCardInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		XugoujiCardInfoView.New()
	}
end

function var_0_0._overrideClickHome(arg_2_0)
	NavigateButtonsView.homeClick()
end

function var_0_0.setVisibleInternal(arg_3_0, arg_3_1)
	var_0_0.super.setVisibleInternal(arg_3_0, arg_3_1)
end

return var_0_0
