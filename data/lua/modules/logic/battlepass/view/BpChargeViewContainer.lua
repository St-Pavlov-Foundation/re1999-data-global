module("modules.logic.battlepass.view.BpChargeViewContainer", package.seeall)

local var_0_0 = class("BpChargeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, BpChargeView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigationView
		}
	end
end

function var_0_0.playOpenTransition(arg_3_0)
	local var_3_0 = "open"

	if arg_3_0.viewParam and arg_3_0.viewParam.first then
		var_3_0 = "first"
	end

	var_0_0.super.playOpenTransition(arg_3_0, {
		duration = 3,
		anim = var_3_0
	})
end

return var_0_0
