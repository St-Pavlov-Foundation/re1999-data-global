module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainViewContainer", package.seeall)

local var_0_0 = class("ActivityTradeBargainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityTradeBargainView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_content"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.VersionActivity_1_2_Trade)

		arg_2_0._navigateButtonView:setCloseCheck(arg_2_0._closeCheckFunc, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == 2 then
		return {
			ActivityTradeBargainQuoteView.New(),
			ActivityTradeBargainRewardView.New()
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.Trade)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.Trade
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function var_0_0.setActId(arg_4_0, arg_4_1)
	arg_4_0.actId = arg_4_1
end

function var_0_0.getActId(arg_5_0)
	return arg_5_0.actId
end

return var_0_0
