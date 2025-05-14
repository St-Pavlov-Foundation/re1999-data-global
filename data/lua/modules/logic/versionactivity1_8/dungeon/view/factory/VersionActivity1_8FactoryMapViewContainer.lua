module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_8FactoryMapView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		var_2_0
	}
end

function var_0_0.onContainerInit(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
end

return var_0_0
