module("modules.logic.fight.entity.comp.skill.FightTLEventSceneMove", package.seeall)

slot0 = class("FightTLEventSceneMove")
slot0.MoveType = {
	Revert = 2,
	Move = 1
}

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0.moveType = tonumber(slot3[1])
	slot0.easeType = tonumber(slot3[3])

	if slot0.moveType == uv0.MoveType.Move then
		slot0:handleMove(slot1, slot2, slot3)
	else
		slot0:handleRevert(slot1, slot2, slot3)
	end
end

function slot0.handleMove(slot0, slot1, slot2, slot3)
	slot0.targetPos = FightStrUtil.instance:getSplitToNumberCache(slot3[2], ",")

	if not (FightHelper.getEntity(slot1.fromId) and slot4:getMO()) then
		logError("not found entity mo : " .. tostring(slot1.fromId))

		return
	end

	slot6, slot7, slot8 = FightHelper.getEntityStandPos(slot5)
	slot9 = slot0.targetPos[1]

	if slot0:getSceneTr() then
		slot0:clearTween()

		slot16, slot17, slot18 = transformhelper.getLocalPos(slot15)

		FightModel.instance:setCurSceneOriginPos(slot16, slot17, slot18)

		slot0.tweenId = ZProj.TweenHelper.DOMove(slot15, slot16 + (slot5.side == FightEnum.EntitySide.MySide and slot9 or -slot9) - slot6, slot17 + slot0.targetPos[2] - slot7, slot18 + slot0.targetPos[3] - slot8, slot2, nil, , , slot0.easeType)
	end
end

function slot0.handleRevert(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = FightModel.instance:getCurSceneOriginPos()

	if slot0:getSceneTr() then
		slot0:clearTween()

		slot0.tweenId = ZProj.TweenHelper.DOMove(slot7, slot4, slot5, slot6, slot2, slot0.onRevertCallback, slot0, nil, slot0.easeType)
	end
end

function slot0.getSceneTr(slot0)
	slot2 = GameSceneMgr.instance:getCurScene() and slot1:getSceneContainerGO()

	return slot2 and slot2.transform
end

function slot0.onRevertCallback(slot0)
	slot1, slot2, slot3 = FightModel.instance:getCurSceneOriginPos()

	FightModel.instance:setCurSceneOriginPos(nil, , )

	if slot0:getSceneTr() then
		transformhelper.setLocalPos(slot4, slot1, slot2, slot3)
	end
end

function slot0.onSkillEnd(slot0)
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.clearTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.clearData(slot0)
	slot0.moveType = nil
	slot0.targetPos = nil
	slot0.easeType = nil
end

function slot0.reset(slot0)
	slot0:clearTween()
	slot0:clearData()
end

function slot0.dispose(slot0)
	slot0:clearTween()
	slot0:clearData()
end

return slot0
