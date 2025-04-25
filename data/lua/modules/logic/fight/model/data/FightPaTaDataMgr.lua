module("modules.logic.fight.model.data.FightPaTaDataMgr", package.seeall)

slot0 = FightDataClass("FightPaTaDataMgr")

function slot0.onConstructor(slot0)
	slot0.bossInfoList = {}
end

function slot0.sortSkillInfo(slot0, slot1)
	return slot0.powerLow < slot1.powerLow
end

function slot0.updateData(slot0, slot1)
	if not slot1.attacker:HasField("assistBossInfo") then
		return
	end

	slot2 = slot1.attacker.assistBossInfo
	slot0.currCd = slot2.currCd
	slot0.cfgCd = slot2.cdCfg
	slot0.formId = slot2.formId
	slot0.roundUseLimit = slot2.roundUseLimit
	slot0.exceedUseFree = slot2.exceedUseFree
	slot0.params = slot2.params
	slot0.preUsePower = 0
	slot0.preCostCd = 0
	slot0.useCardCount = 0

	slot0:updateSkill(slot2.skills)
end

function slot0.switchBossSkill(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.currCd = slot1.currCd
	slot0.cfgCd = slot1.cdCfg
	slot0.formId = slot1.formId

	slot0:updateSkill(slot1.skills)
end

function slot0.updateSkill(slot0, slot1)
	tabletool.clear(slot0.bossInfoList)

	for slot5, slot6 in ipairs(slot1) do
		slot7 = FightAssistBossSkillInfoMo.New()

		slot7:init(slot6)
		table.insert(slot0.bossInfoList, slot7)
	end

	table.sort(slot0.bossInfoList, uv0.sortSkillInfo)
end

function slot0.changeScore(slot0, slot1)
	slot0.score = slot0.score and slot0.score + slot1 or slot1
end

function slot0.getScore(slot0)
	return slot0.score
end

function slot0.hadCD(slot0)
	return slot0.cfgCd and slot0.cfgCd > 0
end

function slot0.getCurCD(slot0)
	return slot0.currCd + slot0.preCostCd
end

function slot0.setCurrCD(slot0, slot1)
	slot0.currCd = tonumber(slot1)
end

function slot0.getFromId(slot0)
	return slot0.formId + 1
end

function slot0.getAssistBossPower(slot0)
	slot2 = slot0:getAssistBossMo() and slot1:getPowerInfo(FightEnum.PowerType.AssistBoss)

	return (slot2 and slot2.num or 0) - slot0.preUsePower, slot2 and slot2.max or 0
end

function slot0.getAssistBossServerPower(slot0)
	slot2 = slot0:getAssistBossMo() and slot1:getPowerInfo(FightEnum.PowerType.AssistBoss)

	return slot2 and slot2.num or 0, slot2 and slot2.max or 0
end

function slot0.getAssistBossMo(slot0)
	return slot0.dataMgr.entityMgr:getAssistBoss()
end

function slot0.playAssistBossSkill(slot0, slot1)
	slot0.preUsePower = slot0.preUsePower + slot0:getNeedPower(slot1)
	slot0.useCardCount = slot0.useCardCount + 1
	slot0.preCostCd = slot0.preCostCd + slot0.cfgCd
end

function slot0.getNeedPower(slot0, slot1)
	if slot0.exceedUseFree ~= 0 and slot0.exceedUseFree <= slot0.useCardCount then
		return 0
	end

	return slot1.needPower
end

function slot0.playAssistBossSkillBySkillId(slot0, slot1)
	for slot5 = #slot0.bossInfoList, 1, -1 do
		if slot0.bossInfoList[slot5].skillId == slot1 then
			slot0:playAssistBossSkill(slot6)

			return
		end
	end
end

function slot0.resetOp(slot0)
	slot0.preUsePower = 0
	slot0.useCardCount = 0
	slot0.preCostCd = 0
end

function slot0.canUseSkill(slot0)
	if slot0.roundUseLimit ~= 0 then
		return slot0.useCardCount < slot0.roundUseLimit
	end

	return slot0.useCardCount < (lua_tower_const.configDict[115] and tonumber(slot1.value) or 20)
end

function slot0.getCurUseSkillInfo(slot0)
	slot1 = slot0:getAssistBossPower()

	for slot5 = #slot0.bossInfoList, 1, -1 do
		if slot0.bossInfoList[slot5].powerLow <= slot1 and slot0:getNeedPower(slot6) <= slot1 then
			return slot6
		end
	end
end

function slot0.getUseCardCount(slot0)
	return slot0.useCardCount
end

function slot0.getBossSkillInfoList(slot0)
	return slot0.bossInfoList
end

return slot0
