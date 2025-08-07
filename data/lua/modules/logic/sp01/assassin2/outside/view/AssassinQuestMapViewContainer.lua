module("modules.logic.sp01.assassin2.outside.view.AssassinQuestMapViewContainer", package.seeall)

local var_0_0 = class("AssassinQuestMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

	arg_1_0.assassinMapView = AssassinQuestMapView.New()

	table.insert(var_1_0, arg_1_0.assassinMapView)

	if isDebugBuild then
		table.insert(var_1_0, AssassinQuestMapEditView.New())
	end

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
