module("modules.logic.settings.rpc.UserSettingRpc", package.seeall)

slot0 = class("UserSettingRpc", BaseRpc)

function slot0.sendGetSettingInfosRequest(slot0, slot1, slot2)
	return slot0:sendMsg(UserSettingModule_pb.GetSettingInfosRequest(), slot1, slot2)
end

function slot0.onReceiveGetSettingInfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SettingsModel.instance:setPushState(slot2.infos)
end

function slot0.sendUpdateSettingInfoRequest(slot0, slot1, slot2)
	slot3 = UserSettingModule_pb.UpdateSettingInfoRequest()
	slot3.type = slot1
	slot3.param = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveUpdateSettingInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SettingsModel.instance:updatePushState(slot2.type, slot2.param)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnChangePushType)
end

slot0.instance = slot0.New()

return slot0
