module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentViewContainer", package.seeall)

local var_0_0 = class("GoldenMilletPresentViewContainer", BaseViewContainer)

var_0_0.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function var_0_0.buildViews(arg_1_0)
	arg_1_0.goldenMilletPresentView = GoldenMilletPresentView.New()

	return {
		arg_1_0.goldenMilletPresentView
	}
end

function var_0_0.openGoldMilletPresentDisplayView(arg_2_0)
	arg_2_0.goldenMilletPresentView:switchExclusiveView(true)
end

return var_0_0
