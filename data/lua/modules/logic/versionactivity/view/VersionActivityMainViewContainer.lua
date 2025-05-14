module("modules.logic.versionactivity.view.VersionActivityMainViewContainer", package.seeall)

local var_0_0 = class("VersionActivityMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivityMainView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	arg_2_0.navigateView:setOverrideClose(arg_2_0.overClose, arg_2_0)

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.overClose(arg_3_0)
	arg_3_0:closeThis()
	ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapView)
end

return var_0_0
