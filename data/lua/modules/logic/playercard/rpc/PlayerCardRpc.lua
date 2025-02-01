module("modules.logic.playercard.rpc.PlayerCardRpc", package.seeall)

slot0 = class("PlayerCardRpc", BaseRpc)

function slot0.sendGetPlayerCardInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(PlayerCardModule_pb.GetPlayerCardInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetPlayerCardInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(slot2.playerCardInfo)
end

function slot0.onReceivePlayerCardInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(slot2.playerCardInfo)
end

function slot0.sendGetOtherPlayerCardInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerCardModule_pb.GetOtherPlayerCardInfoRequest()
	slot4.userId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetOtherPlayerCardInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateCardInfo(slot2.playerCardInfo, slot2.playerInfo)
end

function slot0.sendSetPlayerCardShowSettingRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerCardModule_pb.SetPlayerCardShowSettingRequest()

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4.showSettings, slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetPlayerCardShowSettingReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateSetting(slot2.showSettings)
end

function slot0.sendSetPlayerCardHeroCoverRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerCardModule_pb.SetPlayerCardHeroCoverRequest()
	slot4.heroCover = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetPlayerCardHeroCoverReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateHeroCover(slot2.heroCover)
end

function slot0.sendSetPlayerCardThemeRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerCardModule_pb.SetPlayerCardThemeRequest()
	slot4.themeId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetPlayerCardThemeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateThemeId(slot2.themeId)
end

slot0.instance = slot0.New()

return slot0
