module("modules.logic.survival.view.shelter.SurvivalDecreeSelectViewContainer", package.seeall)

local var_0_0 = class("SurvivalDecreeSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SurvivalDecreeSelectView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			var_2_0
		}
	end
end

return var_0_0
