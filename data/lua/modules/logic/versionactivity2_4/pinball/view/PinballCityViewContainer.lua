module("modules.logic.versionactivity2_4.pinball.view.PinballCityViewContainer", package.seeall)

local var_0_0 = class("PinballCityViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._mapViewScene = PinballCitySceneView.New()

	return {
		arg_1_0._mapViewScene,
		PinballCityView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			var_2_0
		}
	end
end

function var_0_0.setVisibleInternal(arg_3_0, arg_3_1)
	if arg_3_0._mapViewScene then
		arg_3_0._mapViewScene:setSceneVisible(arg_3_1)
	end

	var_0_0.super.setVisibleInternal(arg_3_0, arg_3_1)
end

return var_0_0
