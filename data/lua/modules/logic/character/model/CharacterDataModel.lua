module("modules.logic.character.model.CharacterDataModel", package.seeall)

slot0 = class("CharacterDataModel", BaseModel)

function slot0.onInit(slot0)
	slot0._playingList = {}
end

function slot0.getCurHeroVoices(slot0)
	slot1 = {}

	if CharacterDataConfig.instance:getCharacterVoicesCo(slot0._heroId) then
		for slot6, slot7 in pairs(slot2) do
			if slot0:_checkShow(slot0._heroId, slot7) then
				slot9 = 0

				if not string.nilorempty(slot7.unlockCondition) and tonumber(string.split(slot7.unlockCondition, "#")[1]) == 1 then
					slot9 = tonumber(slot10[2])
				end

				table.insert(slot1, {
					id = slot7.audio,
					sortId = slot7.sortId,
					name = slot7.name,
					content = slot7.content,
					englishContent = slot7.encontent,
					unlockCondition = slot7.unlockCondition,
					type = slot7.type,
					param = slot7.param,
					heroId = slot7.heroId,
					score = slot9
				})
			end
		end
	end

	return slot1
end

slot1 = {
	[CharacterEnum.VoiceType.GreetingInThumbnail] = true,
	[CharacterEnum.VoiceType.LimitedEntrance] = true,
	[CharacterEnum.VoiceType.MainViewSpecialInteraction] = true,
	[CharacterEnum.VoiceType.MainViewSpecialRespond] = true,
	[CharacterEnum.VoiceType.MainViewDragSpecialRespond] = true
}

function slot0._checkShow(slot0, slot1, slot2)
	if slot2.show == 2 or uv0[slot2.type] then
		return false
	end

	if slot0:_checkSpecialType(slot2) then
		return false
	end

	if slot2.stateCondition ~= 0 and slot2.stateCondition ~= PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, slot1, CharacterVoiceController.instance:getDefaultValue(slot1)) then
		return false
	end

	if string.nilorempty(slot2.skins) then
		return true
	end

	return string.find(slot2.skins, HeroModel.instance:getByHeroId(slot1).skin)
end

function slot0._checkSpecialType(slot0, slot1)
	return CharacterEnum.VoiceType.SpecialIdle1 <= slot1.type and slot1.type <= CharacterEnum.VoiceType.SpecialIdle2
end

function slot0.isCurHeroAudioLocked(slot0, slot1)
	return HeroModel.instance:getHeroAllVoice(slot0._heroId)[slot1] == nil
end

function slot0.isCurHeroAudioPlaying(slot0, slot1)
	for slot5, slot6 in pairs(slot0._playingList) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.setCurHeroAudioPlaying(slot0, slot1)
	slot0._playingList = {}

	table.insert(slot0._playingList, slot1)
end

function slot0.setCurHeroAudioFinished(slot0, slot1)
	for slot5 = #slot0._playingList, 1, -1 do
		if slot0._playingList[slot5] == slot1 then
			table.remove(slot0._playingList, slot5)

			break
		end
	end
end

function slot0.getCurHeroId(slot0)
	return slot0._heroId
end

function slot0.setCurHeroId(slot0, slot1)
	if slot0._heroId ~= slot1 then
		slot0._playingList = {}
		slot0._heroId = slot1
	end
end

slot0.instance = slot0.New()

return slot0
