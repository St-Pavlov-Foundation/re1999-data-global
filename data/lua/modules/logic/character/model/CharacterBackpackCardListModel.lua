module("modules.logic.character.model.CharacterBackpackCardListModel", package.seeall)

slot0 = class("CharacterBackpackCardListModel", ListScrollModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._characterFirstToShow = nil
end

function slot0.updateModel(slot0)
	slot0.moList = slot0.moList or {}

	slot0:setList(slot0.moList)
end

function slot0.setFirstShowCharacter(slot0, slot1)
	slot0._characterFirstToShow = slot1
end

function slot0._doCharacterFirst(slot0, slot1)
	if not slot0._characterFirstToShow then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6.heroId == slot0._characterFirstToShow then
			table.remove(slot1, slot5)
			table.insert(slot1, 1, slot6)

			break
		end
	end
end

function slot0.setCharacterCardList(slot0, slot1)
	slot0.moList = slot1 or {}

	slot0:_doCharacterFirst(slot0.moList)
	slot0:setList(slot0.moList)
end

function slot0.getCharacterCardList(slot0)
	return slot0:getList()
end

function slot0.setCharacterViewDragMOList(slot0, slot1)
	slot0.characterViewDragMOList = {}

	if not (slot1 or slot0.moList) then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.characterViewDragMOList, slot6)
	end
end

function slot0.getNextCharacterCard(slot0, slot1)
	slot2 = nil

	if slot0.characterViewDragMOList then
		for slot6, slot7 in ipairs(slot0.characterViewDragMOList) do
			if slot7.heroId == slot1 then
				return slot6 ~= #slot0.characterViewDragMOList and slot0.characterViewDragMOList[slot6 + 1] or slot0.characterViewDragMOList[1]
			end
		end
	end
end

function slot0.getLastCharacterCard(slot0, slot1)
	slot2 = nil

	if slot0.characterViewDragMOList then
		for slot6, slot7 in pairs(slot0.characterViewDragMOList) do
			if slot7.heroId == slot1 then
				return slot6 ~= 1 and slot0.characterViewDragMOList[slot6 - 1] or slot0.characterViewDragMOList[#slot0.characterViewDragMOList]
			end
		end
	end
end

function slot0.clearCardList(slot0)
	slot0.moList = nil

	slot0:clear()
end

slot0.instance = slot0.New()

return slot0
