module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltViewContainer", package.seeall)

local var_0_0 = class("LoperaSmeltViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LoperaSmeltView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		var_2_0:setCloseCheck(arg_2_0.defaultOverrideCloseCheck, arg_2_0)
		var_2_0:setOverrideHome(arg_2_0._overrideClickHome, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.defaultOverrideCloseCheck(arg_3_0)
	arg_3_0:closeThis()
end

function var_0_0._overrideClickHome(arg_4_0)
	LoperaController.instance:sendStatOnHomeClick()
	NavigateButtonsView.homeClick()
end

function var_0_0.setVisibleInternal(arg_5_0, arg_5_1)
	var_0_0.super.setVisibleInternal(arg_5_0, arg_5_1)
end

return var_0_0
