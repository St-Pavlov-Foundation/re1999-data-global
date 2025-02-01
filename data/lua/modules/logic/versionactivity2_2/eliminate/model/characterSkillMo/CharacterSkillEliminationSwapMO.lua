module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillEliminationSwapMO", package.seeall)

slot0 = class("CharacterSkillEliminationSwapMO", CharacterSkillMOBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._x1 = -1
	slot0._x2 = -1
	slot0._y1 = -1
	slot0._y2 = -1
end

function slot0.getReleaseParam(slot0)
	slot0._releaseParam = string.format("%d_%d_%d_%d", slot0._x1 - 1, slot0._y1 - 1, slot0._x2 - 1, slot0._y2 - 1)

	return slot0._releaseParam
end

function slot0.canRelease(slot0)
	return slot0._x1 ~= -1 and slot0._y1 ~= -1 and slot0._x2 ~= -1 and slot0._y2 ~= -1
end

function slot0.playAction(slot0, slot1, slot2)
	slot0._cb = slot1
	slot0._cbTarget = slot2
	slot5, slot6 = EliminateChessItemController.instance:getChessItem(slot0._x1, slot0._y1):getGoPos()
	slot7, slot8 = EliminateChessItemController.instance:getChessItem(slot0._x2, slot0._y2):getGoPos()

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_1, slot0._x1, slot0._y1, slot5, slot6, true, nil, )
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_2, slot0._x2, slot0._y2, slot7, slot8, true, slot0.playActionEnd, slot0)
end

function slot0.playActionEnd(slot0)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_1, nil, , , , false, nil, )
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_2, nil, , , , false, nil, )
	EliminateChessController.instance:exchangeCellShow(slot0._x1, slot0._y1, slot0._x2, slot0._y2, 0)

	if slot0._cb ~= nil then
		slot0._cb(slot0._cbTarget)
	else
		EliminateChessController.instance:exchangeCellShow(slot0._x2, slot0._y2, slot0._x1, slot0._y1, 0)
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillCancel, false)
	end

	slot0._cb = nil
end

function slot0.cancelRelease(slot0)
	slot0._cb = nil
end

function slot0.setSkillParam(slot0, ...)
	slot1 = {
		...
	}

	if slot0._x1 == -1 then
		slot0._x1 = slot1[1]
		slot0._y1 = slot1[2]
	else
		slot0._x2 = slot1[1]
		slot0._y2 = slot1[2]
	end
end

return slot0
