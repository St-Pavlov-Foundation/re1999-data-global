module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewContainer", package.seeall)

local var_0_0 = class("LanShouPaMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mapViewScene = LanShouPaMapScene.New()

	table.insert(var_1_0, arg_1_0._mapViewScene)
	table.insert(var_1_0, LanShouPaMapView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

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

function var_0_0.onContainerInit(arg_4_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_1Enum.ActivityId.LanShouPa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_1Enum.ActivityId.LanShouPa
	})
end

function var_0_0.setVisibleInternal(arg_5_0, arg_5_1)
	arg_5_0._mapViewScene:setSceneVisible(arg_5_1)
	var_0_0.super.setVisibleInternal(arg_5_0, arg_5_1)
end

return var_0_0
