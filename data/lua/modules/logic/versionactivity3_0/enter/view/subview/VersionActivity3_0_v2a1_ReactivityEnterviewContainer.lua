module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0_v2a1_ReactivityEnterviewContainer", package.seeall)

local var_0_0 = class("VersionActivity3_0_v2a1_ReactivityEnterviewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity3_0_v2a1_ReactivityEnterview.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

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

function var_0_0.getIsFirstPlaySubViewAnim(arg_3_0)
	return arg_3_0.isFirstPlaySubViewAnim
end

function var_0_0.markPlayedSubViewAnim(arg_4_0)
	arg_4_0.isFirstPlaySubViewAnim = false
end

return var_0_0
