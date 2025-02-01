module("modules.logic.player.rpc.PlayerRpc", package.seeall)

slot0 = class("PlayerRpc", BaseRpc)

function slot0.sendGetPlayerInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(PlayerModule_pb.GetPlayerInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetPlayerInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = slot2.playerInfo

		PlayerModel.instance:setMainThumbnail(slot2.mainThumbnail)
		PlayerModel.instance:setCanRename(slot2.canRename)
		PlayerModel.instance:setExtraRename(slot2.extRename)
		PlayerModel.instance:setPlayerinfo(slot3)
		CrashSightAgent.SetUserId(slot3.userId)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.PlayerLevel, slot3.level)
		PlayerPrefsHelper.setString(PlayerPrefsKey.PlayerUid, tostring(slot3.userId))
		OpenModel.instance:setOpenInfo(slot2.openinfos)
		OpenController.instance:dispatchEvent(OpenEvent.GetOpenInfoSuccess)
	end
end

function slot0.sendCreatePlayerRequest(slot0, slot1)
	slot2 = PlayerModule_pb.CreatePlayerRequest()
	slot2.name = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveCreatePlayerReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = slot2.playerInfo

		PlayerModel.instance:setPlayerinfo(slot3)
		CrashSightAgent.SetUserId(slot3.userId)
		PlayerPrefsHelper.setString(PlayerPrefsKey.PlayerUid, tostring(slot3.userId))
	end
end

function slot0.sendRenameRequest(slot0, slot1, slot2, slot3)
	PlayerModule_pb.RenameRequest().name = slot1

	if slot2 ~= nil then
		slot4.guideId = slot2
	end

	if slot3 ~= nil then
		slot4.stepId = slot3
	end

	slot0._name = slot1

	slot0:sendMsg(slot4)
end

function slot0.onReceiveRenameReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PlayerModel.instance:setPlayerName(slot0._name)
		PlayerModel.instance:setCanRename(slot2.canRename)
		PlayerModel.instance:setExtraRename(slot2.extRename)
	else
		PlayerController.instance:dispatchEvent(PlayerEvent.RenameReplyFail)
	end
end

function slot0.sendSetSignatureRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerModule_pb.SetSignatureRequest()
	slot4.signature = slot1
	slot0._signature = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetSignatureReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PlayerModel.instance:setPlayerSignature(slot0._signature)
	end
end

function slot0.sendSetBirthdayRequest(slot0, slot1)
	slot2 = PlayerModule_pb.SetBirthdayRequest()
	slot2.birthday = slot1
	slot0._birthday = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveSetBirthdayReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PlayerModel.instance:setPlayerBirthday(slot0._birthday)
	end
end

function slot0.sendSetPortraitRequest(slot0, slot1)
	slot2 = PlayerModule_pb.SetPortraitRequest()
	slot2.portrait = slot1
	slot0._portrait = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveSetPortraitReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PlayerModel.instance:setPlayerPortrait(slot0._portrait)
	end
end

function slot0.onReceivePlayerInfoPush(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:clearSelfPlayerMO()
		DungeonModel.instance:startCheckUnlockChapter()
		PlayerModel.instance:setPlayerinfo(slot2.playerInfo)

		if PlayerModel.instance:getPlayerLevel() ~= PlayerModel.instance:getPlayerLevel() then
			DungeonModel.instance:endCheckUnlockChapter()

			if SDKMediaEventEnum.PlayerLevelUpMediaEvent[PlayerModel.instance:getPlayerLevel()] then
				SDKDataTrackMgr.instance:trackMediaEvent(SDKMediaEventEnum.PlayerLevelUpMediaEvent[slot5])
			end

			SDKChannelEventModel.instance:playerLevelUp(slot5)
		end
	end
end

function slot0.sendSetShowHeroUniqueIdsRequest(slot0, slot1)
	slot2 = PlayerModule_pb.SetShowHeroUniqueIdsRequest()

	for slot6 = 1, #slot1 do
		table.insert(slot2.showHeroUniqueIds, slot1[slot6])
	end

	slot0:sendMsg(slot2)
end

function slot0.onReceiveSetShowHeroUniqueIdsReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PlayerModel.instance:setShowHeroUniqueIds()
	end
end

function slot0.sendGetSimplePropertyRequest(slot0, slot1, slot2)
	return slot0:sendMsg(PlayerModule_pb.GetSimplePropertyRequest(), slot1, slot2)
end

function slot0.onReceiveGetSimplePropertyReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerModel.instance:updateSimpleProperties(slot2.simpleProperties)
	HelpModel.instance:updateShowedHelpId()
end

function slot0.sendSetSimplePropertyRequest(slot0, slot1, slot2)
	slot3 = PlayerModule_pb.SetSimplePropertyRequest()
	slot3.id = slot1
	slot3.property = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveSetSimplePropertyReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.onReceiveSimplePropertyPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.simpleProperty

	PlayerModel.instance:updateSimpleProperty(slot3)

	if slot3.id == PlayerEnum.SimpleProperty.ShowHelpIds then
		HelpModel.instance:updateShowedHelpId()
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.UpdateSimpleProperty, slot3.id)
end

function slot0.sendGetClothInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(PlayerModule_pb.GetClothInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetClothInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerClothModel.instance:onGetInfo(slot2.clothInfos.clothes)
end

function slot0.onReceiveClothUpdatePush(slot0, slot1, slot2)
	PlayerClothModel.instance:onPushInfo(slot2.updateInfos.clothes)
end

function slot0.onReceiveServerResultCodePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if (slot2.resultCode or 0) ~= 0 then
		GameFacade.showToast(slot3)
	end
end

function slot0.sendGetOtherPlayerInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerModule_pb.GetOtherPlayerInfoRequest()
	slot4.userId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetOtherPlayerInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendUseCdKeyRequset(slot0, slot1)
	slot2 = PlayerModule_pb.UseCdKeyRequset()
	slot2.giftCode = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveUseCdKeyReply(slot0, slot1)
	if slot1 == 0 then
		SettingsController.instance:dispatchEvent(SettingsEvent.OnUseCdkReplay)
	end
end

function slot0.sendSetPlayerBgRequest(slot0, slot1)
	slot2 = PlayerModule_pb.SetPlayerBgRequest()
	slot2.bgId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveSetPlayerBgReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendMarkMainThumbnailRequest(slot0)
	slot0:sendMsg(PlayerModule_pb.MarkMainThumbnailRequest())
end

function slot0.onReceiveMarkMainThumbnailReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerModel.instance:setMainThumbnail(true)
end

function slot0.sendGetAssistBonusRequest(slot0)
	slot0:sendMsg(PlayerModule_pb.GetAssistBonusRequest())
end

function slot0.onReceiveGetAssistBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerModel.instance:updateAssistRewardCountData(slot2.assistBonus, slot2.hasReceiveAssistBonus)
end

function slot0.sendReceiveAssistBonusRequest(slot0)
	slot0:sendMsg(PlayerModule_pb.ReceiveAssistBonusRequest())
end

function slot0.onReceiveReceiveAssistBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PlayerModel.instance:updateAssistRewardCountData(slot2.assistBonus, slot2.hasReceiveAssistBonus)
end

function slot0.sendSetMainSceneSkinRequest(slot0, slot1, slot2, slot3)
	slot4 = PlayerModule_pb.SetMainSceneSkinRequest()
	slot4.itemId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSetMainSceneSkinReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.itemId
end

slot0.instance = slot0.New()

return slot0
