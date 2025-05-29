module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerViewContainer", package.seeall)

local var_0_0 = class("WeekWalk_2HeartLayerViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, WeekWalk_2HeartLayerView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	arg_1_0.helpView = HelpShowView.New()

	arg_1_0.helpView:setHelpId(HelpEnum.HelpId.WeekWalk_2HeartLayerOnce)
	table.insert(var_1_0, arg_1_0.helpView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.WeekWalk_2HeartLayer)

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
