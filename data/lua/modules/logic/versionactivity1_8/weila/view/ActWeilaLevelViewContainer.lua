module("modules.logic.versionactivity1_8.weila.view.ActWeilaLevelViewContainer", package.seeall)

local var_0_0 = class("ActWeilaLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActWeilaLevelView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonsView
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_8Enum.ActivityId.Weila)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_8Enum.ActivityId.Weila
	})
end

return var_0_0
