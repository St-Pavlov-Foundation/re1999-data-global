module("modules.logic.versionactivity1_5.aizila.view.AiZiLaMapViewContainer", package.seeall)

local var_0_0 = class("AiZiLaMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mapView = AiZiLaMapView.New()

	table.insert(var_1_0, arg_1_0._mapView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_3_0._navigateButtonsView:setOverrideClose(arg_3_0._overrideCloseFunc, arg_3_0)

		return {
			arg_3_0._navigateButtonsView
		}
	end
end

var_0_0.UI_COLSE_BLOCK_KEY = "AiZiLaMapViewContainer_COLSE_BLOCK_KEY"

function var_0_0._overrideCloseFunc(arg_4_0)
	AiZiLaHelper.startBlock(var_0_0.UI_COLSE_BLOCK_KEY)
	arg_4_0._mapView:playViewAnimator(UIAnimationName.Close)
	TaskDispatcher.runDelay(arg_4_0._onDelayCloseView, arg_4_0, AiZiLaEnum.AnimatorTime.MapViewClose)
end

function var_0_0._onDelayCloseView(arg_5_0)
	AiZiLaHelper.endBlock(var_0_0.UI_COLSE_BLOCK_KEY)
	arg_5_0:closeThis()
end

function var_0_0.onContainerInit(arg_6_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.AiZiLa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.AiZiLa
	})
end

return var_0_0
