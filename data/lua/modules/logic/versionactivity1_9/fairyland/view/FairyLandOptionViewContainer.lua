module("modules.logic.versionactivity1_9.fairyland.view.FairyLandOptionViewContainer", package.seeall)

local var_0_0 = class("FairyLandOptionViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, FairyLandOptionView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_LeftTop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.overrideCloseFunc(arg_3_0)
	arg_3_0:closeThis()
	ViewMgr.instance:closeView(ViewName.FairyLandView)
end

return var_0_0
