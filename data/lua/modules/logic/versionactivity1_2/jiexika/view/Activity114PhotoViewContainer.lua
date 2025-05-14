module("modules.logic.versionactivity1_2.jiexika.view.Activity114PhotoViewContainer", package.seeall)

local var_0_0 = class("Activity114PhotoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Activity114PhotoView.New("#go_photos", true),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		var_2_0
	}
end

return var_0_0
