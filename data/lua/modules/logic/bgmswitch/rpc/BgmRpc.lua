module("modules.logic.bgmswitch.rpc.BgmRpc", package.seeall)

slot0 = class("BgmRpc", BaseRpc)

function slot0.sendGetBgmInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(BgmModule_pb.GetBgmInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetBgmInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		BGMSwitchModel.instance:setBgmInfos(slot2.bgmInfos)
		BGMSwitchModel.instance:setUsedBgmIdFromServer(slot2.useBgmId)
		BGMSwitchModel.instance:setCurBgm(slot2.useBgmId)
	end
end

function slot0.onReceiveUpdateBgmPush(slot0, slot1, slot2)
	if slot1 == 0 then
		BGMSwitchModel.instance:updateBgmInfos(slot2.bgmInfos)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmUpdated)
	end
end

function slot0.sendSetUseBgmRequest(slot0, slot1, slot2, slot3)
	slot4 = BgmModule_pb.SetUseBgmRequest()
	slot4.bgmId = slot1

	BGMSwitchModel.instance:recordInfoByType(BGMSwitchEnum.RecordInfoType.ListType, BGMSwitchModel.instance:getBGMSelectType(), true)
	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetUseBgmReply(slot0, slot1, slot2)
	if slot1 == 0 then
		BGMSwitchModel.instance:setUsedBgmIdFromServer(slot2.bgmId)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmSwitched)
	end
end

function slot0.sendSetFavoriteBgmRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = BgmModule_pb.SetFavoriteBgmRequest()
	slot5.bgmId = slot1
	slot5.favorite = slot2

	if BGMSwitchConfig.instance:getBGMSwitchCO(slot1) then
		StatController.instance:track(StatEnum.EventName.SetPreferenceBgm, {
			[StatEnum.EventProperties.AudioId] = tostring(slot1),
			[StatEnum.EventProperties.AudioName] = slot6.audioName,
			[StatEnum.EventProperties.OperationType] = slot2 and "setLove" or "setUnlove",
			[StatEnum.EventProperties.FavoriteAudio] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted())
		})
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSetFavoriteBgmReply(slot0, slot1, slot2)
	if slot1 == 0 then
		BGMSwitchModel.instance:setBgmFavorite(slot2.bgmId, slot2.favorite)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmFavorite, slot2.bgmId)
	end
end

function slot0.sendReadBgmRequest(slot0, slot1)
	slot2 = BgmModule_pb.ReadBgmRequest()
	slot2.bgmId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveReadBgmReply(slot0, slot1, slot2)
	if slot1 == 0 then
		BGMSwitchModel.instance:markRead(slot2.bgmId)
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmMarkRead, slot2.bgmId)
	end
end

slot0.instance = slot0.New()

return slot0
