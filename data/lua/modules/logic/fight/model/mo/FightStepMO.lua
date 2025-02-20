module("modules.logic.fight.model.mo.FightStepMO", package.seeall)

slot0 = pureTable("FightStepMO")
slot1 = 1

function slot0.ctor(slot0)
	slot0.stepUid = uv0
	uv0 = uv0 + 1
	slot0.atkAudioId = nil
	slot0.editorPlaySkill = nil
	slot0.isParallelStep = false
	slot0.cusParam_lockTimelineTypes = nil
	slot0.cus_Param_invokeSpineActTimelineEnd = nil
	slot0.hasPlay = nil
	slot0.custom_stepIndex = nil
	slot0.custom_ingoreParallelSkill = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0.actType = slot1.actType
	slot0.fromId = slot1.fromId
	slot0.toId = slot1.toId
	slot0.actId = slot1.actId
	slot0.actEffectMOs = slot0:_buildActEffect(slot1.actEffect, slot2)

	if (not slot0.toId or slot0.toId == "0") and #slot0.actEffectMOs > 0 then
		slot0.toId = slot0.actEffectMOs[1].targetId
	end

	slot0.cardIndex = slot1.cardIndex
	slot0.supportHeroId = slot1.supportHeroId
end

function slot0._buildActEffect(slot0, slot1, slot2)
	slot3 = {}
	slot5 = FightDataHelper.entityMgr:getById(slot0.fromId) and slot4.side

	if not slot4 then
		if slot0.fromId == FightEntityScene.MySideId then
			slot5 = FightEnum.EntitySide.MySide
		elseif slot0.fromId == FightEntityScene.EnemySideId then
			slot5 = FightEnum.EntitySide.EnemySide
		end
	end

	for slot9, slot10 in ipairs(slot1) do
		slot11 = false

		if slot10.effectType == FightEnum.EffectType.FIGHTSTEP then
			if FightHelper.isTimelineStep(slot10.fightStep) then
				slot11 = true
			end
		elseif slot10.effectType == FightEnum.EffectType.ATTR then
			slot11 = true
		end

		if slot2 then
			slot11 = false
		end

		if not slot11 then
			slot12 = FightActEffectMO.New()

			slot12:init(slot10, slot5)
			table.insert(slot3, slot12)
		end
	end

	return slot3
end

return slot0
