module("modules.logic.sp01.act205.view.ocean.Act205OceanSelectViewContainer", package.seeall)

local var_0_0 = class("Act205OceanSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Act205OceanSelectView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.setOverrideCloseClick(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.navigateView:setOverrideClose(arg_3_1, arg_3_2)
end

return var_0_0
