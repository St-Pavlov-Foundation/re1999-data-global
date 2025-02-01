module("modules.logic.settings.view.SettingsPushView", package.seeall)

slot0 = class("SettingsPushView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnreactivation = gohelper.findChildButtonWithAudio(slot0.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn")
	slot0._goreactivationon = gohelper.findChild(slot0.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn/on")
	slot0._goreactivationoff = gohelper.findChild(slot0.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn/off")
	slot0._btnroomproduceupperlimit = gohelper.findChildButtonWithAudio(slot0.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn")
	slot0._goroomproduceupperlimiton = gohelper.findChild(slot0.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn/on")
	slot0._goroomproduceupperlimitoff = gohelper.findChild(slot0.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn/off")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreactivation:AddClickListener(slot0._btnreactivationOnClick, slot0)
	slot0._btnroomproduceupperlimit:AddClickListener(slot0._btnroomproduceupperlimitOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreactivation:RemoveClickListener()
	slot0._btnroomproduceupperlimit:RemoveClickListener()
end

function slot0._btnreactivationOnClick(slot0)
	if not SDKMgr.instance:isNotificationEnable() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SDKUnlockMessagePush, MsgBoxEnum.BoxType.Yes_No, function ()
			SDKMgr.instance:openNotificationSettings()
		end)

		return
	end

	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Reactivation, SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Reactivation) and "0" or "1")
end

function slot0._btnroomproduceupperlimitOnClick(slot0)
	if not SDKMgr.instance:isNotificationEnable() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SDKUnlockMessagePush, MsgBoxEnum.BoxType.Yes_No, function ()
			SDKMgr.instance:openNotificationSettings()
		end)

		return
	end

	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Room_Produce_Upper_Limit, SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Room_Produce_Upper_Limit) and "0" or "1")
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:addCustomEvents()
	slot0:_refreshUI()
end

function slot0.addCustomEvents(slot0)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnChangePushType, slot0._refreshUI, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.onApplicationPause, slot0._refreshUI, slot0)
end

function slot0._refreshUI(slot0)
	slot0:_refreshReactivationUI()
	slot0:_refreshRoomProduceUpperLimitUI()
end

function slot0._refreshReactivationUI(slot0)
	slot1 = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Reactivation)

	gohelper.setActive(slot0._goreactivationon, slot1)
	gohelper.setActive(slot0._goreactivationoff, not slot1)
end

function slot0._refreshRoomProduceUpperLimitUI(slot0)
	slot1 = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Room_Produce_Upper_Limit)

	gohelper.setActive(slot0._goroomproduceupperlimiton, slot1)
	gohelper.setActive(slot0._goroomproduceupperlimitoff, not slot1)
end

function slot0.onClose(slot0)
	slot0:removeCustomEvents()
end

function slot0.removeCustomEvents(slot0)
	slot0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangePushType, slot0._refreshUI, slot0)
	slot0:removeEventCb(GameStateMgr.instance, GameStateEvent.onApplicationPause, slot0._refreshUI, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
