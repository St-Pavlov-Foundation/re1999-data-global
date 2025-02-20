module("modules.logic.fight.entity.mgr.FightAudioMgr", package.seeall)

slot0 = class("FightAudioMgr")
slot1 = {
	[100102.0] = 3025,
	[100101.0] = 3023,
	[100109.0] = 3023
}

function slot0.init(slot0)
	slot0._str2Id = {}
	slot0._cardAudio = {}
	slot0._fightAudio = {}
	slot0._fightAudioStartTime = {}
	slot0._fightAudio2LangDict = {}
	slot0._playingBnk2Lang = {}
	slot0._playingBnk2AudioIds = {}
end

function slot0.dispose(slot0)
	slot0:clearCardAudio()
	slot0:stopAllFightAudio()
end

function slot0.onDirectPlayAudio(slot0, slot1)
	if slot1 then
		slot0._fightAudioStartTime[slot1] = Time.time
	end
end

function slot0.playAudio(slot0, slot1)
	if not slot1 or slot1 <= 0 then
		return
	end

	slot3 = slot0._fightAudioStartTime[slot1]
	slot0._fightAudioStartTime[slot1] = Time.time

	if AudioEffectMgr.instance:isPlaying(slot1) and slot3 and slot2 - slot3 < 0.01 then
		return
	end

	if AudioConfig.instance:getAudioCOById(slot1) then
		slot7 = GameConfig:GetCurVoiceShortcut()

		if slot0._playingBnk2Lang[slot5.bankName] and slot0._playingBnk2Lang[slot6] ~= slot7 and slot0._playingBnk2AudioIds[slot6] then
			for slot12, slot13 in ipairs(slot8) do
				AudioEffectMgr.instance:stopAudio(slot13)
			end

			slot0._playingBnk2AudioIds[slot6] = {}
		end

		slot0._playingBnk2Lang[slot6] = slot7
		slot0._playingBnk2AudioIds[slot6] = slot0._playingBnk2AudioIds[slot6] or {}

		table.insert(slot0._playingBnk2AudioIds[slot6], slot1)
	end

	if slot4 then
		AudioEffectMgr.instance:stopAudio(slot1)
	end

	AudioEffectMgr.instance:playAudio(slot1)

	if not tabletool.indexOf(slot0._fightAudio, slot1) then
		table.insert(slot0._fightAudio, slot1)
	end
end

function slot0.playAudioWithLang(slot0, slot1, slot2)
	if not slot2 then
		slot0:playAudio(slot1)

		return
	end

	if not slot1 or slot1 <= 0 then
		return
	end

	slot4 = slot0._fightAudioStartTime[slot1]
	slot0._fightAudioStartTime[slot1] = Time.time

	if AudioEffectMgr.instance:isPlaying(slot1) and slot4 and slot3 - slot4 < 0.01 then
		return
	end

	if AudioConfig.instance:getAudioCOById(slot1) then
		if slot0._playingBnk2Lang[slot6.bankName] and slot0._playingBnk2Lang[slot7] ~= slot2 and slot0._playingBnk2AudioIds[slot7] then
			for slot13, slot14 in ipairs(slot9) do
				AudioEffectMgr.instance:stopAudio(slot14)
			end

			slot0._playingBnk2AudioIds[slot7] = {}
		end

		slot0._playingBnk2Lang[slot7] = slot2
		slot0._playingBnk2AudioIds[slot7] = slot0._playingBnk2AudioIds[slot7] or {}

		table.insert(slot0._playingBnk2AudioIds[slot7], slot1)

		if slot5 and slot0._fightAudio2LangDict[slot1] and slot0._fightAudio2LangDict[slot1] ~= slot2 then
			AudioEffectMgr.instance:stopAudio(slot1)
		end

		slot0._fightAudio2LangDict[slot1] = slot2
	end

	if slot5 then
		AudioEffectMgr.instance:stopAudio(slot1)
	end

	AudioEffectMgr.instance:playAudio(slot1, nil, slot2)

	if not tabletool.indexOf(slot0._fightAudio, slot1) then
		table.insert(slot0._fightAudio, slot1)
	end
end

function slot0.stopAudio(slot0, slot1)
	if slot1 and slot1 > 0 then
		tabletool.removeValue(slot0._fightAudio, slot1)
		AudioEffectMgr.instance:stopAudio(slot1, 0)
	end
end

function slot0.playCardAudio(slot0, slot1, slot2, slot3)
	slot0:stopCardAudio(slot1)

	slot0._cardAudio[slot1] = slot2
	slot4 = nil

	if slot3 then
		slot5, slot6, slot7 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot3)

		if not string.nilorempty(LangSettings.shortcutTab[slot5]) and not slot7 then
			slot4 = slot8
		end
	end

	AudioEffectMgr.instance:playAudio(slot2, nil, slot4)
	AudioEffectMgr.instance:setSwitch(slot2, AudioMgr.instance:getIdFromString("card_voc"), AudioMgr.instance:getIdFromString("fightingvoc"))
end

function slot0.stopAllFightAudio(slot0)
	if not slot0._fightAudio then
		return
	end

	for slot4, slot5 in ipairs(slot0._fightAudio) do
		AudioEffectMgr.instance:stopAudio(slot5)
	end

	slot0._fightAudio = {}
end

function slot0.stopAllCardAudio(slot0)
	if not slot0._cardAudio then
		return
	end

	for slot4, slot5 in pairs(slot0._cardAudio) do
		AudioEffectMgr.instance:stopAudio(slot5)
	end
end

function slot0.clearCardAudio(slot0)
	slot0._cardAudio = {}
end

function slot0.stopCardAudio(slot0, slot1)
	if slot0._cardAudio[slot1] then
		AudioEffectMgr.instance:stopAudio(slot2)
	end
end

function slot0.playHeroVoiceRandom(slot0, slot1, slot2)
	if slot0:getHeroVoiceRandom(slot1, slot2) then
		slot4 = nil

		if slot1 then
			slot5, slot6, slot7 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot1)

			if not string.nilorempty(LangSettings.shortcutTab[slot5]) and not slot7 then
				slot4 = slot8
			end
		end

		slot0:playAudioWithLang(slot3, slot4)
	end
end

function slot0.getHeroVoiceRandom(slot0, slot1, slot2, slot3)
	if not slot0:_getHeroVoiceCOs(slot1, slot2, FightDataHelper.entityMgr:getById(slot3) and slot4.skin) or #slot5 == 0 then
		return
	end

	if #slot5 == 1 then
		return slot5[slot6].audio
	end

	while true do
		slot7 = slot5[math.random(slot6)]

		if not slot3 or slot7.audio ~= slot0._cardAudio[slot3] then
			return slot7.audio
		end
	end
end

function slot0.playHitVoice(slot0, slot1, slot2)
	if slot0:getHeroVoiceWithWeight(slot1, CharacterEnum.VoiceType.FightBehit) then
		slot0:playAudioWithLang(slot4, slot2)
		AudioEffectMgr.instance:setSwitch(slot4, AudioMgr.instance:getIdFromString("Hitvoc"), AudioMgr.instance:getIdFromString("commbatuihitvoc"))
	end
end

function slot0.getHeroVoiceWithWeight(slot0, slot1, slot2)
	if slot0:_getHeroVoiceCOs(slot1, slot2) and #slot3 > 0 then
		for slot8, slot9 in ipairs(slot3) do
			slot4 = 0 + (tonumber(slot9.param) or 0)
		end

		for slot10, slot11 in ipairs(slot3) do
			if math.random() <= (0 + (tonumber(slot11.param) or 0)) / slot4 then
				return slot11.audio
			end
		end
	end
end

function slot0._getHeroVoiceCOs(slot0, slot1, slot2, slot3)
	if CharacterDataConfig.instance:getCharacterVoicesCo(slot1) then
		if HeroModel.instance:getByHeroId(slot1) then
			return HeroModel.instance:getVoiceConfig(slot1, slot2, nil, slot3)
		else
			return CharacterDataConfig.instance:getCharacterTypeVoicesCO(slot1, slot2, slot3)
		end
	elseif lua_monster.configDict[slot1] and FightConfig.instance:getSkinCO(slot4.skinId) then
		return CharacterDataConfig.instance:getCharacterTypeVoicesCO(slot5.characterId, slot2, slot4.skinId)
	end
end

function slot0.playHit(slot0, slot1, slot2, slot3)
	if FightConfig.instance:getSkinCO(slot2) then
		AudioMgr.instance:setSwitch(slot0:getId(FightEnum.HitStatusGroupName), slot0:getId(FightEnum.HitStatusArr[slot3 and 2 or 1]))
		AudioMgr.instance:setSwitch(slot0:getId(FightEnum.HitMaterialGroupName), slot0:getId(FightEnum.HitMaterialArr[slot4.matId]))
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0.playHitByAtkAudioId(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot5 = FightConfig.instance:getSkinCO(slot2)

	if lua_fight_audio.configDict[slot1] and slot5 then
		if (tonumber(slot4.weapon) or 0) == 99 then
			return
		end

		AudioMgr.instance:setSwitch(slot0:getId(FightEnum.HitStatusGroupName), slot0:getId(FightEnum.HitStatusArr[slot3 and 2 or 1]))
		AudioMgr.instance:setSwitch(slot0:getId(FightEnum.HitMaterialGroupName), slot0:getId(FightEnum.HitMaterialArr[slot5.matId]))
		AudioMgr.instance:setSwitch(slot0:getId(FightEnum.WeaponHitSwitchGroup), slot0:getId(FightEnum.WeaponHitSwitchNames[slot6] or ""))
		AudioMgr.instance:trigger(FightEnum.UniformDefAudioId)
	end
end

function slot0.setSwitch(slot0, slot1)
	AudioMgr.instance:setSwitch(slot0:getId(FightEnum.AudioSwitchGroup), slot0:getId(slot1))
end

function slot0.getId(slot0, slot1)
	if not slot0._str2Id[slot1] then
		slot0._str2Id[slot1] = AudioMgr.instance:getIdFromString(slot1)
	end

	return slot2
end

function slot0.obscureBgm(slot0, slot1)
	if not slot0.mainObscureCount then
		slot0.mainObscureCount = 0
	end

	slot0.mainObscureCount = slot0.mainObscureCount + (slot1 and 1 or -1)

	if not slot1 and slot0.mainObscureCount ~= 0 then
		return
	end

	if slot1 and slot0.mainObscureCount ~= 1 then
		return
	end

	if GameSceneMgr.instance:isFightScene() then
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("main_obscure"), AudioMgr.instance:getIdFromString(slot1 and "yes" or "no"))
	end
end

slot0.instance = slot0.New()

return slot0
