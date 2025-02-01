module("modules.logic.character.model.CharacterVoiceModel", package.seeall)

slot0 = class("CharacterVoiceModel", ListScrollModel)

function slot0.setVoiceList(slot0, slot1)
	slot0._moList = {}

	if slot1 then
		slot0._moList = slot1

		table.sort(slot0._moList, function (slot0, slot1)
			if (CharacterDataModel.instance:isCurHeroAudioLocked(slot0.id) and 1 or 0) ~= (CharacterDataModel.instance:isCurHeroAudioLocked(slot1.id) and 1 or 0) then
				return slot2 < slot3
			elseif slot0.score ~= slot1.score and slot2 == 1 and slot3 == 1 then
				return slot0.score < slot1.score
			elseif slot0.sortId ~= slot1.sortId then
				return slot0.sortId < slot1.sortId
			else
				return slot0.id < slot1.id
			end
		end)
	end

	slot0:setList(slot0._moList)
end

function slot0.setNeedItemAni(slot0, slot1)
	slot0._needItemAni = slot1
end

function slot0.isNeedItemAni(slot0)
	return slot0._needItemAni
end

slot0.instance = slot0.New()

return slot0
