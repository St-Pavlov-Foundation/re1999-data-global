module("modules.logic.bossrush.view.V1a4_BossRushMainViewContainer", package.seeall)

local var_0_0 = class("V1a4_BossRushMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = HelpShowView.New()

	var_1_0:setHelpId(HelpEnum.HelpId.BossRushViewHelp)
	var_1_0:setDelayTime(0.5)

	local var_1_1 = BossRushModel.instance:getActivityMainView()
	local var_1_2 = (var_1_1 and var_1_1.MainViewClass or V1a4_BossRushMainView).New()

	return {
		var_1_2,
		TabViewGroup.New(1, "top_left"),
		var_1_0
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.BossRushViewHelp, arg_2_0._closeCallback, nil, nil, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.BossRush)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.BossRush
	})
end

return var_0_0
