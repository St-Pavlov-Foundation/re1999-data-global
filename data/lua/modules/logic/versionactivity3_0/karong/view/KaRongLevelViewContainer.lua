module("modules.logic.versionactivity3_0.karong.view.KaRongLevelViewContainer", package.seeall)

local var_0_0 = class("KaRongLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, KaRongLevelView.New())
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
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_0Enum.ActivityId.KaRong)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_0Enum.ActivityId.KaRong
	})
end

return var_0_0
