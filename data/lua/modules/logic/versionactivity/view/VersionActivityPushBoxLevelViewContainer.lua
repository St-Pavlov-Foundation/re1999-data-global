module("modules.logic.versionactivity.view.VersionActivityPushBoxLevelViewContainer", package.seeall)

local var_0_0 = class("VersionActivityPushBoxLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		VersionActivityPushBoxLevelView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerOpen(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act111)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act111
	})
end

return var_0_0
