module("modules.logic.fight.controller.log.FightLogHelper", package.seeall)

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

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		table.insert(var_2_1, arg_2_1(iter_2_1, arg_2_3 + 1, iter_2_0))
	end

	table.insert(var_2_1, var_2_0 .. "]")

	return table.concat(var_2_1, "\n")
end

function var_0_0.getMoDictString(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_3 = arg_3_3 or 0

	local var_3_0 = var_0_0.getPrefix(arg_3_3)

	if not arg_3_0 then
		return string.format("%s %s : nil", var_3_0, arg_3_2)
	end

	if GameUtil.tabletool_dictIsEmpty(arg_3_0) then
		return string.format("%s %s : []", var_3_0, arg_3_2)
	end

	local var_3_1 = {
		string.format("%s %s : [", var_3_0, arg_3_2)
	}

	var_0_0.addStack(var_3_1, var_0_0.getPrefix(arg_3_3 + 1), arg_3_4, arg_3_2)

	arg_3_4 = var_0_0.getStack(arg_3_4, arg_3_2)

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		table.insert(var_3_1, arg_3_1(iter_3_1, arg_3_3 + 1, tostring(iter_3_0), arg_3_4))
	end

	table.insert(var_3_1, var_3_0 .. "]")

	return table.concat(var_3_1, "\n")
end

function var_0_0.buildClassNameByIndex(arg_4_0, arg_4_1)
	if arg_4_1 and arg_4_1 ~= 0 then
		return arg_4_0 .. "_" .. tostring(arg_4_1)
	end

	return arg_4_0
end

function var_0_0.getFightRoundString(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1 = arg_5_1 or 0

	local var_5_0 = var_0_0.getPrefix(arg_5_1)
	local var_5_1 = var_0_0.buildClassNameByIndex("FightRoundData", arg_5_2)

	if not arg_5_0 then
		return string.format("%s %s : nil", var_5_0, var_5_1)
	end

	local var_5_2 = {}

	table.insert(var_5_2, string.format("%s %s {", var_5_0, var_5_1))

	arg_5_1 = arg_5_1 + 1

	local var_5_3 = var_0_0.getPrefix(arg_5_1)

	table.insert(var_5_2, string.format("%s actPoint : %s", var_5_3, arg_5_0.actPoint))
	table.insert(var_5_2, string.format("%s isFinish : %s", var_5_3, arg_5_0.isFinish))
	table.insert(var_5_2, string.format("%s moveNum : %s", var_5_3, arg_5_0.moveNum))
	table.insert(var_5_2, string.format("%s power : %s", var_5_3, arg_5_0.power))
	table.insert(var_5_2, var_0_0.getFightStepListString(arg_5_0.fightStep, arg_5_1, "fightStep", "FightRound"))
	table.insert(var_5_2, var_0_0.getFightStepListString(arg_5_0.nextRoundBeginStep, arg_5_1, "nextRoundBeginStep", "FightRound"))
	table.insert(var_5_2, var_5_0 .. "}")

	return table.concat(var_5_2, "\n")
end

function var_0_0.getFightStepString(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = arg_6_1 or 0

	local var_6_0 = var_0_0.getPrefix(arg_6_1)
	local var_6_1 = var_0_0.buildClassNameByIndex("FightStepData", arg_6_2)

	if not arg_6_0 then
		return string.format("%s %s : nil", var_6_0, var_6_1)
	end

	local var_6_2 = {}
	local var_6_3 = string.format("%s %s {", var_6_0, var_6_1)

	table.insert(var_6_2, var_6_3)

	arg_6_1 = arg_6_1 + 1

	local var_6_4 = var_0_0.getPrefix(arg_6_1)

	table.insert(var_6_2, string.format("%s actType : %s %s", var_6_4, arg_6_0.actType, var_0_0.getActTypeName(arg_6_0.actType)))

	if arg_6_0.actType == FightEnum.ActType.SKILL then
		table.insert(var_6_2, string.format("%s fromId : %s 技能发起者:%s", var_6_4, arg_6_0.fromId, var_0_0.getEntityName(arg_6_0.fromId)))
		table.insert(var_6_2, string.format("%s toId : %s 技能承受者:%s", var_6_4, arg_6_0.toId, var_0_0.getEntityName(arg_6_0.toId)))
		table.insert(var_6_2, string.format("%s actId : %s 技能名字:%s timeline : %s", var_6_4, arg_6_0.actId, var_0_0.getSkillName(arg_6_0.actId), var_0_0.getTimelineName(arg_6_0.fromId, arg_6_0.actId)))
	else
		table.insert(var_6_2, string.format("%s fromId : %s", var_6_4, arg_6_0.fromId))
		table.insert(var_6_2, string.format("%s toId : %s", var_6_4, arg_6_0.toId))
		table.insert(var_6_2, string.format("%s actId : %s", var_6_4, arg_6_0.actId))
	end

	table.insert(var_6_2, string.format("%s cardIndex : %s", var_6_4, arg_6_0.cardIndex))
	table.insert(var_6_2, string.format("%s supportHeroId : %s", var_6_4, arg_6_0.supportHeroId))
	table.insert(var_6_2, string.format("%s fakeTimeline : %s", var_6_4, arg_6_0.fakeTimeline))
	table.insert(var_6_2, var_0_0.getFightActEffectListString(arg_6_0.actEffect, arg_6_1, "actEffect"))
	table.insert(var_6_2, var_6_0 .. "}")

	return table.concat(var_6_2, "\n")
end

function var_0_0.getFightStepListString(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_2 = arg_7_2 or "fightStepDataList"

	return var_0_0.getMoListString(arg_7_0, var_0_0.getFightStepString, arg_7_2, arg_7_1, arg_7_3)
end

function var_0_0.getFightActEffectString(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if FightLogFilterHelper.checkActEffectDataIsFilter(arg_8_0) then
		return ""
	end

	arg_8_1 = arg_8_1 or 0

	local var_8_0 = var_0_0.getPrefix(arg_8_1)
	local var_8_1 = var_0_0.buildClassNameByIndex("ActEffectData", arg_8_2)

	if not arg_8_0 then
		return string.format("%s %s : nil", var_8_0, var_8_1)
	end

	local var_8_2 = {
		string.format("%s %s {", var_8_0, var_8_1)
	}

	arg_8_1 = arg_8_1 + 1

	local var_8_3 = var_0_0.getPrefix(arg_8_1)

	var_0_0.addStack(var_8_2, var_8_3, arg_8_3, var_8_1)
	table.insert(var_8_2, string.format("%s targetId : %s 作用对象:%s", var_8_3, arg_8_0.targetId, var_0_0.getEntityName(arg_8_0.targetId)))
	table.insert(var_8_2, string.format("%s effectType : %s 效果类型:%s", var_8_3, arg_8_0.effectType, var_0_0.getEffectTypeName(arg_8_0.effectType)))
	table.insert(var_8_2, string.format("%s effectNum : %s", var_8_3, arg_8_0.effectNum))
	table.insert(var_8_2, string.format("%s effectNum1 : %s", var_8_3, arg_8_0.effectNum1))
	table.insert(var_8_2, string.format("%s fromSide : %s", var_8_3, arg_8_0.fromSide))
	table.insert(var_8_2, string.format("%s configEffect : %s", var_8_3, arg_8_0.configEffect))
	table.insert(var_8_2, string.format("%s buffActId : %s", var_8_3, arg_8_0.buffActId))
	table.insert(var_8_2, string.format("%s reserveId : %s", var_8_3, arg_8_0.reserveId))
	table.insert(var_8_2, string.format("%s reserveStr : %s", var_8_3, arg_8_0.reserveStr))
	table.insert(var_8_2, string.format("%s teamType : %s", var_8_3, arg_8_0.teamType))
	table.insert(var_8_2, string.format("%s cardHeatValue : %s", var_8_3, arg_8_0.cardHeatValue))
	table.insert(var_8_2, var_0_0.getAssistBossInfoString(arg_8_0.assistBossInfo, arg_8_1))

	arg_8_3 = FightLogProtobufHelper.getStack(arg_8_3, var_8_1)

	table.insert(var_8_2, var_0_0.getCardInfoListString(arg_8_0.cardInfoList, arg_8_1, arg_8_3))

	if arg_8_0.cardInfo then
		table.insert(var_8_2, var_0_0.getCardInfoString(arg_8_0.cardInfo, arg_8_1))
	end

	if arg_8_0.fightStep then
		table.insert(var_8_2, var_0_0.getFightStepString(arg_8_0.fightStep, arg_8_1))
	end

	if arg_8_0.buff then
		table.insert(var_8_2, var_0_0.getFightBuffString(arg_8_0.buff, arg_8_1))
	end

	if arg_8_0.entity then
		table.insert(var_8_2, var_0_0.getEntityMoString(arg_8_0.entity, arg_8_1))
	end

	if arg_8_0.magicCircle then
		table.insert(var_8_2, var_0_0.getMagicCircleDataString(arg_8_0.magicCircle, arg_8_1))
	end

	table.insert(var_8_2, var_8_0 .. "}")

	return table.concat(var_8_2, "\n")
end

function var_0_0.getMagicCircleDataString(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1 = arg_9_1 or 0

	local var_9_0 = var_0_0.getPrefix(arg_9_1)
	local var_9_1 = var_0_0.buildClassNameByIndex("MagicCircle", arg_9_2)

	if not arg_9_0 then
		return string.format("%s %s : nil", var_9_0, var_9_1)
	end

	local var_9_2 = {
		string.format("%s %s {", var_9_0, var_9_1)
	}

	arg_9_1 = arg_9_1 + 1

	local var_9_3 = var_0_0.getPrefix(arg_9_1)
	local var_9_4 = lua_magic_circle.configDict[arg_9_0.magicCircleId]

	table.insert(var_9_2, string.format("%s createUid : %s, 创建者: %s", var_9_3, arg_9_0.createUid, var_0_0.getEntityName(arg_9_0.createUid)))
	table.insert(var_9_2, string.format("%s magicCircleId : %s %s", var_9_3, arg_9_0.magicCircleId, var_9_4 and var_9_4.name))
	table.insert(var_9_2, string.format("%s round : %s", var_9_3, arg_9_0.round))
	table.insert(var_9_2, string.format("%s electricLevel : %s", var_9_3, arg_9_0.electricLevel))
	table.insert(var_9_2, string.format("%s electricProgress : %s", var_9_3, arg_9_0.electricProgress))
	table.insert(var_9_2, var_9_0 .. "}")

	return table.concat(var_9_2, "\n")
end

function var_0_0.getAssistBossInfoString(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or 0

	local var_10_0 = var_0_0.getPrefix(arg_10_1)
	local var_10_1 = var_0_0.buildClassNameByIndex("AssistBossInfo", arg_10_2)

	if not arg_10_0 then
		return string.format("%s %s : nil", var_10_0, var_10_1)
	end

	local var_10_2 = {
		string.format("%s %s {", var_10_0, var_10_1)
	}

	arg_10_1 = arg_10_1 + 1

	local var_10_3 = var_0_0.getPrefix(arg_10_1)

	table.insert(var_10_2, string.format("%s currCd : %s", var_10_3, arg_10_0.currCd))
	table.insert(var_10_2, string.format("%s cdCfg : %s", var_10_3, arg_10_0.cdCfg))
	table.insert(var_10_2, string.format("%s formId : %s", var_10_3, arg_10_0.formId))
	table.insert(var_10_2, var_0_0.getAssistBossSkillInfoString(arg_10_0.skills, arg_10_1))
	table.insert(var_10_2, var_10_0 .. "}")

	return table.concat(var_10_2, "\n")
end

function var_0_0.getAssistBossSkillInfoString(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1 = arg_11_1 or 0

	local var_11_0 = var_0_0.getPrefix(arg_11_1)
	local var_11_1 = var_0_0.buildClassNameByIndex("AssistBossSkillInfo", arg_11_2)

	if not arg_11_0 then
		return string.format("%s %s : nil", var_11_0, var_11_1)
	end

	local var_11_2 = {
		string.format("%s %s {", var_11_0, var_11_1)
	}

	arg_11_1 = arg_11_1 + 1

	local var_11_3 = var_0_0.getPrefix(arg_11_1)

	table.insert(var_11_2, string.format("%s skillId : %s", var_11_3, arg_11_0.skillId))
	table.insert(var_11_2, string.format("%s needPower : %s", var_11_3, arg_11_0.needPower))
	table.insert(var_11_2, string.format("%s powerLow : %s", var_11_3, arg_11_0.powerLow))
	table.insert(var_11_2, string.format("%s powerHigh : %s", var_11_3, arg_11_0.powerHigh))
	table.insert(var_11_2, var_11_0 .. "}")

	return table.concat(var_11_2, "\n")
end

function var_0_0.getFightAssistBossSkillListString(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or "assistBossSkillInfoList"

	return var_0_0.getMoListString(arg_12_0, var_0_0.getAssistBossSkillInfoString, arg_12_2, arg_12_1)
end

function var_0_0.getFightActEffectListString(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2 = arg_13_2 or "effectDataList"

	return var_0_0.getMoListString(arg_13_0, var_0_0.getFightActEffectString, arg_13_2, arg_13_1)
end

function var_0_0.getFightBuffString(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or 0

	local var_14_0 = var_0_0.getPrefix(arg_14_1)
	local var_14_1 = var_0_0.buildClassNameByIndex("FightBuffInfoData", arg_14_2)

	if not arg_14_0 then
		return string.format("%s %s : nil", var_14_0, var_14_1)
	end

	local var_14_2 = {
		string.format("%s %s {", var_14_0, var_14_1)
	}

	arg_14_1 = arg_14_1 + 1

	local var_14_3 = var_0_0.getPrefix(arg_14_1)

	table.insert(var_14_2, string.format("%s time : %s", var_14_3, arg_14_0.time))
	table.insert(var_14_2, string.format("%s entityId : %s %s", var_14_3, arg_14_0.entityId, var_0_0.getEntityName(arg_14_0.entityId)))
	table.insert(var_14_2, string.format("%s id : %s", var_14_3, arg_14_0.id))
	table.insert(var_14_2, string.format("%s uid : %s", var_14_3, arg_14_0.uid))
	table.insert(var_14_2, string.format("%s buffId : %s %s", var_14_3, arg_14_0.buffId, arg_14_0.name))
	table.insert(var_14_2, string.format("%s duration : %s", var_14_3, arg_14_0.duration))
	table.insert(var_14_2, string.format("%s exInfo : %s", var_14_3, arg_14_0.exInfo))
	table.insert(var_14_2, string.format("%s fromUid : %s", var_14_3, arg_14_0.fromUid))
	table.insert(var_14_2, string.format("%s count : %s", var_14_3, arg_14_0.count))
	table.insert(var_14_2, string.format("%s name : %s", var_14_3, arg_14_0.name))
	table.insert(var_14_2, string.format("%s actCommonParams : %s", var_14_3, arg_14_0.actCommonParams))
	table.insert(var_14_2, string.format("%s layer : %s", var_14_3, arg_14_0.layer))
	table.insert(var_14_2, var_14_0 .. "}")

	return table.concat(var_14_2, "\n")
end

function var_0_0.getFightBuffListString(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or "buffMoList"

	return var_0_0.getMoListString(arg_15_0, var_0_0.getFightBuffString, arg_15_2, arg_15_1)
end

function var_0_0.getFightBuffDictString(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or "buffMoDict"

	return var_0_0.getMoDictString(arg_16_0, var_0_0.getFightBuffString, arg_16_2, arg_16_1)
end

function var_0_0.getEntityMoString(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1 = arg_17_1 or 0

	local var_17_0 = var_0_0.getPrefix(arg_17_1)
	local var_17_1 = var_0_0.buildClassNameByIndex("FightEntityMO", arg_17_2)

	if not arg_17_0 then
		return string.format("%s %s : nil", var_17_0, var_17_1)
	end

	local var_17_2 = {
		string.format("%s %s {", var_17_0, var_17_1)
	}

	arg_17_1 = arg_17_1 + 1

	local var_17_3 = var_0_0.getPrefix(arg_17_1)

	table.insert(var_17_2, string.format("%s id : %s", var_17_3, arg_17_0.id))
	table.insert(var_17_2, string.format("%s uid : %s", var_17_3, arg_17_0.uid))
	table.insert(var_17_2, string.format("%s modelId : %s", var_17_3, arg_17_0.modelId))
	table.insert(var_17_2, string.format("%s skin : %s", var_17_3, arg_17_0.skin))
	table.insert(var_17_2, string.format("%s originSkin : %s", var_17_3, arg_17_0.originSkin))
	table.insert(var_17_2, string.format("%s position : %s", var_17_3, arg_17_0.position))
	table.insert(var_17_2, string.format("%s entityType : %s", var_17_3, arg_17_0.entityType))
	table.insert(var_17_2, string.format("%s userId : %s", var_17_3, arg_17_0.userId))
	table.insert(var_17_2, string.format("%s exPoint : %s", var_17_3, arg_17_0.exPoint))
	table.insert(var_17_2, string.format("%s level : %s", var_17_3, arg_17_0.level))
	table.insert(var_17_2, string.format("%s currentHp : %s", var_17_3, arg_17_0.currentHp))
	table.insert(var_17_2, string.format("%s equipUid : %s", var_17_3, arg_17_0.equipUid))
	table.insert(var_17_2, string.format("%s side : %s", var_17_3, arg_17_0.side))
	table.insert(var_17_2, string.format("%s career : %s", var_17_3, arg_17_0.career))
	table.insert(var_17_2, string.format("%s storedExPoint : %s", var_17_3, arg_17_0.storedExPoint))
	table.insert(var_17_2, var_17_0 .. "}")

	return table.concat(var_17_2, "\n")
end

function var_0_0.getFightEntityListString(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 or "entityMoList"

	return var_0_0.getMoListString(arg_18_0, var_0_0.getEntityMoString, arg_18_2, arg_18_1)
end

function var_0_0.getCardInfoString(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or 0

	local var_19_0 = var_0_0.getPrefix(arg_19_1)
	local var_19_1 = var_0_0.buildClassNameByIndex("FightCardInfoMO", arg_19_2)

	if not arg_19_0 then
		return string.format("%s %s : nil", var_19_0, var_19_1)
	end

	local var_19_2 = {
		string.format("%s %s {", var_19_0, var_19_1)
	}

	arg_19_1 = arg_19_1 + 1

	local var_19_3 = var_0_0.getPrefix(arg_19_1)

	table.insert(var_19_2, string.format("%s uid : %s %s", var_19_3, arg_19_0.uid, var_0_0.getEntityName(arg_19_0.uid)))
	table.insert(var_19_2, string.format("%s skillId : %s %s", var_19_3, arg_19_0.skillId, var_0_0.getSkillName(arg_19_0.skillId)))
	table.insert(var_19_2, string.format("%s cardEffect : %s", var_19_3, arg_19_0.cardEffect))
	table.insert(var_19_2, string.format("%s tempCard : %s", var_19_3, arg_19_0.tempCard))
	table.insert(var_19_2, string.format("%s cardType : %s", var_19_3, arg_19_0.cardType))
	table.insert(var_19_2, string.format("%s heroId : %s", var_19_3, arg_19_0.heroId))
	table.insert(var_19_2, string.format("%s status : %s", var_19_3, arg_19_0.status))
	table.insert(var_19_2, string.format("%s targetUid : %s %s", var_19_3, arg_19_0.targetUid, var_0_0.getEntityName(arg_19_0.targetUid)))
	table.insert(var_19_2, string.format("%s energy : %s", var_19_3, arg_19_0.energy))
	table.insert(var_19_2, string.format("%s areaRedOrBlue : %s", var_19_3, arg_19_0.areaRedOrBlue))
	table.insert(var_19_2, string.format("%s heatId : %s", var_19_3, arg_19_0.heatId))
	table.insert(var_19_2, var_0_0.getEnchantListString(arg_19_0.enchants, arg_19_1, "enchants"))
	table.insert(var_19_2, var_19_0 .. "}")

	return table.concat(var_19_2, "\n")
end

function var_0_0.getCardInfoListString(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_2 = arg_20_2 or "cardInfoList"

	return var_0_0.getMoListString(arg_20_0, var_0_0.getCardInfoString, arg_20_2, arg_20_1, arg_20_3)
end

function var_0_0.getCardInfoEnchantString(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 or 0

	local var_21_0 = var_0_0.getPrefix(arg_21_1)
	local var_21_1 = var_0_0.buildClassNameByIndex("CardEnchant", arg_21_2)

	if not arg_21_0 then
		return string.format("%s %s : nil", var_21_0, var_21_1)
	end

	local var_21_2 = {
		string.format("%s %s {", var_21_0, var_21_1)
	}

	arg_21_1 = arg_21_1 + 1

	local var_21_3 = var_0_0.getPrefix(arg_21_1)

	table.insert(var_21_2, string.format("%s enchantId : %s", var_21_3, arg_21_0.enchantId))
	table.insert(var_21_2, string.format("%s duration : %s", var_21_3, arg_21_0.duration))
	table.insert(var_21_2, string.format("%s exInfo : %s", var_21_3, table.concat(arg_21_0.exInfo, ",")))
	table.insert(var_21_2, var_21_0 .. "}")

	return table.concat(var_21_2, "\n")
end

function var_0_0.getEnchantListString(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_2 = arg_22_2 or "enchantList"

	return var_0_0.getMoListString(arg_22_0, var_0_0.getCardInfoEnchantString, arg_22_2, arg_22_1, arg_22_3)
end

var_0_0.ActTypeName = {
	[FightEnum.ActType.SKILL] = "技能",
	[FightEnum.ActType.BUFF] = "buff",
	[FightEnum.ActType.EFFECT] = "效果",
	[FightEnum.ActType.CHANGEHERO] = "换人",
	[FightEnum.ActType.CHANGEWAVE] = "换波次时机"
}

function var_0_0.getActTypeName(arg_23_0)
	return arg_23_0 and var_0_0.ActTypeName[arg_23_0] or ""
end

function var_0_0.getEntityName(arg_24_0)
	if arg_24_0 == FightEntityScene.MySideId then
		return "维尔汀"
	elseif arg_24_0 == FightEntityScene.EnemySideId then
		return "重塑之手"
	else
		local var_24_0 = FightDataHelper.entityMgr:getById(arg_24_0)

		if var_24_0 then
			return var_24_0:getEntityName()
		end

		return ""
	end

	return ""
end

function var_0_0.getSkillName(arg_25_0)
	local var_25_0 = lua_skill.configDict[arg_25_0]

	return var_25_0 and var_25_0.name or ""
end

function var_0_0.getTimelineName(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0 and FightDataHelper.entityMgr:getById(arg_26_0)
	local var_26_1 = FightConfig.instance:getSkinSkillTimeline(var_26_0 and var_26_0.skin, arg_26_1)

	return string.nilorempty(var_26_1) and "nil" or var_26_1
end

function var_0_0.getStack(arg_27_0, arg_27_1)
	return arg_27_0 and string.format("%s.%s", arg_27_0, arg_27_1) or arg_27_1
end

function var_0_0.addStack(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_2 = var_0_0.getStack(arg_28_2, arg_28_3)

	if string.nilorempty(arg_28_2) then
		return
	end

	table.insert(arg_28_0, string.format("%s stack : %s", arg_28_1, arg_28_2))
end

var_0_0.EffectTypeNameDict = {
	[FightEnum.EffectType.NONE] = "无效果",
	[FightEnum.EffectType.MISS] = "闪避",
	[FightEnum.EffectType.DAMAGE] = "造成伤害",
	[FightEnum.EffectType.CRIT] = "造成暴击",
	[FightEnum.EffectType.HEAL] = "治疗",
	[FightEnum.EffectType.BUFFADD] = "附加Buff",
	[FightEnum.EffectType.BUFFDEL] = "移除Buff",
	[FightEnum.EffectType.BUFFUPDATE] = "变更Buff回合(对应效果数值为变动值)",
	[FightEnum.EffectType.BUFFEFFECT] = "触发Buff效果",
	[FightEnum.EffectType.DEAD] = "死亡",
	[FightEnum.EffectType.ATTACKALTER] = "攻击改动（单场战斗内一直存在效果）",
	[FightEnum.EffectType.DEFENSEALTER] = "防御改动（单场战斗内一直存在效果）",
	[FightEnum.EffectType.BLOODLUST] = "吸血",
	[FightEnum.EffectType.PURIFY] = "净化",
	[FightEnum.EffectType.DISPERSE] = "驱散",
	[FightEnum.EffectType.ADDACT] = "增加行动点",
	[FightEnum.EffectType.ADDCARD] = "增加手牌",
	[FightEnum.EffectType.ADDEXPOINT] = "增加大招点",
	[FightEnum.EffectType.DAMAGEEXTRA] = "额外伤害",
	[FightEnum.EffectType.BUFFREJECT] = "添加buff被抵抗",
	[FightEnum.EffectType.DIZZY] = "限制使用技能（被眩晕无法使用技能）",
	[FightEnum.EffectType.INVINCIBLE] = "无敌",
	[FightEnum.EffectType.PROTECT] = "保护",
	[FightEnum.EffectType.FROZEN] = "冰冻",
	[FightEnum.EffectType.SILENCE] = "限制使用技能（沉默）",
	[FightEnum.EffectType.SHIELD] = "护盾",
	[FightEnum.EffectType.ATTR] = "属性改动",
	[FightEnum.EffectType.CURE] = "回血",
	[FightEnum.EffectType.SEAL] = "封技（禁用大招）",
	[FightEnum.EffectType.DISARM] = "缴械（禁用物理技能）",
	[FightEnum.EffectType.FORBID] = "禁魔（禁用魔法技能）",
	[FightEnum.EffectType.SLEEP] = "睡眠",
	[FightEnum.EffectType.PERTRIFIED] = "石化",
	[FightEnum.EffectType.IMMUNITY] = "免疫",
	[FightEnum.EffectType.INJURY] = "重伤",
	[FightEnum.EffectType.DOT] = "持续伤害",
	[FightEnum.EffectType.REBOUND] = "反弹",
	[FightEnum.EffectType.TAUNT] = "嘲讽",
	[FightEnum.EffectType.BEATBACK] = "反击",
	[FightEnum.EffectType.EXPOINTFIX] = "怒气修正",
	[FightEnum.EffectType.AVERAGELIFE] = "平分生命",
	[FightEnum.EffectType.SHIELDCHANGE] = "护盾转换",
	[FightEnum.EffectType.ADDTOATTACKER] = "给攻击者加buff",
	[FightEnum.EffectType.CURE2] = "回血（基于上回合伤害）",
	[FightEnum.EffectType.FORBIDSPECEFFECT] = "禁止特定类型技能",
	[FightEnum.EffectType.CANTCRIT] = "不暴击",
	[FightEnum.EffectType.PETRIFIEDRESIST] = "石化抵抗",
	[FightEnum.EffectType.SLEEPRESIST] = "睡眠抵抗",
	[FightEnum.EffectType.FROZENRESIST] = "冰冻抵抗",
	[FightEnum.EffectType.DIZZYRESIST] = "眩晕抵抗",
	[FightEnum.EffectType.ADDTOTARGET] = "给目标加buff",
	[FightEnum.EffectType.CRITPILEUP] = "暴击累加",
	[FightEnum.EffectType.DODGESPECSKILL] = "闪避特定技能(攻击后消失)",
	[FightEnum.EffectType.DODGESPECSKILL2] = "闪避特定技能",
	[FightEnum.EffectType.REDEALCARD] = "洗牌",
	[FightEnum.EffectType.BUFFADDNOEFFECT] = "Buff增加到失效列表",
	[FightEnum.EffectType.BUFFDELNOEFFECT] = "Buff从失效列表删除",
	[FightEnum.EffectType.HEALCRIT] = "治疗暴击",
	[FightEnum.EffectType.UNIVERSALCARD] = "获得万能牌",
	[FightEnum.EffectType.DEALCARD1] = "发牌1",
	[FightEnum.EffectType.DEALCARD2] = "发牌2",
	[FightEnum.EffectType.ROUNDEND] = "回合结束",
	[FightEnum.EffectType.SHIELDDEL] = "盾牌删除",
	[FightEnum.EffectType.EXPOINTCANTADD] = "无法加怒气",
	[FightEnum.EffectType.ADDBUFFROUND] = "额外增加buff回合",
	[FightEnum.EffectType.CARDLEVELADD] = "卡牌等级提升",
	[FightEnum.EffectType.IMMUNITYEXPOINTCHANGE] = "免疫怒气改变",
	[FightEnum.EffectType.MONSTERCHANGE] = "怪物变幻",
	[FightEnum.EffectType.EXPOINTADD] = "增加大招点（buff表现用）",
	[FightEnum.EffectType.EXPOINTDEL] = "减少大招点（buff表现用）",
	[FightEnum.EffectType.DAMAGENOTMORETHAN] = "受到伤害不超过生命百分比",
	[FightEnum.EffectType.BUFFATTR] = "根据buff数量加属性",
	[FightEnum.EffectType.EXPOINTCARDMOVE] = "移动卡牌怒气修正",
	[FightEnum.EffectType.EXPOINTCARDUPGRADE] = "合成卡牌怒气修正",
	[FightEnum.EffectType.FIXEDHURT] = "固定伤害",
	[FightEnum.EffectType.CARDLEVELCHANGE] = "卡牌变化",
	[FightEnum.EffectType.BUFFREPLACE] = "buff替换",
	[FightEnum.EffectType.EXTRAMOVEACT] = "额外移牌次数",
	[FightEnum.EffectType.SPCARDADD] = "获得特殊牌（主角技能）",
	[FightEnum.EffectType.RIGID] = "僵硬",
	[FightEnum.EffectType.COLD] = "寒冷",
	[FightEnum.EffectType.PALSY] = "麻痹",
	[FightEnum.EffectType.ADDBUFFROUNDBYTYPEID] = "额外增加buff回合（根据buff的typeid）",
	[FightEnum.EffectType.EXSKILLNOCONSUMPTION] = "大招不消耗大招点",
	[FightEnum.EffectType.EXPOINTADDAFTERDELORABSORBEXPOINT] = "在减少敌人大招点后增加自己大招点",
	[FightEnum.EffectType.CARDEFFECTCHANGE] = "卡牌附魔改变",
	[FightEnum.EffectType.SUMMON] = "召唤",
	[FightEnum.EffectType.SKILLWEIGHTSELECT] = "骰子技能选择",
	[FightEnum.EffectType.SKILLPOWERUP] = "技能提升",
	[FightEnum.EffectType.BUFFRATEUP] = "buff效果提升",
	[FightEnum.EffectType.SKILLRATEUP] = "技能倍率提升",
	[FightEnum.EffectType.EXPOINTMAXADD] = "增加大招点上限",
	[FightEnum.EffectType.HALOBASE] = "主光环效果",
	[FightEnum.EffectType.HALOSLAVE] = "附属光环效果",
	[FightEnum.EffectType.SELECTLAST] = "不被优先选中",
	[FightEnum.EffectType.CANTSELECT] = "不能被选中",
	[FightEnum.EffectType.CLEARUNIVERSALCARD] = "清空万能卡",
	[FightEnum.EffectType.CHANGECAREER] = "改变系别",
	[FightEnum.EffectType.FIXEDDAMAGE] = "造成伤害固定",
	[FightEnum.EffectType.PASSIVESKILLINVALID] = "被动失效",
	[FightEnum.EffectType.HIDELIFE] = "隐藏血条",
	[FightEnum.EffectType.BUFFADDACT] = "buff额外增加的行动点（可能为负）",
	[FightEnum.EffectType.ADDCARDLIMIT] = "增加手牌上限",
	[FightEnum.EffectType.ADDBUFFROUNDBYTYPEGROUP] = "额外增加buff回合（根据buff的typeid）",
	[FightEnum.EffectType.FREEZE] = "休眠，显示用",
	[FightEnum.EffectType.CANTSELECTEX] = "不能被选中",
	[FightEnum.EffectType.CARDDISAPPEAR] = "卡牌消失",
	[FightEnum.EffectType.CHANGEHERO] = "替补上场",
	[FightEnum.EffectType.MAXHPCHANGE] = "最大生命变化",
	[FightEnum.EffectType.CURRENTHPCHANGE] = "当前生命变化",
	[FightEnum.EffectType.KILL] = "斩杀",
	[FightEnum.EffectType.EXPOINTCHANGE] = "大招点变化（所有变化都需要发）",
	[FightEnum.EffectType.MONSTERSPLIFE] = "怪物特殊血条",
	[FightEnum.EffectType.EXSKILLPOINTCHANGE] = "大招需求激情变化",
	[FightEnum.EffectType.HARMSTATISTIC] = "伤害统计用buff",
	[FightEnum.EffectType.OVERFLOWHEALTOSHIELD] = "溢出治疗转盾",
	[FightEnum.EffectType.ADDSKILLBUFFCOUNTANDDURATION] = "增加主动技能加的buff的生效次数和生效回合",
	[FightEnum.EffectType.INDICATORCHANGE] = "指示物变化",
	[FightEnum.EffectType.MULTIHPCHANGE] = "多血条切换",
	[FightEnum.EffectType.MONSTERLABELBUFF] = "怪物标签buff",
	[FightEnum.EffectType.POWERMAXADD] = "增加能量上限",
	[FightEnum.EffectType.POWERCHANGE] = "能量改变",
	[FightEnum.EffectType.CANTGETEXSKILL] = "不能获得大招卡",
	[FightEnum.EffectType.ORIGINDAMAGE] = "本源创伤",
	[FightEnum.EffectType.ORIGINCRIT] = "本源创伤暴击",
	[FightEnum.EffectType.SHIELDBROCKEN] = "破盾",
	[FightEnum.EffectType.CARDREMOVE] = "临时创造卡移除",
	[FightEnum.EffectType.SUMMONEDADD] = "召唤物挂件增加",
	[FightEnum.EffectType.SUMMONEDDELETE] = "召唤物挂件移除",
	[FightEnum.EffectType.SUMMONEDLEVELUP] = "召唤物挂件升级",
	[FightEnum.EffectType.BURN] = "燃烧",
	[FightEnum.EffectType.MAGICCIRCLEADD] = "法阵增加",
	[FightEnum.EffectType.MAGICCIRCLEDELETE] = "法阵移除",
	[FightEnum.EffectType.MAGICCIRCLEUPDATE] = "法阵更新",
	[FightEnum.EffectType.CHANGETOTEMPCARD] = "原来的卡转为临时创造卡",
	[FightEnum.EffectType.ROGUEHEARTCHANGE] = "肉鸽心跳变化",
	[FightEnum.EffectType.ROGUECOINCHANGE] = "肉鸽金币变化",
	[FightEnum.EffectType.ROGUESAVECOIN] = "肉鸽偷到的金币",
	[FightEnum.EffectType.ROGUEESCAPE] = "逃跑",
	[FightEnum.EffectType.REGAINPOWER] = "恢复灵光",
	[FightEnum.EffectType.ADDTOBUFFENTITY] = "增加buff给buff持有者",
	[FightEnum.EffectType.MASTERPOWERCHANGE] = "主角技能点改变",
	[FightEnum.EffectType.ADDHANDCARD] = "添加卡牌",
	[FightEnum.EffectType.OVERFLOWPOWERADDBUFF] = "溢出灵光为持有者加buff",
	[FightEnum.EffectType.POWERCANTDECR] = "不再失去灵光",
	[FightEnum.EffectType.REMOVEENTITYCARDS] = "移除角色卡牌",
	[FightEnum.EffectType.CARDSCOMPOSE] = "发起角色卡牌合成（不一定合成）",
	[FightEnum.EffectType.CARDSPUSH] = "卡牌推送",
	[FightEnum.EffectType.CARDREMOVE2] = "卡牌移除（不触发合牌）",
	[FightEnum.EffectType.BFSGCONVERTCARD] = "北方哨歌专用 卡牌转换",
	[FightEnum.EffectType.BFSGUSECARD] = "北方哨歌专用 出牌",
	[FightEnum.EffectType.BFSGSKILLEND] = "北方哨歌专用 技能end",
	[FightEnum.EffectType.USECARDS] = "使用牌组",
	[FightEnum.EffectType.CARDINVALID] = "卡牌失效",
	[FightEnum.EffectType.BFSGSKILLSTART] = "北方哨歌专用 技能start",
	[FightEnum.EffectType.FIGHTSTEP] = "新的步骤",
	[FightEnum.EffectType.IGNOREDODGESPECSKILL] = "无视闪避",
	[FightEnum.EffectType.IGNORECOUNTER] = "无视反制",
	[FightEnum.EffectType.IGNOREREBOUND] = "无视反弹",
	[FightEnum.EffectType.CAREERRESTRAINT] = "灵感克制    ",
	[FightEnum.EffectType.STORAGEINJURY] = "记录承伤",
	[FightEnum.EffectType.INJURYLOGBACK] = "记录阶段内承伤,对自身本源伤害",
	[FightEnum.EffectType.ABSORBHURT] = "给队友承受部分伤害",
	[FightEnum.EffectType.CARDACONVERTCARDB] = "卡a转卡b",
	[FightEnum.EffectType.HEROUPGRADE] = "角色升级",
	[FightEnum.EffectType.MASTERHALO] = "新主光环",
	[FightEnum.EffectType.SLAVEHALO] = "新从光环",
	[FightEnum.EffectType.NOTIFYUPGRADEHERO] = "通知可升级",
	[FightEnum.EffectType.POLARIZATIONADDLIMIT] = "偏振上限增加",
	[FightEnum.EffectType.POLARIZATIONDECCARD] = "偏振卡牌需求减少",
	[FightEnum.EffectType.POLARIZATIONADDLEVEL] = "偏振等级增加",
	[FightEnum.EffectType.POLARIZATIONEXSKILLADD] = "使用大招卡偏振等级增加",
	[FightEnum.EffectType.RESONANCEADDLIMIT] = "共振上限增加",
	[FightEnum.EffectType.RESONANCEDECCARD] = "共振卡牌需求减少",
	[FightEnum.EffectType.RESONANCEADDLEVEL] = "共振等级增加",
	[FightEnum.EffectType.RESONANCEEXSKILLADD] = "使用大招卡共振等级增加",
	[FightEnum.EffectType.POLARIZATIONLEVEL] = "偏振等级",
	[FightEnum.EffectType.RESONANCELEVEL] = "共振等级",
	[FightEnum.EffectType.POLARIZATIONACTIVE] = "启用偏振",
	[FightEnum.EffectType.RESONANCEACTIVE] = "启用共振",
	[FightEnum.EffectType.ROUGEREWARD] = "肉鸽奖励buff(弃用)",
	[FightEnum.EffectType.ROUGEPOWERLIMITCHANGE] = "肉鸽魔力上限改变",
	[FightEnum.EffectType.ROUGEPOWERCHANGE] = "肉鸽魔力改变",
	[FightEnum.EffectType.ROUGECOINCHANGE] = "肉鸽金币改变",
	[FightEnum.EffectType.ROUGESPCARDADD] = "获得肉鸽特殊牌（主角技能）",
	[FightEnum.EffectType.DAMAGEFROMABSORB] = "造成伤害",
	[FightEnum.EffectType.DAMAGEFROMLOSTHP] = "损血",
	[FightEnum.EffectType.RECORDTEAMINJURYCOUNT] = "记录友方损失生命次数",
	[FightEnum.EffectType.INJURYBANKHEAL] = "承伤触发治疗",
	[FightEnum.EffectType.MASTERCARDREMOVE] = "主角技能删牌",
	[FightEnum.EffectType.MASTERADDHANDCARD] = "主角技能加牌",
	[FightEnum.EffectType.FIGHTCOUNTER] = "战斗计数器",
	[FightEnum.EffectType.IGNOREBEATBACK] = "无视獠牙伙伴",
	[FightEnum.EffectType.ENTERTEAMSTAGE] = "进入队伍阶段",
	[FightEnum.EffectType.MOCKTAUNT] = "类嘲讽buff",
	[FightEnum.EffectType.ENCHANTBURNDAMAGE] = "附魔燃烧伤害",
	[FightEnum.EffectType.REALHURTFIXWITHLIMIT] = "本源创伤承受伤害修正, 且受到伤害不超过生命百分比(J新增)",
	[FightEnum.EffectType.BUFFTYPENUMLIMITUPDATE] = "buff类层数上限修正(J新增,修改燃烧层数上限)",
	[FightEnum.EffectType.LOCKHP] = "锁血",
	[FightEnum.EffectType.MOVE] = "位移",
	[FightEnum.EffectType.MOVEFRONT] = "前移",
	[FightEnum.EffectType.MOVEBACK] = "后移",
	[FightEnum.EffectType.SKILLLEVELJUDGEADD] = "技能阶数判定提升",
	[FightEnum.EffectType.TEAMMATEINJURYCOUNT] = "开始记录队友承伤次数的标记buff",
	[FightEnum.EffectType.SMALLROUNDEND] = "换出手方",
	[FightEnum.EffectType.CHANGEROUND] = "换回合",
	[FightEnum.EffectType.POISON] = "中毒",
	[FightEnum.EffectType.EXPOINTOVERFLOWBANK] = "怒气溢出存储",
	[FightEnum.EffectType.ADDUSECARD] = "加牌到出牌区",
	[FightEnum.EffectType.LOCKDOT] = "锁毒buff，不扣除",
	[FightEnum.EffectType.CATAPULTBUFF] = "弹射buff",
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = "出牌区卡牌升阶",
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = "出牌区卡牌降阶",
	[FightEnum.EffectType.PLAYSETGRAY] = "出牌区置灰",
	[FightEnum.EffectType.RESISTANCESATTR] = "抗性属性",
	[FightEnum.EffectType.RESISTANCES] = "产生抗性 加buff失败",
	[FightEnum.EffectType.ADDBUFFROUNDBYSKILL] = "技能增加buff次数和回合",
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = "出牌区卡牌变阶失败",
	[FightEnum.EffectType.COPYBUFFBYKILL] = "击杀时记录buff然后复制",
	[FightEnum.EffectType.POISONSETTLECANCRIT] = "中毒可暴击",
	[FightEnum.EffectType.CHANGEWAVE] = "换波",
	[FightEnum.EffectType.SHIELDVALUECHANGE] = "护盾值改变",
	[FightEnum.EffectType.BREAKSHIELD] = "破盾",
	[FightEnum.EffectType.STRESSTRIGGER] = "压力触发行为",
	[FightEnum.EffectType.LAYERMASTERHALO] = "可叠层的主光环",
	[FightEnum.EffectType.LAYERSLAVEHALO] = "可叠层附属光环效果",
	[FightEnum.EffectType.ENTERFIGHTDEAL] = "进入战斗发牌",
	[FightEnum.EffectType.LAYERHALOSYNC] = "叠层光环同步",
	[FightEnum.EffectType.SUBHEROLIFECHANGE] = "替补血量变化",
	[FightEnum.EffectType.GUARDCHANGE] = "格挡值变化",
	[FightEnum.EffectType.LOCKBULLETCOUNTDECR] = "锁定子弹减少 保留最后一层",
	[FightEnum.EffectType.ENTITYSYNC] = "实体消息同步",
	[FightEnum.EffectType.PRECISIONREGION] = "精准区域",
	[FightEnum.EffectType.TRANSFERADDEXPOINT] = "转移激情",
	[FightEnum.EffectType.NOTIFIYHEROCONTRACT] = "(娜娜)通知可发起契约",
	[FightEnum.EffectType.CONTRANCT] = "(娜娜)契约   242表示娜娜自己",
	[FightEnum.EffectType.BECONTRANCTED] = "(娜娜)被契约  243表示被契约的人",
	[FightEnum.EffectType.SPEXPOINTMAXADD] = "(特殊表现(娜娜))增加大招点上限",
	[FightEnum.EffectType.TRANSFERADDSTRESS] = "转移应激",
	[FightEnum.EffectType.GUARDBREAK] = "破盾",
	[FightEnum.EffectType.CARDDECKGENERATE] = "生成指定技能插入牌库",
	[FightEnum.EffectType.CARDDECKDELETE] = "删除指定技能牌库",
	[FightEnum.EffectType.DELCARDANDDAMAGE] = "删除卡牌并造成伤害",
	[FightEnum.EffectType.CHARM] = "魅惑（同眩晕效果一致）",
	[FightEnum.EffectType.PROGRESSCHANGE] = "战场进度变化",
	[FightEnum.EffectType.ASSISTBOSSSKILLCD] = "修改协助boss技能cd",
	[FightEnum.EffectType.DAMAGESHAREHP] = "共享血量扣血",
	[FightEnum.EffectType.USECARDFIXEXPOINT] = "使用卡牌修正大招点",
	[FightEnum.EffectType.DEADLYPOISON] = "剧毒",
	[FightEnum.EffectType.PROGRESSMAXCHANGE] = "战场进度最大值变化",
	[FightEnum.EffectType.DUDUBONECONTINUECHANNEL] = "笃笃骨吟诵",
	[FightEnum.EffectType.ZXQREMOVECARD] = "纸信圈专属移除卡牌，没有表现效果",
	[FightEnum.EffectType.CURECORRECT] = "治疗修正",
	[FightEnum.EffectType.ASSISTBOSSCHANGE] = "协助boss改变",
	[FightEnum.EffectType.CONFUSION] = "混乱效果",
	[FightEnum.EffectType.RETAINPERTRIFIED] = "攻击石化单位时不解除石化",
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = "剧毒本源创伤",
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = "剧毒本源创伤暴击",
	[FightEnum.EffectType.ASSISTBOSSSKILLCHANGE] = "协助boss技能改变",
	[FightEnum.EffectType.LOCKBURN] = "锁燃烧",
	[FightEnum.EffectType.ADDITIONALDAMAGE] = "附加伤害",
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = "附加伤害暴击",
	[FightEnum.EffectType.ACT174FIRST] = "活动174决定先后手",
	[FightEnum.EffectType.ACT174USECARD] = "活动174回合出牌",
	[FightEnum.EffectType.CHANGESHIELD] = "修改护盾值",
	[FightEnum.EffectType.TOWERSCORECHANGE] = "限时塔分数改变",
	[FightEnum.EffectType.ACT174MONSTERAICARD] = "敌方选牌列表",
	[FightEnum.EffectType.AFTERREDEALCARD] = "洗牌后",
	[FightEnum.EffectType.TEAMENERGYCHANGE] = "队伍灵能变化",
	[FightEnum.EffectType.ALLOCATECARDENERGY] = "分配手牌灵能",
	[FightEnum.EffectType.EMITTERENERGYCHANGE] = "发射器灵能变化",
	[FightEnum.EffectType.EMITTERSKILLEND] = "发射器技能结束",
	[FightEnum.EffectType.CARDDECKCLEAR] = "清空牌库",
	[FightEnum.EffectType.EMITTERCREATE] = "发射器实体创建",
	[FightEnum.EffectType.ADDONCECARD] = "加一张牌 新加效果详情请咨询 皓文大佬 and 森总 ",
	[FightEnum.EffectType.SHAREHURT] = "分摊伤害",
	[FightEnum.EffectType.PLAYERFINISHERSKILLCHANGE] = "玩家终结技能改变",
	[FightEnum.EffectType.EMITTERCAREERCHANGE] = "奥术飞弹发射器灵感变换",
	[FightEnum.EffectType.EMITTERNUMCHANGE] = "奥术飞弹发射器数量改变",
	[FightEnum.EffectType.EMITTERTAG] = "奥术飞弹发射器存在标记tag",
	[FightEnum.EffectType.EMITTERREMOVE] = "发射器实体移除",
	[FightEnum.EffectType.USESKILLTEAMADDEMITTERENERGY] = "行动全队特定buff提升奥术飞弹灵能值",
	[FightEnum.EffectType.FIXATTRTEAMENERGY] = "属性修正（根据队伍灵能值）",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONACTIVE] = "启用简振",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONLEVEL] = "简振等级",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONADDLEVEL] = "添加简振等级",
	[FightEnum.EffectType.CALLMONSTERTOSUB] = "召唤小怪到后场",
	[FightEnum.EffectType.FIXATTRTEAMENERGYANDBUFF] = "属性修正（根据队伍灵能值和队友buff） value显示数值",
	[FightEnum.EffectType.POWERINFOCHANGE] = "能量信息变化",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONADDLIMIT] = "简振上限增加",
	[FightEnum.EffectType.EMITTERMAINTARGET] = "奥术飞弹优先攻击目标",
	[FightEnum.EffectType.CONDITIONSPLITEMITTERNUM] = "奥术飞弹条件分裂",
	[FightEnum.EffectType.ADDSPLITEMITTERNUM] = "奥术飞弹额外分裂",
	[FightEnum.EffectType.EMITTERFIGHTNOTIFY] = "奥术飞弹放技能前通知",
	[FightEnum.EffectType.MUSTCRITBUFF] = "必定暴击buff",
	[FightEnum.EffectType.MUSTCRIT] = "触发必定暴击",
	[FightEnum.EffectType.CARDAREAREDORBLUE] = "(梁月大)手牌红蓝分区Buff",
	[FightEnum.EffectType.TOCARDAREAREDORBLUE] = "(梁月大)决定操作区手牌红蓝分区",
	[FightEnum.EffectType.REDORBLUECOUNT] = "(梁月大)红蓝区计数Buff",
	[FightEnum.EffectType.REDORBLUECOUNTCHANGE] = "(梁月大)红蓝区计数变更",
	[FightEnum.EffectType.REDORBLUECHANGETRIGGER] = "(梁月大)红蓝区计数触发阈值变更buff",
	[FightEnum.EffectType.CARDHEATINIT] = "卡牌热力初始化",
	[FightEnum.EffectType.CARDHEATVALUECHANGE] = "卡牌热力值变化",
	[FightEnum.EffectType.CARDDECKNUM] = "牌库数量",
	[FightEnum.EffectType.REDORBLUECOUNTEXSKILL] = "(梁月大)红蓝区队列满触发追击",
	[FightEnum.EffectType.STORAGEDAMAGE] = "存储伤害",
	[FightEnum.EffectType.ELUSIVE] = "场上有其他未携带该buff的友方时携带该buff的单位无法被选为主目标",
	[FightEnum.EffectType.ENCHANTDEPRESSEDAMAGE] = "附魔 气脉郁结 伤害",
	[FightEnum.EffectType.SAVEFIGHTRECORDSTART] = "战场回溯开始",
	[FightEnum.EffectType.SAVEFIGHTRECORDUPDATE] = "战场回溯更新实体信息",
	[FightEnum.EffectType.SAVEFIGHTRECORDEND] = "战场回溯结束",
	[FightEnum.EffectType.ROUNDOFFSET] = "回合数偏移",
	[FightEnum.EffectType.SAVEFIGHTRECORD] = "战场回溯buff",
	[FightEnum.EffectType.ADDSPHANDCARD] = "添加SP手牌 78有问题 没有完整cardInfo 少用 ",
	[FightEnum.EffectType.NONCAREERRESTRAINT] = "非克制伤害",
	[FightEnum.EffectType.CLEARMONSTERSUB] = "清空怪物候场",
	[FightEnum.EffectType.FIGHTTASKUPDATE] = "战斗任务更新",
	[FightEnum.EffectType.RETAINSLEEP] = "攻击噩梦单位不解除噩梦",
	[FightEnum.EffectType.REMOVEMONSTERSUB] = "移除怪物候场",
	[FightEnum.EffectType.ADDCARDRECORDBYROUND] = "回合记忆卡牌数据更新",
	[FightEnum.EffectType.DIRECTUSEEXSKILL] = "直接释放大招",
	[FightEnum.EffectType.SPLITSTART] = "分割 开始 目前梦游2换人专用 要用要找皓文大佬说一下 必须要和SPLITEND配套使用",
	[FightEnum.EffectType.SPLITEND] = "分割 结束 目前梦游2换人专用 要用要找皓文大佬说一下 必须要和SPLITSTART配套使用",
	[FightEnum.EffectType.FIGHTPARAMCHANGE] = "FightParam变化",
	[FightEnum.EffectType.BLOODPOOLMAXCREATE] = "血池创建",
	[FightEnum.EffectType.BLOODPOOLMAXCHANGE] = "血池最大值变化",
	[FightEnum.EffectType.BLOODPOOLVALUECHANGE] = "血池当前值变化",
	[FightEnum.EffectType.COLDSATURDAYHURT] = "冷周六伤害特效",
	[FightEnum.EffectType.NEWCHANGEWAVE] = "新的切波次 原因：以前切波数据拆成两个协议发，很容易导致有问题，加一下新的切波并且将fight加到effect里面",
	[FightEnum.EffectType.CHANGECARDENERGY] = "修改卡牌灵能",
	[FightEnum.EffectType.CLIENTEFFECT] = "客户端表现",
	[FightEnum.EffectType.MAGICCIRCLEUPGRADE] = "法阵升级",
	[FightEnum.EffectType.NUODIKARANDOMATTACK] = "诺谛卡仪式随机攻击",
	[FightEnum.EffectType.NUODIKATEAMATTACK] = "诺谛卡仪式群体攻击",
	[FightEnum.EffectType.TRIGGERANALYSIS] = "触发分析",
	[FightEnum.EffectType.GETSECRETKEY] = "获取秘钥",
	[FightEnum.EffectType.SURVIVALHEALTHCHANGE] = "探索健康度变化",
	[FightEnum.EffectType.LOCKHPMAX] = "锁定血量上限",
	[FightEnum.EffectType.CUREUPBYLOSTHP] = "治疗修正提升根据损失血量",
	[FightEnum.EffectType.NOUSECARDENERGYRECORDBYROUND] = "记录回合未使用卡牌最高灵能值",
	[FightEnum.EffectType.NUODIKARANDOMATTACKNUM] = "诺谛卡仪式群体攻击次数同步",
	[FightEnum.EffectType.BUFFACTINFOUPDATE] = "buffActInfo更新",
	[FightEnum.EffectType.REALDAMAGEKILL] = "斩杀伤害",
	[FightEnum.EffectType.BUFFDELREASON] = "buff删除原因",
	[FightEnum.EffectType.RANDOMDICEUSESKILL] = "骰子表现随机释放技能",
	[FightEnum.EffectType.TOWERDEEPCHANGE] = "爬塔深度变化",
	[FightEnum.EffectType.FIGHTHURTDETAIL] = "战斗伤害通用信息结构",
	[FightEnum.EffectType.TRIGGER] = "触发器",
	[FightEnum.EffectType.EZIOBIGSKILLDAMAGE] = "EZIO大招伤害",
	[FightEnum.EffectType.EZIOBIGSKILLORIGINDAMAGE] = "EZIO大招本源创伤",
	[FightEnum.EffectType.UPDATEITEMPLAYERSKILL] = "更新道具主角技能",
	[FightEnum.EffectType.EZIOBIGSKILLEXIT] = "EZIO大招意外退出"
}

function var_0_0.getEffectTypeName(arg_29_0)
	return var_0_0.EffectTypeNameDict[arg_29_0]
end

return var_0_0
