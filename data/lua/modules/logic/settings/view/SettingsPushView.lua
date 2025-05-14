module("modules.logic.settings.view.SettingsPushView", package.seeall)

local var_0_0 = class("SettingsPushView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnreactivation = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn")
	arg_1_0._goreactivationon = gohelper.findChild(arg_1_0.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn/on")
	arg_1_0._goreactivationoff = gohelper.findChild(arg_1_0.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn/off")
	arg_1_0._btnroomproduceupperlimit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn")
	arg_1_0._goroomproduceupperlimiton = gohelper.findChild(arg_1_0.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn/on")
	arg_1_0._goroomproduceupperlimitoff = gohelper.findChild(arg_1_0.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn/off")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreactivation:AddClickListener(arg_2_0._btnreactivationOnClick, arg_2_0)
	arg_2_0._btnroomproduceupperlimit:AddClickListener(arg_2_0._btnroomproduceupperlimitOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreactivation:RemoveClickListener()
	arg_3_0._btnroomproduceupperlimit:RemoveClickListener()
end

function var_0_0._btnreactivationOnClick(arg_4_0)
	if not SDKMgr.instance:isNotificationEnable() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SDKUnlockMessagePush, MsgBoxEnum.BoxType.Yes_No, function()
			SDKMgr.instance:openNotificationSettings()
		end)

		return
	end

	local var_4_0 = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Reactivation) and "0" or "1"

	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Reactivation, var_4_0)
end

function var_0_0._btnroomproduceupperlimitOnClick(arg_6_0)
	if not SDKMgr.instance:isNotificationEnable() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SDKUnlockMessagePush, MsgBoxEnum.BoxType.Yes_No, function()
			SDKMgr.instance:openNotificationSettings()
		end)

		return
	end

	local var_6_0 = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Room_Produce_Upper_Limit) and "0" or "1"

	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Room_Produce_Upper_Limit, var_6_0)
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_refreshUI()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addCustomEvents()
	arg_10_0:_refreshUI()
end

function var_0_0.addCustomEvents(arg_11_0)
	arg_11_0:addEventCb(SettingsController.instance, SettingsEvent.OnChangePushType, arg_11_0._refreshUI, arg_11_0)
	arg_11_0:addEventCb(GameStateMgr.instance, GameStateEvent.onApplicationPause, arg_11_0._refreshUI, arg_11_0)
end

function var_0_0._refreshUI(arg_12_0)
	arg_12_0:_refreshReactivationUI()
	arg_12_0:_refreshRoomProduceUpperLimitUI()
end

function var_0_0._refreshReactivationUI(arg_13_0)
	local var_13_0 = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Reactivation)

	gohelper.setActive(arg_13_0._goreactivationon, var_13_0)
	gohelper.setActive(arg_13_0._goreactivationoff, not var_13_0)
end

function var_0_0._refreshRoomProduceUpperLimitUI(arg_14_0)
	local var_14_0 = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Room_Produce_Upper_Limit)

	gohelper.setActive(arg_14_0._goroomproduceupperlimiton, var_14_0)
	gohelper.setActive(arg_14_0._goroomproduceupperlimitoff, not var_14_0)
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:removeCustomEvents()
end

function var_0_0.removeCustomEvents(arg_16_0)
	arg_16_0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangePushType, arg_16_0._refreshUI, arg_16_0)
	arg_16_0:removeEventCb(GameStateMgr.instance, GameStateEvent.onApplicationPause, arg_16_0._refreshUI, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
