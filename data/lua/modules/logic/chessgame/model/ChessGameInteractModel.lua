module("modules.logic.chessgame.model.ChessGameInteractModel", package.seeall)

slot0 = class("ChessGameInteractModel", BaseModel)

function slot0.onInit(slot0)
	slot0._interacts = {}
	slot0._finishInteractMap = {}
	slot0._interactsByMapIndex = {}
	slot0._showEffect = {}
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.setInteractDatas(slot0, slot1, slot2)
	slot0._interacts = {}
	slot0._interactsByMapIndex = {}
	slot0._finishInteractMap = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = ChessGameInteractMo.New()
		slot11 = ChessGameConfig.instance:getInteractCoById(slot7.mapGroupId or ChessGameConfig.instance:getCurrentMapGroupId(), slot7.id)
		slot7.mapIndex = slot2

		slot8:init(slot11, slot7)

		slot0._interacts[slot11.id] = slot8
		slot0._interactsByMapIndex[slot2] = slot0._interactsByMapIndex[slot2] or {}
		slot0._interactsByMapIndex[slot2][slot11.id] = slot8
	end

	slot0:setInteractFinishMap()
end

function slot0.addInteractMo(slot0, slot1, slot2)
	slot3 = ChessGameInteractMo.New()

	slot3:init(slot1, slot2)

	slot0._interacts[slot1.id] = slot3

	return slot3
end

function slot0.getInteractById(slot0, slot1)
	return slot0._interacts[slot1]
end

function slot0.deleteInteractById(slot0, slot1)
	slot0._interacts[slot1] = nil
	slot0._interactsByMapIndex[ChessGameModel.instance.nowMapIndex][slot1] = nil
end

function slot0.getAllInteracts(slot0)
	return slot0._interacts
end

function slot0.getInteractsByMapIndex(slot0, slot1)
	return slot0._interactsByMapIndex[slot1 or ChessGameModel.instance.nowMapIndex] or {}
end

function slot0.getInteractByPos(slot0, slot1, slot2, slot3)
	slot4 = {}

	if not slot0._interactsByMapIndex[slot3 or ChessGameModel.instance.nowMapIndex] then
		return
	end

	for slot8, slot9 in pairs(slot0._interactsByMapIndex[slot3]) do
		slot10, slot11 = slot9:getXY()

		if slot10 == slot1 and slot11 == slot2 then
			table.insert(slot4, slot9)
		end
	end

	return slot4
end

function slot0.setInteractFinishMap(slot0)
	for slot4, slot5 in pairs(slot0._interacts) do
		if slot5:CheckInteractFinish() then
			slot0._finishInteractMap[slot4] = true
		end
	end
end

function slot0.checkInteractFinish(slot0, slot1)
	return slot0._finishInteractMap[slot1]
end

function slot0.setShowEffect(slot0, slot1)
	slot0._showEffect[slot1] = true
end

function slot0.setHideEffect(slot0, slot1)
	slot0._showEffect[slot1] = false
end

function slot0.getShowEffects(slot0)
	return slot0._showEffect
end

function slot0.clear(slot0)
	slot0._interacts = {}
	slot0._interactsByMapIndex = {}
	slot0._finishInteractMap = {}
	slot0._showEffect = {}
end

slot0.instance = slot0.New()

return slot0
