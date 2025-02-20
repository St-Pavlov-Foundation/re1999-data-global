module("modules.logic.fight.model.mo.FightRoundMO", package.seeall)

slot0 = pureTable("FightRoundMO")

function slot0.ctor(slot0)
	slot0._aiUseCardMODict = {}
end

function slot0.init(slot0, slot1)
	slot0.fightStepMOs = FightHelper.buildInfoMOs(FightHelper.processRoundStep(slot1.fightStep), FightStepMO)

	if slot1:HasField("actPoint") then
		slot0.actPoint = slot1.actPoint
	end

	if slot1:HasField("isFinish") then
		slot0.isFinish = slot1.isFinish
	end

	if slot1:HasField("moveNum") then
		slot0.moveNum = slot1.moveNum
	end

	slot0._exPointMODict = slot0:_buildExPointDict(slot1.exPointInfo, FightExPointInfoMO)
	slot0._lastAIUseCardMODict = slot0._aiUseCardMODict
	slot0._lastAIUseCardMOList = slot0._aiUseCardMOList
	slot0._aiUseCardMODict, slot0._aiUseCardMOList = slot0:_buildAIUseCardInfo(slot1.aiUseCards, FightCardInfoMO)

	if slot1:HasField("power") then
		slot0.power = slot1.power
	end

	slot0.beforeCards1 = FightHelper.buildInfoMOs(slot1.beforeCards1, FightCardInfoMO)
	slot0.teamACards1 = FightHelper.buildInfoMOs(slot1.teamACards1, FightCardInfoMO)
	slot0.beforeCards2 = FightHelper.buildInfoMOs(slot1.beforeCards2, FightCardInfoMO)
	slot0.teamACards2 = FightHelper.buildInfoMOs(slot1.teamACards2, FightCardInfoMO)
	slot0.nextRoundBeginStepMOs = FightHelper.buildInfoMOs(FightHelper.processRoundStep(slot1.nextRoundBeginStep), FightStepMO)
	slot0.lastChangeHeroUid = slot1.lastChangeHeroUid

	slot0:_calcMultiHpChange()
	slot0:_removeSceneEntityEffect()
	slot0:_markStepIndex()
end

function slot0.updateClothSkillRound(slot0, slot1)
	slot0.fightStepMOs = FightHelper.buildInfoMOs(FightHelper.processRoundStep(slot1.fightStep), FightStepMO)
	slot0._exPointMODict = slot0:_buildExPointDict(slot1.exPointInfo, FightExPointInfoMO)

	if slot1:HasField("actPoint") then
		slot0.actPoint = slot1.actPoint
	end

	if slot1:HasField("isFinish") then
		slot0.isFinish = slot1.isFinish
	end

	if slot1:HasField("moveNum") then
		slot0.moveeNum = slot1.moveNum
	end

	if slot1:HasField("power") then
		slot0.power = slot1.power
	end

	slot0.beforeCards1 = FightHelper.buildInfoMOs(slot1.beforeCards1, FightCardInfoMO)
	slot0.teamACards1 = FightHelper.buildInfoMOs(slot1.teamACards1, FightCardInfoMO)
	slot0.beforeCards2 = FightHelper.buildInfoMOs(slot1.beforeCards2, FightCardInfoMO)
	slot0.teamACards2 = FightHelper.buildInfoMOs(slot1.teamACards2, FightCardInfoMO)

	slot0:_markStepIndex()
end

function slot0._markStepIndex(slot0)
	if slot0.fightStepMOs then
		for slot4, slot5 in ipairs(slot0.fightStepMOs) do
			slot5.custom_stepIndex = slot4
		end
	end
end

function slot0.clone(slot0)
	slot1 = uv0.New()
	slot1.fightStepMOs = slot0.fightStepMOs
	slot1.actPoint = slot0.actPoint
	slot1.isFinish = slot0.isFinish
	slot1.moveNum = slot0.moveNum
	slot1._exPointMODict = slot0._exPointMODict
	slot1._aiUseCardMODict = slot0._aiUseCardMODict
	slot1.power = slot0.power
	slot1.beforeCards1 = slot0.beforeCards1
	slot1.teamACards1 = slot0.teamACards1
	slot1.beforeCards2 = slot0.beforeCards2
	slot1.teamACards2 = slot0.teamACards2
	slot1.nextRoundBeginStepMOs = slot0.nextRoundBeginStepMOs

	return slot1
end

function slot0.onBeginRound(slot0)
end

function slot0._buildExPointDict(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot1) do
		slot9 = slot2.New()

		slot9:init(slot8)

		if slot9.id or slot9.uid then
			-- Nothing
		end
	end

	return {
		[slot10] = slot9
	}
end

function slot0._buildAIUseCardInfo(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		slot10 = slot2.New()

		slot10:init(slot9)

		slot10.custom_enemyCardIndex = slot8

		if slot10.id or slot10.uid then
			if not slot4[slot11] then
				slot4[slot11] = {}
			end

			table.insert(slot12, slot10)
			table.insert(slot3, slot10)
		end
	end

	return slot4, slot3
end

function slot0._calcMultiHpChange(slot0)
	for slot4 = #slot0.fightStepMOs, 1, -1 do
		slot6 = nil
		slot7 = 1

		for slot11, slot12 in ipairs(slot0.fightStepMOs[slot4].actEffectMOs) do
			if slot12.effectType == FightEnum.EffectType.MULTIHPCHANGE then
				slot6 = slot12
				slot7 = slot11

				break
			end
		end

		if slot6 then
			slot8 = {}

			for slot12 = #slot5.actEffectMOs, slot7 + 1, -1 do
				if slot5.actEffectMOs[slot12].targetId == slot6.targetId then
					table.insert(slot8, 1, table.remove(slot5.actEffectMOs, slot12))
				end
			end

			if #slot8 > 0 then
				slot9 = FightStepMO.New()

				slot9:init({
					actType = FightEnum.ActType.EFFECT,
					fromId = slot5.fromId,
					toId = slot5.toId,
					actId = slot5.actId,
					actEffect = {}
				})

				slot9.actEffectMOs = slot8
				slot9.stepUid = slot5.stepUid + 1
				slot11 = slot4 + 1
				slot15 = slot11

				table.insert(slot0.fightStepMOs, slot15, slot9)

				for slot15 = slot11 + 1, #slot0.fightStepMOs do
					slot16 = slot0.fightStepMOs[slot15]
					slot16.stepUid = slot16.stepUid + 1
				end
			end
		end
	end
end

slot1 = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.BEATBACK] = true,
	[FightEnum.EffectType.DAMAGEEXTRA] = true,
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.HEALCRIT] = true,
	[FightEnum.EffectType.BLOODLUST] = true
}

function slot0._removeSceneEntityEffect(slot0)
	for slot4 = #slot0.fightStepMOs, 1, -1 do
		if slot0.fightStepMOs[slot4].actType == FightEnum.ActType.EFFECT then
			for slot10 = #slot5.actEffectMOs, 1, -1 do
				if uv0[slot6[slot10].effectType] and (slot11.targetId == FightEntityScene.MySideId or slot11.targetId == FightEntityScene.EnemySideId) then
					table.remove(slot6, slot10)
				end
			end
		end
	end
end

function slot0.getEntityAIUseCardMOs(slot0, slot1)
	return slot0._aiUseCardMODict[slot1] or {}
end

function slot0.getEnemyActPoint(slot0)
	return slot0._aiUseCardMOList and #slot0._aiUseCardMOList
end

function slot0.getAIUseCardMOList(slot0)
	return slot0._aiUseCardMOList
end

function slot0.getEntityLastAIUseCard(slot0, slot1)
	if slot0._lastAIUseCardMODict then
		return slot0._lastAIUseCardMODict[slot1]
	end

	return {}
end

function slot0.getAILastUseCard(slot0)
	return slot0._lastAIUseCardMOList
end

return slot0
