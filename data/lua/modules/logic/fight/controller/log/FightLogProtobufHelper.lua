module("modules.logic.fight.controller.log.FightLogProtobufHelper", package.seeall)

slot0 = _M

function slot0.getPrefix(slot0)
	return string.rep("\t", slot0)
end

function slot0.getMoListString(slot0, slot1, slot2, slot3, slot4)
	if not slot0 then
		return string.format("%s %s : nil", uv0.getPrefix(slot3 or 0), slot2)
	end

	if #slot0 == 0 then
		return string.format("%s %s : []", slot5, slot2)
	end

	slot10 = slot4
	slot11 = slot2

	uv0.addStack({
		string.format("%s %s : [", slot5, slot2)
	}, uv0.getPrefix(slot3 + 1), slot10, slot11)

	for slot10, slot11 in ipairs(slot0) do
		table.insert(slot6, slot1(slot11, slot3 + 1, slot10, uv0.getStack(slot4, slot2)))
	end

	table.insert(slot6, slot5 .. "]")

	return table.concat(slot6, "\n")
end

function slot0.buildClassNameByIndex(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		return slot0 .. "_" .. tostring(slot1)
	end

	return slot0
end

function slot0.getFightRoundString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("FightRound", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {}

	table.insert(slot5, string.format("%s %s {", slot3, slot4))

	slot1 = slot1 + 1
	slot6 = uv0.getPrefix(slot1)

	table.insert(slot5, string.format("%s actPoint : %s", slot6, slot0.actPoint))
	table.insert(slot5, string.format("%s isFinish : %s", slot6, slot0.isFinish))
	table.insert(slot5, string.format("%s moveNum : %s", slot6, slot0.moveNum))
	table.insert(slot5, string.format("%s power : %s", slot6, slot0.power))
	table.insert(slot5, uv0.getFightStepListString(slot0.fightStep, slot1, "fightStep", "FightRound"))
	table.insert(slot5, uv0.getFightStepListString(slot0.nextRoundBeginStep, slot1, "nextRoundBeginStep", "FightRound"))
	table.insert(slot5, uv0.getCardInfoListString(slot0.aiUseCards, slot1, "aiUseCards", "FightRound"))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getFightStepString(slot0, slot1, slot2, slot3)
	if not slot0 then
		return string.format("%s %s : nil", uv0.getPrefix(slot1 or 0), uv0.buildClassNameByIndex("FightStep", slot2))
	end

	slot6 = {}

	if FightHelper.needAddRoundStep(slot0) then
		slot7 = string.format("%s %s {", slot4, slot5) .. "会被添加为新的步骤"
	end

	table.insert(slot6, slot7)

	slot8 = uv0.getPrefix(slot1 + 1)

	uv0.addStack(slot6, slot8, slot3, slot5)
	table.insert(slot6, string.format("%s actType : %s %s", slot8, slot0.actType, uv0.getActTypeName(slot0.actType)))

	if slot0.actType == FightEnum.ActType.SKILL then
		table.insert(slot6, string.format("%s fromId : %s 技能发起者:%s", slot8, slot0.fromId, uv0.getEntityName(slot0.fromId)))
		table.insert(slot6, string.format("%s toId : %s 技能承受者:%s", slot8, slot0.toId, uv0.getEntityName(slot0.toId)))
		table.insert(slot6, string.format("%s actId : %s 技能名字:%s timeline : %s", slot8, slot0.actId, uv0.getSkillName(slot0.actId), uv0.getTimelineName(slot0.fromId, slot0.actId)))
	else
		table.insert(slot6, string.format("%s fromId : %s", slot8, slot0.fromId))
		table.insert(slot6, string.format("%s toId : %s", slot8, slot0.toId))
		table.insert(slot6, string.format("%s actId : %s", slot8, slot0.actId))
	end

	table.insert(slot6, string.format("%s cardIndex : %s", slot8, slot0.cardIndex))
	table.insert(slot6, string.format("%s supportHeroId : %s", slot8, slot0.supportHeroId))
	table.insert(slot6, uv0.getFightActEffectListString(slot0.actEffect, slot1, "actEffect", uv0.getStack(slot3, slot5)))
	table.insert(slot6, slot4 .. "}")

	return table.concat(slot6, "\n")
end

function slot0.getFightStepListString(slot0, slot1, slot2, slot3)
	return uv0.getMoListString(slot0, uv0.getFightStepString, slot2 or "stepMoList", slot1, slot3)
end

function slot0.getFightActEffectString(slot0, slot1, slot2, slot3)
	slot4 = uv0.getPrefix(slot1 or 0)
	slot5 = uv0.buildClassNameByIndex("ActEffect", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot4, slot5)
	end

	slot6 = {
		string.format("%s %s {", slot4, slot5)
	}
	slot7 = uv0.getPrefix(slot1 + 1)

	uv0.addStack(slot6, slot7, slot3, slot5)
	table.insert(slot6, string.format("%s targetId : %s 作用对象:%s", slot7, slot0.targetId, uv0.getEntityName(slot0.targetId)))
	table.insert(slot6, string.format("%s effectType : %s 效果类型:%s", slot7, slot0.effectType, FightLogHelper.getEffectTypeName(slot0.effectType)))
	table.insert(slot6, string.format("%s effectNum : %s", slot7, slot0.effectNum))
	table.insert(slot6, string.format("%s effectNum1 : %s", slot7, slot0.effectNum1))

	if slot0:HasField("buff") then
		table.insert(slot6, uv0.getFightBuffString(slot0.buff, slot1))
	end

	if slot0:HasField("entity") then
		table.insert(slot6, uv0.getEntityMoString(slot0.entity, slot1))
	end

	table.insert(slot6, string.format("%s configEffect : %s", slot7, slot0.configEffect))
	table.insert(slot6, string.format("%s buffActId : %s", slot7, slot0.buffActId))
	table.insert(slot6, string.format("%s reserveId : %s", slot7, slot0.reserveId))
	table.insert(slot6, string.format("%s reserveStr : %s", slot7, slot0.reserveStr))
	table.insert(slot6, string.format("%s teamType : %s", slot7, slot0.teamType))

	if slot0:HasField("cardInfo") then
		table.insert(slot6, uv0.getCardInfoString(slot0.cardInfo, slot1))
	end

	table.insert(slot6, uv0.getCardInfoListString(slot0.cardInfoList, slot1, "cardInfoList", uv0.getStack(slot3, slot5)))

	if slot0:HasField("fightStep") then
		table.insert(slot6, uv0.getFightStepString(slot0.fightStep, slot1, nil, slot3))
	end

	if slot0:HasField("assistBossInfo") then
		table.insert(slot6, uv0.getAssistBossInfoString(slot0.assistBossInfo, slot1))
	end

	table.insert(slot6, slot4 .. "}")

	return table.concat(slot6, "\n")
end

function slot0.getAssistBossInfoString(slot0, slot1, slot2)
	slot3 = FightLogHelper.getPrefix(slot1 or 0)
	slot4 = FightLogHelper.buildClassNameByIndex("AssistBossInfo", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot1 = slot1 + 1
	slot6 = FightLogHelper.getPrefix(slot1)

	table.insert(slot5, string.format("%s currCd : %s", slot6, slot0.currCd))
	table.insert(slot5, string.format("%s cdCfg : %s", slot6, slot0.cdCfg))
	table.insert(slot5, string.format("%s formId : %s", slot6, slot0.formId))
	table.insert(slot5, FightLogHelper.getFightAssistBossSkillListString(slot0.skills, slot1))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getAssistBossSkillInfoString(slot0, slot1, slot2)
	slot3 = FightLogHelper.getPrefix(slot1 or 0)
	slot4 = FightLogHelper.buildClassNameByIndex("AssistBossSkillInfo", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot6 = FightLogHelper.getPrefix(slot1 + 1)

	table.insert(slot5, string.format("%s skillId : %s", slot6, slot0.skillId))
	table.insert(slot5, string.format("%s needPower : %s", slot6, slot0.needPower))
	table.insert(slot5, string.format("%s powerLow : %s", slot6, slot0.powerLow))
	table.insert(slot5, string.format("%s powerHigh : %s", slot6, slot0.powerHigh))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getFightAssistBossSkillListString(slot0, slot1, slot2)
	return FightLogHelper.getMoListString(slot0, FightLogHelper.getAssistBossSkillInfoString, slot2 or "assistBossSkillInfoList", slot1)
end

function slot0.getFightActEffectListString(slot0, slot1, slot2, slot3)
	return uv0.getMoListString(slot0, uv0.getFightActEffectString, slot2 or "actEffectMoList", slot1, slot3)
end

function slot0.getFightBuffString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("BuffInfo", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot6 = uv0.getPrefix(slot1 + 1)

	table.insert(slot5, string.format("%s buffId : %s %s", slot6, slot0.buffId, lua_skill_buff.configDict[slot0.buffId] and slot7.name))
	table.insert(slot5, string.format("%s duration : %s", slot6, slot0.duration))
	table.insert(slot5, string.format("%s uid : %s", slot6, slot0.uid))
	table.insert(slot5, string.format("%s exInfo : %s", slot6, slot0.exInfo))
	table.insert(slot5, string.format("%s fromUid : %s", slot6, slot0.fromUid))
	table.insert(slot5, string.format("%s count : %s", slot6, slot0.count))
	table.insert(slot5, string.format("%s actCommonParams : %s", slot6, slot0.actCommonParams))
	table.insert(slot5, string.format("%s layer : %s", slot6, slot0.layer))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getFightBuffListString(slot0, slot1, slot2)
	return uv0.getMoListString(slot0, uv0.getFightBuffString, slot2 or "buffMoList", slot1)
end

function slot0.getEntityMoString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("FightEntityInfo", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot6 = uv0.getPrefix(slot1 + 1)

	table.insert(slot5, string.format("%s uid : %s", slot6, slot0.uid))
	table.insert(slot5, string.format("%s modelId : %s", slot6, slot0.modelId))
	table.insert(slot5, string.format("%s skin : %s", slot6, slot0.skin))
	table.insert(slot5, string.format("%s position : %s", slot6, slot0.position))
	table.insert(slot5, string.format("%s entityType : %s", slot6, slot0.entityType))
	table.insert(slot5, string.format("%s userId : %s", slot6, slot0.userId))
	table.insert(slot5, string.format("%s exPoint : %s", slot6, slot0.exPoint))
	table.insert(slot5, string.format("%s level : %s", slot6, slot0.level))
	table.insert(slot5, string.format("%s currentHp : %s", slot6, slot0.currentHp))

	if slot0.buffs then
		table.insert(slot5, uv0.getFightBuffListString(slot0.buffs, slot1, "buffs"))
	end

	table.insert(slot5, string.format("%s skillGroup1 : %s", slot6, slot0.skillGroup1))
	table.insert(slot5, string.format("%s skillGroup2 : %s", slot6, slot0.skillGroup2))
	table.insert(slot5, string.format("%s passiveSkill : %s", slot6, slot0.passiveSkill))
	table.insert(slot5, string.format("%s exSkill : %s", slot6, slot0.exSkill))
	table.insert(slot5, string.format("%s shieldValue : %s", slot6, slot0.shieldValue))
	table.insert(slot5, string.format("%s shieldValue : %s", slot6, slot0.shieldValue))

	if slot0.noEffectBuffs then
		table.insert(slot5, uv0.getFightBuffListString(slot0.noEffectBuffs, slot1, "noEffectBuffs"))
	end

	table.insert(slot5, string.format("%s expointMaxAdd : %s", slot6, slot0.expointMaxAdd))
	table.insert(slot5, string.format("%s buffHarmStatistic : %s", slot6, slot0.buffHarmStatistic))
	table.insert(slot5, string.format("%s equipUid : %s", slot6, slot0.equipUid))
	table.insert(slot5, string.format("%s exSkillLevel : %s", slot6, slot0.exSkillLevel))

	if slot0.noEffectBuffs then
		table.insert(slot5, uv0.getNormalTypeListString(slot0.act104EquipUids, "act104EquipUids", slot1))
	end

	table.insert(slot5, string.format("%s exSkillPointChange : %s", slot6, slot0.exSkillPointChange))
	table.insert(slot5, string.format("%s teamType : %s", slot6, slot0.teamType))
	table.insert(slot5, string.format("%s career : %s", slot6, slot0.career))
	table.insert(slot5, string.format("%s status : %s", slot6, slot0.status))
	table.insert(slot5, string.format("%s guard : %s", slot6, slot0.guard))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getFightEntityListString(slot0, slot1, slot2)
	return uv0.getMoListString(slot0, uv0.getEntityMoString, slot2 or "entityMoList", slot1)
end

function slot0.getCardInfoString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("FightCardInfoMO", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot1 = slot1 + 1
	slot6 = uv0.getPrefix(slot1)

	table.insert(slot5, string.format("%s uid : %s %s", slot6, slot0.uid, uv0.getEntityName(slot0.uid)))
	table.insert(slot5, string.format("%s skillId : %s %s", slot6, slot0.skillId, uv0.getSkillName(slot0.skillId)))
	table.insert(slot5, string.format("%s cardEffect : %s", slot6, slot0.cardEffect))
	table.insert(slot5, string.format("%s tempCard : %s", slot6, slot0.tempCard))
	table.insert(slot5, string.format("%s cardType : %s", slot6, slot0.cardType))
	table.insert(slot5, string.format("%s heroId : %s", slot6, slot0.heroId))
	table.insert(slot5, string.format("%s status : %s", slot6, slot0.status))
	table.insert(slot5, string.format("%s targetUid : %s %s", slot6, slot0.targetUid, uv0.getEntityName(slot0.targetUid)))
	table.insert(slot5, string.format("%s energy : %s", slot6, slot0.energy))
	table.insert(slot5, string.format("%s areaRedOrBlue : %s", slot6, slot0.areaRedOrBlue))
	table.insert(slot5, string.format("%s heatId : %s", slot6, slot0.heatId))
	table.insert(slot5, uv0.getEnchantListString(slot0.enchants, slot1, "enchants"))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getCardInfoListString(slot0, slot1, slot2, slot3)
	return uv0.getMoListString(slot0, uv0.getCardInfoString, slot2 or "cardInfoList", slot1, slot3)
end

function slot0.getCardInfoEnchantString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("CardEnchant", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot6 = uv0.getPrefix(slot1 + 1)

	table.insert(slot5, string.format("%s enchantId : %s", slot6, slot0.enchantId))
	table.insert(slot5, string.format("%s duration : %s", slot6, slot0.duration))
	table.insert(slot5, string.format("%s exInfo : %s", slot6, table.concat(slot0.exInfo, ",")))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getEnchantListString(slot0, slot1, slot2, slot3)
	return uv0.getMoListString(slot0, uv0.getCardInfoEnchantString, slot2 or "enchantList", slot1, slot3)
end

function slot0.getNormalTypeListString(slot0, slot1, slot2)
	return uv0.getMoListString(slot0, tostring, slot1, slot2)
end

slot0.ActTypeName = {
	[FightEnum.ActType.SKILL] = "技能",
	[FightEnum.ActType.BUFF] = "buff",
	[FightEnum.ActType.EFFECT] = "效果",
	[FightEnum.ActType.CHANGEHERO] = "换人",
	[FightEnum.ActType.CHANGEWAVE] = "换波次时机"
}

function slot0.getActTypeName(slot0)
	return slot0 and uv0.ActTypeName[slot0] or ""
end

function slot0.getEntityName(slot0)
	if slot0 == FightEntityScene.MySideId then
		return "维尔汀"
	elseif slot0 == FightEntityScene.EnemySideId then
		return "重塑之手"
	else
		if FightDataHelper.entityMgr:getById(slot0) then
			return slot1:getEntityName()
		end

		return ""
	end

	return ""
end

function slot0.getSkillName(slot0)
	return lua_skill.configDict[slot0] and slot1.name or ""
end

function slot0.getTimelineName(slot0, slot1)
	slot2 = slot0 and FightDataHelper.entityMgr:getById(slot0)

	return string.nilorempty(FightConfig.instance:getSkinSkillTimeline(slot2 and slot2.skin, slot1)) and "nil" or slot3
end

function slot0.getStack(slot0, slot1)
	return slot0 and string.format("%s.%s", slot0, slot1) or slot1
end

function slot0.addStack(slot0, slot1, slot2, slot3)
	if string.nilorempty(uv0.getStack(slot2, slot3)) then
		return
	end

	table.insert(slot0, string.format("%s stack : %s", slot1, slot2))
end

return slot0
