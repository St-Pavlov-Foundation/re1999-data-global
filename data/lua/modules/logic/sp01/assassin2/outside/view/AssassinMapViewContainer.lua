module("modules.logic.sp01.assassin2.outside.view.AssassinMapViewContainer", package.seeall)

local var_0_0 = class("AssassinMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(var_1_0, AssassinMapView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return var_0_0
