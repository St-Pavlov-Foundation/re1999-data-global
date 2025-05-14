module("modules.logic.rouge.dlc.101.view.RougeLimiterOverViewContainer", package.seeall)

local var_0_0 = class("RougeLimiterOverViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeLimiterOverView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_container"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			RougeLimiterDebuffOverView.New(),
			RougeLimiterBuffOverView.New()
		}
	end
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_3_1)
end

return var_0_0
