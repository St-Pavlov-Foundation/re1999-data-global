module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentViewContainer", package.seeall)

local var_0_0 = class("V2a5_GoldenMilletPresentViewContainer", BaseViewContainer)

var_0_0.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function var_0_0.buildViews(arg_1_0)
	arg_1_0.goldenMilletPresentView = V2a5_GoldenMilletPresentView.New()

	return {
		arg_1_0.goldenMilletPresentView
	}
end

function var_0_0.openGoldMilletPresentDisplayView(arg_2_0)
	arg_2_0.goldenMilletPresentView:switchExclusiveView(true)
end

return var_0_0
