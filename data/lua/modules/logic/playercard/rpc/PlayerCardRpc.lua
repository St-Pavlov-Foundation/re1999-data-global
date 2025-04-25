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
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ChangeSkin, slot2.themeId)
end

function slot0.sendSetPlayerCardShowAchievementRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = PlayerCardModule_pb.SetPlayerCardShowAchievementRequest()

	for slot9, slot10 in ipairs(slot1) do
		slot5.ids:append(slot10)
	end

	slot5.groupId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSetPlayerCardShowAchievementReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.AchievementSaveSucc)
	PlayerCardController.instance:statSetAchievement()
	AchievementController.instance:dispatchEvent(AchievementEvent.AchievementSaveSucc)
end

function slot0.sendSetPlayerCardProgressSettingRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerCardModule_pb.SetPlayerCardProgressSettingRequest()
	slot4.progressSetting = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetPlayerCardProgressSettingReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateProgressSetting(slot2.progressSetting)
	PlayerCardController.instance:statSetProgress()
end

function slot0.sendSetPlayerCardBaseInfoSettingRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerCardModule_pb.SetPlayerCardBaseSettingRequest()
	slot4.baseSetting = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetPlayerCardBaseSettingReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerCardModel.instance:updateBaseInfoSetting(slot2.baseSetting)
	PlayerCardController.instance:statSetBaseInfo()
end

function slot0.sendSetPlayerCardCritterRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerCardModule_pb.SetPlayerCardCritterRequest()
	slot4.critterUid = tonumber(slot1)

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetPlayerCardCritterReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = CritterModel.instance:getCritterMOByUid(slot2.critterUid)

	PlayerCardModel.instance:setSelectCritterUid(slot2.critterUid)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectCritter, {
		uid = slot2.critterUid
	})
end

slot0.instance = slot0.New()

return slot0
