module("modules.logic.versionactivity1_5.act142.view.Activity142MapViewContainer", package.seeall)

local var_0_0 = class("Activity142MapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mapView = Activity142MapView.New()
	var_1_0[#var_1_0 + 1] = arg_1_0._mapView
	var_1_0[#var_1_0 + 1] = TabViewGroup.New(1, "#go_BackBtns")

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		var_2_0:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	arg_3_0._mapView:playViewAnimation(UIAnimationName.Close)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.CloseMapView)
	TaskDispatcher.runDelay(arg_3_0._onDelayCloseView, arg_3_0, Activity142Enum.CLOSE_MAP_VIEW_TIME)
end

function var_0_0._onDelayCloseView(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onContainerInit(arg_5_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.Activity142)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.Activity142
	})
end

function var_0_0._setVisible(arg_6_0, arg_6_1)
	BaseViewContainer._setVisible(arg_6_0, arg_6_1)

	if not arg_6_0._mapView then
		return
	end

	arg_6_0._mapView:onSetVisible(arg_6_1)

	if arg_6_1 then
		arg_6_0._mapView:playViewAnimation(UIAnimationName.Open)
	end
end

return var_0_0
