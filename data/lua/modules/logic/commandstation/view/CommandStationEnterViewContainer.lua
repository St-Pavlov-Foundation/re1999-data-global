module("modules.logic.commandstation.view.CommandStationEnterViewContainer", package.seeall)

local var_0_0 = class("CommandStationEnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommandStationEnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.playOpenTransition(arg_2_0)
	local var_2_0

	if arg_2_0.viewParam and arg_2_0.viewParam.fromDungeonSectionItem then
		var_2_0 = {
			anim = "open2"
		}
	end

	var_0_0.super.playOpenTransition(arg_2_0, var_2_0)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.CommandStationEnter)

		return {
			arg_3_0.navigateView
		}
	end
end

return var_0_0
