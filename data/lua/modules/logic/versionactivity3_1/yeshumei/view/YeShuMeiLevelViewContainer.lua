module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiLevelViewContainer", package.seeall)

local var_0_0 = class("YeShuMeiLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, YeShuMeiLevelView.New())
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
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_1Enum.ActivityId.YeShuMei)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_1Enum.ActivityId.YeShuMei
	})
end

return var_0_0
