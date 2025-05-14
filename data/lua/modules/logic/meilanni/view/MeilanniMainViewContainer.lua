module("modules.logic.meilanni.view.MeilanniMainViewContainer", package.seeall)

local var_0_0 = class("MeilanniMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MeilanniMainView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.VersionActivityMeiLanNi, arg_2_0._closeCallback)

	return {
		arg_2_0._navigateButtonView
	}
end

function var_0_0._closeCallback(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function var_0_0.onContainerClose(arg_4_0)
	return
end

function var_0_0.onContainerOpen(arg_5_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act108)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act108
	})
end

return var_0_0
