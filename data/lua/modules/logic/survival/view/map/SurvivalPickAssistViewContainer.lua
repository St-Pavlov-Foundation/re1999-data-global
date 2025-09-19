module("modules.logic.survival.view.map.SurvivalPickAssistViewContainer", package.seeall)

local var_0_0 = class("SurvivalPickAssistViewContainer", PickAssistViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.viewOpenAnimTime = 0.4
	arg_1_0.scrollView = arg_1_0:instantiateListScrollView()

	return {
		SurvivalPickAssistView.New(),
		arg_1_0.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

return var_0_0
