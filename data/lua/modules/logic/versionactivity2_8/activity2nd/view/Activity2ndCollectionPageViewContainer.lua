module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndCollectionPageViewContainer", package.seeall)

local var_0_0 = class("Activity2ndCollectionPageViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._view = Activity2ndCollectionPageView.New()

	table.insert(var_1_0, arg_1_0._view)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	if Activity2ndModel.instance:getShowTypeMechine() then
		Activity2ndModel.instance:changeShowTypeMechine()
		arg_3_0._view:switchTyepMechine()
	else
		arg_3_0:closeThis()
	end
end

return var_0_0
