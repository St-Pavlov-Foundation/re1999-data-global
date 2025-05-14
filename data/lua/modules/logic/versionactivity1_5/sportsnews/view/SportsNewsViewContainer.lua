module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsViewContainer", package.seeall)

local var_0_0 = class("SportsNewsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SportsNewsView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		arg_2_0._navigateButtonView
	}
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.SportsNews)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.SportsNews
	})
end

return var_0_0
