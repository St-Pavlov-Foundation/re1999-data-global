module("modules.logic.commandstation.view.CommandStationCharacterEventViewContainer", package.seeall)

local var_0_0 = class("CommandStationCharacterEventViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mainView = CommandStationCharacterEventView.New()

	table.insert(var_1_0, arg_1_0._mainView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._navigateClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._navigateClose(arg_3_0)
	arg_3_0._mainView:checkClose()
end

return var_0_0
