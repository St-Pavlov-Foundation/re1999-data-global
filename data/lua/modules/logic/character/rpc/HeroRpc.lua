module("modules.logic.character.rpc.HeroRpc", package.seeall)

slot0 = class("HeroRpc", BaseRpc)

function slot0.sendHeroInfoListRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroModule_pb.HeroInfoListRequest(), slot1, slot2)
end

function slot0.onReceiveHeroInfoListReply(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroModel.instance:onGetHeroList(slot2.heros)
		HeroModel.instance:onGetSkinList(slot2.allHeroSkin)
		HeroModel.instance:setTouchHeadNumber(slot2.touchCountLeft)
		SignInModel.instance:setHeroBirthdayInfos(slot2.birthdayInfos)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroInfoListReply)
	end
end

function slot0.sendHeroLevelUpRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = HeroModule_pb.HeroLevelUpRequest()
	slot5.heroId = slot1
	slot5.expectLevel = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveHeroLevelUpReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterModel.instance:setFakeLevel()
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroLevelUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute)
	end
end

function slot0.onReceiveHeroLevelUpUpdatePush(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroModel.instance:setHeroLevel(slot2.heroId, slot2.newLevel)
		HeroModel.instance:setHeroRank(slot2.heroId, slot2.newRank)
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroLevelUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute)
	end
end

function slot0.sendHeroRankUpRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroModule_pb.HeroRankUpRequest()
	slot4.heroId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveHeroRankUpReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroRankUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, {
			heroId = slot2.heroId,
			newRank = slot2.newRank,
			isRank = true
		})

		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) and slot2.newRank == CharacterEnum.TalentRank then
			CharacterController.instance:stateTalent(slot2.heroId)
		end

		SDKChannelEventModel.instance:heroRankUp(slot2.newRank)
	end
end

function slot0.onReceiveHeroSkinGainPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if not CharacterEnum.SkinOpen then
		return
	end

	HeroModel.instance:onGainSkinList(slot2.skinId)

	if slot2.getApproach == MaterialEnum.GetApproach.Task or slot2.getApproach == MaterialEnum.GetApproach.TaskAct then
		TaskController.instance:getRewardByLine(slot2.getApproach, ViewName.CharacterSkinGainView, {
			skinId = slot2.skinId,
			firstGain = slot2.firstGain
		})
	elseif slot2.getApproach ~= MaterialEnum.GetApproach.NoviceStageReward then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainSkinView, ViewName.CharacterSkinGainView, slot3)
	else
		TaskModel.instance:setTaskNoviceStageHeroParam(slot3)
	end
end

function slot0.onReceiveHeroGainPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = {
		heroId = slot2.heroId,
		duplicateCount = slot2.duplicateCount or 0
	}

	if not CharacterModel.instance:getGainHeroViewShowState() then
		if CharacterModel.instance:getGainHeroViewShowNewState() and slot2.duplicateCount > 0 then
			return
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, slot3)
	end
end

function slot0.sendHeroTalentUpRequest(slot0, slot1)
	slot2 = HeroModule_pb.HeroTalentUpRequest()
	slot2.heroId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveHeroTalentUpReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroTalentUp)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function slot0.onReceiveHeroUpdatePush(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroModel.instance:onSetHeroChange(slot2.heroUpdates)
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroUpdatePush)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function slot0.sendHeroUpgradeSkillRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroModule_pb.HeroUpgradeSkillRequest()
	slot4.heroId = slot1
	slot4.type = slot2
	slot4.consume = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveHeroUpgradeSkillReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successHeroExSkillUp)
	end
end

function slot0.sendItemUnlockRequest(slot0, slot1, slot2)
	slot3 = HeroModule_pb.ItemUnlockRequest()
	slot3.heroId = slot1
	slot3.itemId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveItemUnlockReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddUnlockItem, slot2.heroId, slot2.itemId)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddUnlockItemFail)
	end
end

function slot0.sendUnMarkIsNewRequest(slot0, slot1)
	slot2 = HeroModule_pb.UnMarkIsNewRequest()
	slot2.heroId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveUnMarkIsNewReply(slot0, slot1, slot2)
	if slot1 == 0 then
		logNormal("更新角色" .. tostring(slot2.heroId) .. tostring("新旧标记成功！"))
	end
end

function slot0.sendUnlockVoiceRequest(slot0, slot1, slot2)
	slot3 = HeroModule_pb.UnlockVoiceRequest()
	slot3.heroId = slot1
	slot3.voiceId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveUnlockVoiceReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroDataAddVoice)
	end
end

function slot0.sendUseSkinRequest(slot0, slot1, slot2)
	slot3 = HeroModule_pb.UseSkinRequest()
	slot3.heroId = slot1
	slot3.skinId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveUseSkinReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.successDressUpSkin, {
		heroId = slot2.heroId,
		skinId = slot2.skinId
	})
end

function slot0.sendTouchHeadRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroModule_pb.HeroTouchRequest()
	slot4.heroId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveHeroTouchReply(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroModel.instance:setTouchHeadNumber(slot2.touchCountLeft)
		MainController.instance:dispatchEvent(MainEvent.OnReceiveAddFaithEvent, slot2.success)
	end
end

slot0.CubePut = "putCubeInfo"
slot0.CubeGet = "getCubeInfo"

function slot0.PutTalentCubeRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = HeroModule_pb.PutTalentCubeRequest()
	slot8 = slot2 == HeroResonanceEnum.PutCube and uv0.CubePut or uv0.CubeGet
	slot7.heroId = slot1
	slot7[slot8].cubeId = slot3
	slot7[slot8].direction = slot4
	slot7[slot8].posX = slot5
	slot7[slot8].posY = slot6
	slot7.templateId = HeroModel.instance:getCurTemplateId(slot1)

	slot0:sendMsg(slot7)
end

function slot0.onReceivePutTalentCubeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnPutTalentCubeReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function slot0.RenameTalentTemplateRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroModule_pb.RenameTalentTemplateRequest()
	slot4.heroId = slot1
	slot4.templateId = slot2
	slot4.name = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveRenameTalentTemplateReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.RenameTalentTemplateReply)
	end
end

function slot0.UseTalentTemplateRequest(slot0, slot1, slot2)
	slot3 = HeroModule_pb.UseTalentTemplateRequest()
	slot3.heroId = slot1
	slot3.templateId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveUseTalentTemplateReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.UseTalentTemplateReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function slot0.TakeoffAllTalentCubeRequest(slot0, slot1)
	slot2 = HeroModule_pb.TakeoffAllTalentCubeRequest()
	slot2.heroId = slot1
	slot2.templateId = HeroModel.instance:getCurTemplateId(slot1)

	slot0:sendMsg(slot2)
end

function slot0.onReceiveTakeoffAllTalentCubeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		HeroModel.instance:takeoffAllTalentCube(slot2.heroId)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList, slot2.heroId)
	end
end

function slot0.PutTalentSchemeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = HeroModule_pb.PutTalentSchemeRequest()
	slot5.heroId = slot1
	slot5.talentId = slot2
	slot5.talentMould = slot3
	slot5.starMould = slot4
	slot5.templateId = HeroModel.instance:getCurTemplateId(slot1)

	slot0:sendMsg(slot5)
end

function slot0.onReceivePutTalentSchemeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnPutTalentCubeReply)
		CharacterController.instance:dispatchEvent(CharacterEvent.RefreshCubeList)
	end
end

function slot0.setHeroDefaultEquipRequest(slot0, slot1, slot2)
	slot3 = HeroModule_pb.HeroDefaultEquipRequest()
	slot3.heroId = slot1
	slot3.defaultEquipUid = slot2

	slot0:sendMsg(slot3)

	slot5 = HeroModel.instance:getByHeroId(slot1).uid

	for slot9, slot10 in ipairs(HeroGroupModel.instance:getList()) do
		for slot15, slot16 in ipairs(slot10:_getHeroListBackup()) do
			if slot16 == slot5 then
				HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(slot10.groupId, slot15 - 1, {
					slot2
				})
			end
		end
	end
end

function slot0.onReceiveHeroDefaultEquipReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.successSetDefaultEquip, slot2.defaultEquipUid)
	end
end

function slot0.setUnlockTalentStyleRequest(slot0, slot1, slot2)
	slot3 = HeroModule_pb.UnlockTalentStyleRequest()
	slot3.heroId = slot1
	slot3.style = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveUnlockTalentStyleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onUnlockTalentStyleReply, slot2)
	end
end

function slot0.setUseTalentStyleRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroModule_pb.UseTalentStyleRequest()
	slot4.heroId = slot1
	slot4.templateId = slot2
	slot4.style = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveUseTalentStyleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onUseTalentStyleReply, slot2)
	end
end

function slot0.setTalentStyleReadRequest(slot0, slot1)
	slot2 = HeroModule_pb.TalentStyleReadRequest()
	slot2.heroId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveTalentStyleReadReply(slot0, slot1, slot2)
	if slot1 == 0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.onTalentStyleRead, slot2.heroId)
	end
end

function slot0.setMarkHeroFavorRequest(slot0, slot1, slot2)
	slot3 = HeroModule_pb.MarkHeroFavorRequest()
	slot3.heroId = slot1
	slot3.isFavor = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveMarkHeroFavorReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	HeroModel.instance:setHeroFavorState(slot2.heroId, slot2.isFavor)

	if slot2.isFavor then
		GameFacade.showToast(ToastEnum.HeroFavorMarked)
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.OnMarkFavorSuccess, slot2.heroId)
end

slot0.instance = slot0.New()

return slot0
