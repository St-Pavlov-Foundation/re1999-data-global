module("modules.logic.fight.controller.log.FightLogProtobufHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getPrefix(arg_1_0)
	return string.rep("\t", arg_1_0)
end

function var_0_0.getMoListString(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_3 = arg_2_3 or 0

	local var_2_0 = var_0_0.getPrefix(arg_2_3)

	if not arg_2_0 then
		return string.format("%s %s : nil", var_2_0, arg_2_2)
	end

	if #arg_2_0 == 0 then
		return string.format("%s %s : []", var_2_0, arg_2_2)
	end

	local var_2_1 = {
		string.format("%s %s : [", var_2_0, arg_2_2)
	}

	var_0_0.addStack(var_2_1, var_0_0.getPrefix(arg_2_3 + 1), arg_2_4, arg_2_2)

	arg_2_4 = var_0_0.getStack(arg_2_4, arg_2_2)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		table.insert(var_2_1, arg_2_1(iter_2_1, arg_2_3 + 1, iter_2_0, arg_2_4))
	end

	table.insert(var_2_1, var_2_0 .. "]")

	return table.concat(var_2_1, "\n")
end

function var_0_0.buildClassNameByIndex(arg_3_0, arg_3_1)
	if arg_3_1 and arg_3_1 ~= 0 then
		return arg_3_0 .. "_" .. tostring(arg_3_1)
	end

	return arg_3_0
end

function var_0_0.getFightRoundString(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1 = arg_4_1 or 0

	local var_4_0 = var_0_0.getPrefix(arg_4_1)
	local var_4_1 = var_0_0.buildClassNameByIndex("FightRound", arg_4_2)

	if not arg_4_0 then
		return string.format("%s %s : nil", var_4_0, var_4_1)
	end

	local var_4_2 = {}

	table.insert(var_4_2, string.format("%s %s {", var_4_0, var_4_1))

	arg_4_1 = arg_4_1 + 1

	local var_4_3 = var_0_0.getPrefix(arg_4_1)

	table.insert(var_4_2, string.format("%s actPoint : %s", var_4_3, arg_4_0.actPoint))
	table.insert(var_4_2, string.format("%s isFinish : %s", var_4_3, arg_4_0.isFinish))
	table.insert(var_4_2, string.format("%s moveNum : %s", var_4_3, arg_4_0.moveNum))
	table.insert(var_4_2, string.format("%s power : %s", var_4_3, arg_4_0.power))
	table.insert(var_4_2, var_0_0.getFightStepListString(arg_4_0.fightStep, arg_4_1, "fightStep", "FightRound"))
	table.insert(var_4_2, var_0_0.getFightStepListString(arg_4_0.nextRoundBeginStep, arg_4_1, "nextRoundBeginStep", "FightRound"))
	table.insert(var_4_2, var_0_0.getCardInfoListString(arg_4_0.aiUseCards, arg_4_1, "aiUseCards", "FightRound"))
	table.insert(var_4_2, var_4_0 .. "}")

	return table.concat(var_4_2, "\n")
end

function var_0_0.getFightStepString(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_1 = arg_5_1 or 0

	local var_5_0 = var_0_0.getPrefix(arg_5_1)
	local var_5_1 = var_0_0.buildClassNameByIndex("FightStep", arg_5_2)

	if not arg_5_0 then
		return string.format("%s %s : nil", var_5_0, var_5_1)
	end

	local var_5_2 = {}
	local var_5_3 = string.format("%s %s {", var_5_0, var_5_1)

	if FightHelper.needAddRoundStep(arg_5_0) then
		var_5_3 = var_5_3 .. "会被添加为新的步骤"
	end

	table.insert(var_5_2, var_5_3)

	arg_5_1 = arg_5_1 + 1

	local var_5_4 = var_0_0.getPrefix(arg_5_1)

	var_0_0.addStack(var_5_2, var_5_4, arg_5_3, var_5_1)
	table.insert(var_5_2, string.format("%s actType : %s %s", var_5_4, arg_5_0.actType, var_0_0.getActTypeName(arg_5_0.actType)))

	if arg_5_0.actType == FightEnum.ActType.SKILL then
		table.insert(var_5_2, string.format("%s fromId : %s 技能发起者:%s", var_5_4, arg_5_0.fromId, var_0_0.getEntityName(arg_5_0.fromId)))
		table.insert(var_5_2, string.format("%s toId : %s 技能承受者:%s", var_5_4, arg_5_0.toId, var_0_0.getEntityName(arg_5_0.toId)))
		table.insert(var_5_2, string.format("%s actId : %s 技能名字:%s timeline : %s", var_5_4, arg_5_0.actId, var_0_0.getSkillName(arg_5_0.actId), var_0_0.getTimelineName(arg_5_0.fromId, arg_5_0.actId)))
	else
		table.insert(var_5_2, string.format("%s fromId : %s", var_5_4, arg_5_0.fromId))
		table.insert(var_5_2, string.format("%s toId : %s", var_5_4, arg_5_0.toId))
		table.insert(var_5_2, string.format("%s actId : %s", var_5_4, arg_5_0.actId))
	end

	table.insert(var_5_2, string.format("%s cardIndex : %s", var_5_4, arg_5_0.cardIndex))
	table.insert(var_5_2, string.format("%s supportHeroId : %s", var_5_4, arg_5_0.supportHeroId))
	table.insert(var_5_2, string.format("%s fakeTimeline : %s", var_5_4, arg_5_0.fakeTimeline))

	arg_5_3 = var_0_0.getStack(arg_5_3, var_5_1)

	table.insert(var_5_2, var_0_0.getFightActEffectListString(arg_5_0.actEffect, arg_5_1, "actEffect", arg_5_3))
	table.insert(var_5_2, var_5_0 .. "}")

	return table.concat(var_5_2, "\n")
end

function var_0_0.getFightStepListString(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_2 = arg_6_2 or "fightStepDataList"

	return var_0_0.getMoListString(arg_6_0, var_0_0.getFightStepString, arg_6_2, arg_6_1, arg_6_3)
end

function var_0_0.getFightActEffectString(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_1 = arg_7_1 or 0

	local var_7_0 = var_0_0.getPrefix(arg_7_1)
	local var_7_1 = var_0_0.buildClassNameByIndex("ActEffect", arg_7_2)

	if not arg_7_0 then
		return string.format("%s %s : nil", var_7_0, var_7_1)
	end

	local var_7_2 = {
		string.format("%s %s {", var_7_0, var_7_1)
	}

	arg_7_1 = arg_7_1 + 1

	local var_7_3 = var_0_0.getPrefix(arg_7_1)

	var_0_0.addStack(var_7_2, var_7_3, arg_7_3, var_7_1)
	table.insert(var_7_2, string.format("%s targetId : %s 作用对象:%s", var_7_3, arg_7_0.targetId, var_0_0.getEntityName(arg_7_0.targetId)))
	table.insert(var_7_2, string.format("%s effectType : %s 效果类型:%s", var_7_3, arg_7_0.effectType, FightLogHelper.getEffectTypeName(arg_7_0.effectType)))
	table.insert(var_7_2, string.format("%s effectNum : %s", var_7_3, arg_7_0.effectNum))
	table.insert(var_7_2, string.format("%s effectNum1 : %s", var_7_3, arg_7_0.effectNum1))

	if arg_7_0.buff then
		table.insert(var_7_2, var_0_0.getFightBuffString(arg_7_0.buff, arg_7_1))
	end

	if arg_7_0.entity then
		table.insert(var_7_2, var_0_0.getEntityMoString(arg_7_0.entity, arg_7_1))
	end

	table.insert(var_7_2, string.format("%s configEffect : %s", var_7_3, arg_7_0.configEffect))
	table.insert(var_7_2, string.format("%s buffActId : %s", var_7_3, arg_7_0.buffActId))
	table.insert(var_7_2, string.format("%s reserveId : %s", var_7_3, arg_7_0.reserveId))
	table.insert(var_7_2, string.format("%s reserveStr : %s", var_7_3, arg_7_0.reserveStr))
	table.insert(var_7_2, string.format("%s teamType : %s", var_7_3, arg_7_0.teamType))

	if arg_7_0.cardInfo then
		table.insert(var_7_2, var_0_0.getCardInfoString(arg_7_0.cardInfo, arg_7_1))
	end

	arg_7_3 = var_0_0.getStack(arg_7_3, var_7_1)

	table.insert(var_7_2, var_0_0.getCardInfoListString(arg_7_0.cardInfoList, arg_7_1, "cardInfoList", arg_7_3))

	if arg_7_0.fightStep then
		table.insert(var_7_2, var_0_0.getFightStepString(arg_7_0.fightStep, arg_7_1, nil, arg_7_3))
	end

	if arg_7_0.assistBossInfo then
		table.insert(var_7_2, var_0_0.getAssistBossInfoString(arg_7_0.assistBossInfo, arg_7_1))
	end

	if arg_7_0.magicCircle then
		table.insert(var_7_2, var_0_0.getMagicCircleInfoString(arg_7_0.magicCircle, arg_7_1))
	end

	table.insert(var_7_2, var_7_0 .. "}")

	return table.concat(var_7_2, "\n")
end

function var_0_0.getMagicCircleInfoString(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or 0

	local var_8_0 = FightLogHelper.getPrefix(arg_8_1)
	local var_8_1 = FightLogHelper.buildClassNameByIndex("FightMagicCircleInfoData")

	if not arg_8_0 then
		return string.format("%s %s : nil", var_8_0, var_8_1)
	end

	local var_8_2 = {
		string.format("%s %s {", var_8_0, var_8_1)
	}

	arg_8_1 = arg_8_1 + 1

	local var_8_3 = FightLogHelper.getPrefix(arg_8_1)

	table.insert(var_8_2, string.format("%s magicCircleId : %s", var_8_3, arg_8_0.magicCircleId))
	table.insert(var_8_2, string.format("%s round : %s", var_8_3, arg_8_0.round))
	table.insert(var_8_2, string.format("%s createUid : %s %s", var_8_3, arg_8_0.createUid, var_0_0.getEntityName(arg_8_0.createUid)))
	table.insert(var_8_2, string.format("%s electricLevel : %s", var_8_3, arg_8_0.electricLevel))
	table.insert(var_8_2, string.format("%s electricProgress : %s", var_8_3, arg_8_0.electricProgress))
	table.insert(var_8_2, var_8_0 .. "}")

	return table.concat(var_8_2, "\n")
end

function var_0_0.getAssistBossInfoString(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1 = arg_9_1 or 0

	local var_9_0 = FightLogHelper.getPrefix(arg_9_1)
	local var_9_1 = FightLogHelper.buildClassNameByIndex("AssistBossInfo", arg_9_2)

	if not arg_9_0 then
		return string.format("%s %s : nil", var_9_0, var_9_1)
	end

	local var_9_2 = {
		string.format("%s %s {", var_9_0, var_9_1)
	}

	arg_9_1 = arg_9_1 + 1

	local var_9_3 = FightLogHelper.getPrefix(arg_9_1)

	table.insert(var_9_2, string.format("%s currCd : %s", var_9_3, arg_9_0.currCd))
	table.insert(var_9_2, string.format("%s cdCfg : %s", var_9_3, arg_9_0.cdCfg))
	table.insert(var_9_2, string.format("%s formId : %s", var_9_3, arg_9_0.formId))
	table.insert(var_9_2, FightLogHelper.getFightAssistBossSkillListString(arg_9_0.skills, arg_9_1))
	table.insert(var_9_2, var_9_0 .. "}")

	return table.concat(var_9_2, "\n")
end

function var_0_0.getAssistBossSkillInfoString(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or 0

	local var_10_0 = FightLogHelper.getPrefix(arg_10_1)
	local var_10_1 = FightLogHelper.buildClassNameByIndex("AssistBossSkillInfo", arg_10_2)

	if not arg_10_0 then
		return string.format("%s %s : nil", var_10_0, var_10_1)
	end

	local var_10_2 = {
		string.format("%s %s {", var_10_0, var_10_1)
	}

	arg_10_1 = arg_10_1 + 1

	local var_10_3 = FightLogHelper.getPrefix(arg_10_1)

	table.insert(var_10_2, string.format("%s skillId : %s", var_10_3, arg_10_0.skillId))
	table.insert(var_10_2, string.format("%s needPower : %s", var_10_3, arg_10_0.needPower))
	table.insert(var_10_2, string.format("%s powerLow : %s", var_10_3, arg_10_0.powerLow))
	table.insert(var_10_2, string.format("%s powerHigh : %s", var_10_3, arg_10_0.powerHigh))
	table.insert(var_10_2, var_10_0 .. "}")

	return table.concat(var_10_2, "\n")
end

function var_0_0.getFightAssistBossSkillListString(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or "assistBossSkillInfoList"

	return FightLogHelper.getMoListString(arg_11_0, FightLogHelper.getAssistBossSkillInfoString, arg_11_2, arg_11_1)
end

function var_0_0.getFightActEffectListString(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_2 = arg_12_2 or "effectDataList"

	return var_0_0.getMoListString(arg_12_0, var_0_0.getFightActEffectString, arg_12_2, arg_12_1, arg_12_3)
end

function var_0_0.getFightBuffString(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1 = arg_13_1 or 0

	local var_13_0 = var_0_0.getPrefix(arg_13_1)
	local var_13_1 = var_0_0.buildClassNameByIndex("BuffInfo", arg_13_2)

	if not arg_13_0 then
		return string.format("%s %s : nil", var_13_0, var_13_1)
	end

	local var_13_2 = {
		string.format("%s %s {", var_13_0, var_13_1)
	}

	arg_13_1 = arg_13_1 + 1

	local var_13_3 = var_0_0.getPrefix(arg_13_1)
	local var_13_4 = lua_skill_buff.configDict[arg_13_0.buffId]
	local var_13_5 = var_13_4 and var_13_4.name

	table.insert(var_13_2, string.format("%s buffId : %s %s", var_13_3, arg_13_0.buffId, var_13_5))
	table.insert(var_13_2, string.format("%s duration : %s", var_13_3, arg_13_0.duration))
	table.insert(var_13_2, string.format("%s uid : %s", var_13_3, arg_13_0.uid))
	table.insert(var_13_2, string.format("%s exInfo : %s", var_13_3, arg_13_0.exInfo))
	table.insert(var_13_2, string.format("%s fromUid : %s", var_13_3, arg_13_0.fromUid))
	table.insert(var_13_2, string.format("%s count : %s", var_13_3, arg_13_0.count))
	table.insert(var_13_2, string.format("%s actCommonParams : %s", var_13_3, arg_13_0.actCommonParams))
	table.insert(var_13_2, string.format("%s layer : %s", var_13_3, arg_13_0.layer))
	table.insert(var_13_2, var_13_0 .. "}")

	return table.concat(var_13_2, "\n")
end

function var_0_0.getFightBuffListString(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or "buffMoList"

	return var_0_0.getMoListString(arg_14_0, var_0_0.getFightBuffString, arg_14_2, arg_14_1)
end

function var_0_0.getEntityMoString(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1 = arg_15_1 or 0

	local var_15_0 = var_0_0.getPrefix(arg_15_1)
	local var_15_1 = var_0_0.buildClassNameByIndex("FightEntityInfo", arg_15_2)

	if not arg_15_0 then
		return string.format("%s %s : nil", var_15_0, var_15_1)
	end

	local var_15_2 = {
		string.format("%s %s {", var_15_0, var_15_1)
	}

	arg_15_1 = arg_15_1 + 1

	local var_15_3 = var_0_0.getPrefix(arg_15_1)

	table.insert(var_15_2, string.format("%s uid : %s", var_15_3, arg_15_0.uid))
	table.insert(var_15_2, string.format("%s modelId : %s", var_15_3, arg_15_0.modelId))
	table.insert(var_15_2, string.format("%s skin : %s", var_15_3, arg_15_0.skin))
	table.insert(var_15_2, string.format("%s position : %s", var_15_3, arg_15_0.position))
	table.insert(var_15_2, string.format("%s entityType : %s", var_15_3, arg_15_0.entityType))
	table.insert(var_15_2, string.format("%s userId : %s", var_15_3, arg_15_0.userId))
	table.insert(var_15_2, string.format("%s exPoint : %s", var_15_3, arg_15_0.exPoint))
	table.insert(var_15_2, string.format("%s level : %s", var_15_3, arg_15_0.level))
	table.insert(var_15_2, string.format("%s currentHp : %s", var_15_3, arg_15_0.currentHp))

	if arg_15_0.buffs then
		table.insert(var_15_2, var_0_0.getFightBuffListString(arg_15_0.buffs, arg_15_1, "buffs"))
	end

	table.insert(var_15_2, string.format("%s skillGroup1 : %s", var_15_3, arg_15_0.skillGroup1))
	table.insert(var_15_2, string.format("%s skillGroup2 : %s", var_15_3, arg_15_0.skillGroup2))
	table.insert(var_15_2, string.format("%s passiveSkill : %s", var_15_3, arg_15_0.passiveSkill))
	table.insert(var_15_2, string.format("%s exSkill : %s", var_15_3, arg_15_0.exSkill))
	table.insert(var_15_2, string.format("%s shieldValue : %s", var_15_3, arg_15_0.shieldValue))
	table.insert(var_15_2, string.format("%s shieldValue : %s", var_15_3, arg_15_0.shieldValue))

	if arg_15_0.noEffectBuffs then
		table.insert(var_15_2, var_0_0.getFightBuffListString(arg_15_0.noEffectBuffs, arg_15_1, "noEffectBuffs"))
	end

	table.insert(var_15_2, string.format("%s expointMaxAdd : %s", var_15_3, arg_15_0.expointMaxAdd))
	table.insert(var_15_2, string.format("%s buffHarmStatistic : %s", var_15_3, arg_15_0.buffHarmStatistic))
	table.insert(var_15_2, string.format("%s equipUid : %s", var_15_3, arg_15_0.equipUid))
	table.insert(var_15_2, string.format("%s exSkillLevel : %s", var_15_3, arg_15_0.exSkillLevel))

	if arg_15_0.noEffectBuffs then
		table.insert(var_15_2, var_0_0.getNormalTypeListString(arg_15_0.act104EquipUids, "act104EquipUids", arg_15_1))
	end

	table.insert(var_15_2, string.format("%s exSkillPointChange : %s", var_15_3, arg_15_0.exSkillPointChange))
	table.insert(var_15_2, string.format("%s teamType : %s", var_15_3, arg_15_0.teamType))
	table.insert(var_15_2, string.format("%s career : %s", var_15_3, arg_15_0.career))
	table.insert(var_15_2, string.format("%s status : %s", var_15_3, arg_15_0.status))
	table.insert(var_15_2, string.format("%s guard : %s", var_15_3, arg_15_0.guard))
	table.insert(var_15_2, var_15_0 .. "}")

	return table.concat(var_15_2, "\n")
end

function var_0_0.getFightEntityListString(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or "entityMoList"

	return var_0_0.getMoListString(arg_16_0, var_0_0.getEntityMoString, arg_16_2, arg_16_1)
end

function var_0_0.getCardInfoString(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1 = arg_17_1 or 0

	local var_17_0 = var_0_0.getPrefix(arg_17_1)
	local var_17_1 = var_0_0.buildClassNameByIndex("FightCardInfoMO", arg_17_2)

	if not arg_17_0 then
		return string.format("%s %s : nil", var_17_0, var_17_1)
	end

	local var_17_2 = {
		string.format("%s %s {", var_17_0, var_17_1)
	}

	arg_17_1 = arg_17_1 + 1

	local var_17_3 = var_0_0.getPrefix(arg_17_1)

	table.insert(var_17_2, string.format("%s uid : %s %s", var_17_3, arg_17_0.uid, var_0_0.getEntityName(arg_17_0.uid)))
	table.insert(var_17_2, string.format("%s skillId : %s %s", var_17_3, arg_17_0.skillId, var_0_0.getSkillName(arg_17_0.skillId)))
	table.insert(var_17_2, string.format("%s cardEffect : %s", var_17_3, arg_17_0.cardEffect))
	table.insert(var_17_2, string.format("%s tempCard : %s", var_17_3, arg_17_0.tempCard))
	table.insert(var_17_2, string.format("%s cardType : %s", var_17_3, arg_17_0.cardType))
	table.insert(var_17_2, string.format("%s heroId : %s", var_17_3, arg_17_0.heroId))
	table.insert(var_17_2, string.format("%s status : %s", var_17_3, arg_17_0.status))
	table.insert(var_17_2, string.format("%s targetUid : %s %s", var_17_3, arg_17_0.targetUid, var_0_0.getEntityName(arg_17_0.targetUid)))
	table.insert(var_17_2, string.format("%s energy : %s", var_17_3, arg_17_0.energy))
	table.insert(var_17_2, string.format("%s areaRedOrBlue : %s", var_17_3, arg_17_0.areaRedOrBlue))
	table.insert(var_17_2, string.format("%s heatId : %s", var_17_3, arg_17_0.heatId))
	table.insert(var_17_2, var_0_0.getEnchantListString(arg_17_0.enchants, arg_17_1, "enchants"))
	table.insert(var_17_2, var_17_0 .. "}")

	return table.concat(var_17_2, "\n")
end

function var_0_0.getCardInfoListString(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_2 = arg_18_2 or "cardInfoList"

	return var_0_0.getMoListString(arg_18_0, var_0_0.getCardInfoString, arg_18_2, arg_18_1, arg_18_3)
end

function var_0_0.getCardInfoEnchantString(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or 0

	local var_19_0 = var_0_0.getPrefix(arg_19_1)
	local var_19_1 = var_0_0.buildClassNameByIndex("CardEnchant", arg_19_2)

	if not arg_19_0 then
		return string.format("%s %s : nil", var_19_0, var_19_1)
	end

	local var_19_2 = {
		string.format("%s %s {", var_19_0, var_19_1)
	}

	arg_19_1 = arg_19_1 + 1

	local var_19_3 = var_0_0.getPrefix(arg_19_1)

	table.insert(var_19_2, string.format("%s enchantId : %s", var_19_3, arg_19_0.enchantId))
	table.insert(var_19_2, string.format("%s duration : %s", var_19_3, arg_19_0.duration))
	table.insert(var_19_2, string.format("%s exInfo : %s", var_19_3, table.concat(arg_19_0.exInfo, ",")))
	table.insert(var_19_2, var_19_0 .. "}")

	return table.concat(var_19_2, "\n")
end

function var_0_0.getEnchantListString(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_2 = arg_20_2 or "enchantList"

	return var_0_0.getMoListString(arg_20_0, var_0_0.getCardInfoEnchantString, arg_20_2, arg_20_1, arg_20_3)
end

function var_0_0.getNormalTypeListString(arg_21_0, arg_21_1, arg_21_2)
	return var_0_0.getMoListString(arg_21_0, tostring, arg_21_1, arg_21_2)
end

var_0_0.ActTypeName = {
	[FightEnum.ActType.SKILL] = "技能",
	[FightEnum.ActType.BUFF] = "buff",
	[FightEnum.ActType.EFFECT] = "效果",
	[FightEnum.ActType.CHANGEHERO] = "换人",
	[FightEnum.ActType.CHANGEWAVE] = "换波次时机"
}

function var_0_0.getActTypeName(arg_22_0)
	return arg_22_0 and var_0_0.ActTypeName[arg_22_0] or ""
end

function var_0_0.getEntityName(arg_23_0)
	if arg_23_0 == FightEntityScene.MySideId then
		return "维尔汀"
	elseif arg_23_0 == FightEntityScene.EnemySideId then
		return "重塑之手"
	else
		local var_23_0 = FightDataHelper.entityMgr:getById(arg_23_0)

		if var_23_0 then
			return var_23_0:getEntityName()
		end

		return ""
	end

	return ""
end

function var_0_0.getSkillName(arg_24_0)
	local var_24_0 = lua_skill.configDict[arg_24_0]

	return var_24_0 and var_24_0.name or ""
end

function var_0_0.getTimelineName(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0 and FightDataHelper.entityMgr:getById(arg_25_0)
	local var_25_1 = FightConfig.instance:getSkinSkillTimeline(var_25_0 and var_25_0.skin, arg_25_1)

	return string.nilorempty(var_25_1) and "nil" or var_25_1
end

function var_0_0.getStack(arg_26_0, arg_26_1)
	return arg_26_0 and string.format("%s.%s", arg_26_0, arg_26_1) or arg_26_1
end

function var_0_0.addStack(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_2 = var_0_0.getStack(arg_27_2, arg_27_3)

	if string.nilorempty(arg_27_2) then
		return
	end

	table.insert(arg_27_0, string.format("%s stack : %s", arg_27_1, arg_27_2))
end

return var_0_0
