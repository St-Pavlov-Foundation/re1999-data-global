module("modules.logic.versionactivity1_3.armpipe.view.ArmMainViewContainer", package.seeall)

local var_0_0 = class("ArmMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ArmMainView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
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

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act305)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act305
	})
end

return var_0_0
