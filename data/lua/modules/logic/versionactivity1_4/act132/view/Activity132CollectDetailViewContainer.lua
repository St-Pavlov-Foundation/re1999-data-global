module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailViewContainer", package.seeall)

local var_0_0 = class("Activity132CollectDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Activity132CollectDetailView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function var_0_0.onContainerClose(arg_3_0)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem)
end

return var_0_0
