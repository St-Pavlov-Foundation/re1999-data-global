module("modules.logic.fight.controller.log.FightLogHelper", package.seeall)

slot0 = _M

function slot0.getPrefix(slot0)
	return string.rep("\t", slot0)
end

function slot0.getMoListString(slot0, slot1, slot2, slot3)
	if not slot0 then
		return string.format("%s %s : nil", uv0.getPrefix(slot3 or 0), slot2)
	end

	if #slot0 == 0 then
		return string.format("%s %s : []", slot4, slot2)
	end

	slot5 = {
		string.format("%s %s : [", slot4, slot9)
	}
	slot9 = slot2

	for slot9, slot10 in ipairs(slot0) do
		table.insert(slot5, slot1(slot10, slot3 + 1, slot9))
	end

	table.insert(slot5, slot4 .. "]")

	return table.concat(slot5, "\n")
end

function slot0.getMoDictString(slot0, slot1, slot2, slot3, slot4)
	if not slot0 then
		return string.format("%s %s : nil", uv0.getPrefix(slot3 or 0), slot2)
	end

	if GameUtil.tabletool_dictIsEmpty(slot0) then
		return string.format("%s %s : []", slot5, slot2)
	end

	slot10 = slot4
	slot11 = slot2

	uv0.addStack({
		string.format("%s %s : [", slot5, slot2)
	}, uv0.getPrefix(slot3 + 1), slot10, slot11)

	for slot10, slot11 in pairs(slot0) do
		table.insert(slot6, slot1(slot11, slot3 + 1, tostring(slot10), uv0.getStack(slot4, slot2)))
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
	slot4 = uv0.buildClassNameByIndex("FightRoundMO", slot2)

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
	table.insert(slot5, uv0.getFightStepListString(slot0.fightStepMOs, slot1, "fightStepMOs"))
	table.insert(slot5, uv0.getFightStepListString(slot0.nextRoundBeginStepMOs, slot1, "nextRoundBeginStepMOs"))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getFightStepString(slot0, slot1, slot2)
	if not slot0 then
		return string.format("%s %s : nil", uv0.getPrefix(slot1 or 0), uv0.buildClassNameByIndex("FightStepMo", slot2))
	end

	slot5 = {}

	if FightHelper.needAddRoundStep(slot0) then
		slot6 = string.format("%s %s {", slot3, slot4) .. "会被添加为新的步骤"
	end

	table.insert(slot5, slot6)
	table.insert(slot5, string.format("%s actType : %s %s", uv0.getPrefix(slot1 + 1), slot0.actType, uv0.getActTypeName(slot0.actType)))

	if slot0.actType == FightEnum.ActType.SKILL then
		table.insert(slot5, string.format("%s fromId : %s 技能发起者:%s", slot7, slot0.fromId, uv0.getEntityName(slot0.fromId)))
		table.insert(slot5, string.format("%s toId : %s 技能承受者:%s", slot7, slot0.toId, uv0.getEntityName(slot0.toId)))
		table.insert(slot5, string.format("%s actId : %s 技能名字:%s timeline : %s", slot7, slot0.actId, uv0.getSkillName(slot0.actId), uv0.getTimelineName(slot0.fromId, slot0.actId)))
	else
		table.insert(slot5, string.format("%s fromId : %s", slot7, slot0.fromId))
		table.insert(slot5, string.format("%s toId : %s", slot7, slot0.toId))
		table.insert(slot5, string.format("%s actId : %s", slot7, slot0.actId))
	end

	table.insert(slot5, string.format("%s cardIndex : %s", slot7, slot0.cardIndex))
	table.insert(slot5, string.format("%s supportHeroId : %s", slot7, slot0.supportHeroId))
	table.insert(slot5, uv0.getFightActEffectListString(slot0.actEffectMOs, slot1, "actEffectMOs"))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getFightStepListString(slot0, slot1, slot2)
	return uv0.getMoListString(slot0, uv0.getFightStepString, slot2 or "stepMoList", slot1)
end

function slot0.getFightActEffectString(slot0, slot1, slot2)
	if FightLogFilterHelper.checkEffectMoIsFilter(slot0) then
		return ""
	end

	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("ActEffectMO", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot1 = slot1 + 1
	slot6 = uv0.getPrefix(slot1)

	table.insert(slot5, string.format("%s targetId : %s 作用对象:%s", slot6, slot0.targetId, uv0.getEntityName(slot0.targetId)))
	table.insert(slot5, string.format("%s effectType : %s 效果类型:%s", slot6, slot0.effectType, uv0.getEffectTypeName(slot0.effectType)))
	table.insert(slot5, string.format("%s effectNum : %s", slot6, slot0.effectNum))
	table.insert(slot5, string.format("%s effectNum1 : %s", slot6, slot0.effectNum1))
	table.insert(slot5, string.format("%s fromSide : %s", slot6, slot0.fromSide))
	table.insert(slot5, string.format("%s configEffect : %s", slot6, slot0.configEffect))
	table.insert(slot5, string.format("%s buffActId : %s", slot6, slot0.buffActId))
	table.insert(slot5, string.format("%s reserveId : %s", slot6, slot0.reserveId))
	table.insert(slot5, string.format("%s reserveStr : %s", slot6, slot0.reserveStr))
	table.insert(slot5, uv0.getAssistBossInfoString(slot0.assistBossInfo, slot1))

	if slot0.cus_stepMO then
		table.insert(slot5, uv0.getFightStepString(slot0.cus_stepMO, slot1))
	end

	if slot0.buff then
		table.insert(slot5, uv0.getFightBuffString(slot0.buff, slot1))
	end

	if slot0.entityMO then
		table.insert(slot5, uv0.getEntityMoString(slot0.entityMO, slot1))
	end

	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getAssistBossInfoString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("AssistBossInfo", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot1 = slot1 + 1
	slot6 = uv0.getPrefix(slot1)

	table.insert(slot5, string.format("%s currCd : %s", slot6, slot0.currCd))
	table.insert(slot5, string.format("%s cdCfg : %s", slot6, slot0.cdCfg))
	table.insert(slot5, string.format("%s formId : %s", slot6, slot0.formId))
	table.insert(slot5, uv0.getAssistBossSkillInfoString(slot0.skills, slot1))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getAssistBossSkillInfoString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("AssistBossSkillInfo", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot6 = uv0.getPrefix(slot1 + 1)

	table.insert(slot5, string.format("%s skillId : %s", slot6, slot0.skillId))
	table.insert(slot5, string.format("%s needPower : %s", slot6, slot0.needPower))
	table.insert(slot5, string.format("%s powerLow : %s", slot6, slot0.powerLow))
	table.insert(slot5, string.format("%s powerHigh : %s", slot6, slot0.powerHigh))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getFightAssistBossSkillListString(slot0, slot1, slot2)
	return uv0.getMoListString(slot0, uv0.getAssistBossSkillInfoString, slot2 or "assistBossSkillInfoList", slot1)
end

function slot0.getFightActEffectListString(slot0, slot1, slot2)
	return uv0.getMoListString(slot0, uv0.getFightActEffectString, slot2 or "actEffectMoList", slot1)
end

function slot0.getFightBuffString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("FightBuffMO", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot6 = uv0.getPrefix(slot1 + 1)

	table.insert(slot5, string.format("%s time : %s", slot6, slot0.time))
	table.insert(slot5, string.format("%s entityId : %s %s", slot6, slot0.entityId, uv0.getEntityName(slot0.entityId)))
	table.insert(slot5, string.format("%s id : %s", slot6, slot0.id))
	table.insert(slot5, string.format("%s uid : %s", slot6, slot0.uid))
	table.insert(slot5, string.format("%s buffId : %s %s", slot6, slot0.buffId, slot0.name))
	table.insert(slot5, string.format("%s duration : %s", slot6, slot0.duration))
	table.insert(slot5, string.format("%s exInfo : %s", slot6, slot0.exInfo))
	table.insert(slot5, string.format("%s fromUid : %s", slot6, slot0.fromUid))
	table.insert(slot5, string.format("%s count : %s", slot6, slot0.count))
	table.insert(slot5, string.format("%s name : %s", slot6, slot0.name))
	table.insert(slot5, string.format("%s actCommonParams : %s", slot6, slot0.actCommonParams))
	table.insert(slot5, string.format("%s layer : %s", slot6, slot0.layer))
	table.insert(slot5, slot3 .. "}")

	return table.concat(slot5, "\n")
end

function slot0.getFightBuffListString(slot0, slot1, slot2)
	return uv0.getMoListString(slot0, uv0.getFightBuffString, slot2 or "buffMoList", slot1)
end

function slot0.getFightBuffDictString(slot0, slot1, slot2)
	return uv0.getMoDictString(slot0, uv0.getFightBuffString, slot2 or "buffMoDict", slot1)
end

function slot0.getEntityMoString(slot0, slot1, slot2)
	slot3 = uv0.getPrefix(slot1 or 0)
	slot4 = uv0.buildClassNameByIndex("FightEntityMO", slot2)

	if not slot0 then
		return string.format("%s %s : nil", slot3, slot4)
	end

	slot5 = {
		string.format("%s %s {", slot3, slot4)
	}
	slot6 = uv0.getPrefix(slot1 + 1)

	table.insert(slot5, string.format("%s id : %s", slot6, slot0.id))
	table.insert(slot5, string.format("%s uid : %s", slot6, slot0.uid))
	table.insert(slot5, string.format("%s modelId : %s", slot6, slot0.modelId))
	table.insert(slot5, string.format("%s skin : %s", slot6, slot0.skin))
	table.insert(slot5, string.format("%s originSkin : %s", slot6, slot0.originSkin))
	table.insert(slot5, string.format("%s position : %s", slot6, slot0.position))
	table.insert(slot5, string.format("%s entityType : %s", slot6, slot0.entityType))
	table.insert(slot5, string.format("%s userId : %s", slot6, slot0.userId))
	table.insert(slot5, string.format("%s exPoint : %s", slot6, slot0.exPoint))
	table.insert(slot5, string.format("%s level : %s", slot6, slot0.level))
	table.insert(slot5, string.format("%s currentHp : %s", slot6, slot0.currentHp))
	table.insert(slot5, string.format("%s equipUid : %s", slot6, slot0.equipUid))
	table.insert(slot5, string.format("%s side : %s", slot6, slot0.side))
	table.insert(slot5, string.format("%s career : %s", slot6, slot0.career))
	table.insert(slot5, string.format("%s storedExPoint : %s", slot6, slot0.storedExPoint))
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

slot0.EffectTypeNameDict = {
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
	[FightEnum.EffectType.BURN] = " 燃烧",
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
	[FightEnum.EffectType.PRECISIONREGION] = " 精准区域",
	[FightEnum.EffectType.TRANSFERADDEXPOINT] = " 转移激情",
	[FightEnum.EffectType.NOTIFIYHEROCONTRACT] = " (娜娜)通知可发起契约",
	[FightEnum.EffectType.CONTRANCT] = " (娜娜)契约   242表示娜娜自己",
	[FightEnum.EffectType.BECONTRANCTED] = " (娜娜)被契约  243表示被契约的人",
	[FightEnum.EffectType.SPEXPOINTMAXADD] = " (特殊表现(娜娜))增加大招点上限",
	[FightEnum.EffectType.TRANSFERADDSTRESS] = "转移应激",
	[FightEnum.EffectType.GUARDBREAK] = "破盾",
	[FightEnum.EffectType.CARDDECKGENERATE] = "生成指定技能插入牌库",
	[FightEnum.EffectType.CARDDECKDELETE] = "删除指定技能牌库",
	[FightEnum.EffectType.DELCARDANDDAMAGE] = "删除卡牌并造成伤害",
	[FightEnum.EffectType.CHARM] = " 魅惑（同眩晕效果一致）",
	[FightEnum.EffectType.PROGRESSCHANGE] = "战场进度变化",
	[FightEnum.EffectType.ASSISTBOSSSKILLCD] = "修改协助boss技能cd",
	[FightEnum.EffectType.DAMAGESHAREHP] = "共享血量扣血",
	[FightEnum.EffectType.USECARDFIXEXPOINT] = "使用卡牌修正大招点",
	[FightEnum.EffectType.DEADLYPOISON] = "剧毒",
	[FightEnum.EffectType.PROGRESSMAXCHANGE] = "战场进度最大值变化",
	[FightEnum.EffectType.DUDUBONECONTINUECHANNEL] = "笃笃骨吟诵",
	[FightEnum.EffectType.ZXQREMOVECARD] = "纸信圈专属移除卡牌，没有表现效果",
	[FightEnum.EffectType.CURECORRECT] = " 治疗修正",
	[FightEnum.EffectType.ASSISTBOSSCHANGE] = " 协助boss改变",
	[FightEnum.EffectType.CONFUSION] = " 混乱效果",
	[FightEnum.EffectType.RETAINPERTRIFIED] = " 攻击石化单位时不解除石化",
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
	[FightEnum.EffectType.USESKILLTEAMADDEMITTERENERGY] = " 行动全队特定buff提升奥术飞弹灵能值",
	[FightEnum.EffectType.FIXATTRTEAMENERGY] = " 属性修正（根据队伍灵能值）",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONACTIVE] = "启用简振",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONLEVEL] = "简振等级",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONADDLEVEL] = "添加简振等级",
	[FightEnum.EffectType.CALLMONSTERTOSUB] = "召唤小怪到后场",
	[FightEnum.EffectType.FIXATTRTEAMENERGYANDBUFF] = " 属性修正（根据队伍灵能值和队友buff） value显示数值",
	[FightEnum.EffectType.POWERINFOCHANGE] = "能量信息变化",
	[FightEnum.EffectType.SIMPLEPOLARIZATIONADDLIMIT] = "简振上限增加",
	[FightEnum.EffectType.EMITTERMAINTARGET] = " 奥术飞弹优先攻击目标",
	[FightEnum.EffectType.CONDITIONSPLITEMITTERNUM] = " 奥术飞弹条件分裂",
	[FightEnum.EffectType.ADDSPLITEMITTERNUM] = " 奥术飞弹额外分裂",
	[FightEnum.EffectType.EMITTERSPLITNUM] = " 奥术飞弹分裂通知",
	[FightEnum.EffectType.MUSTCRITBUFF] = " 必定暴击buff",
	[FightEnum.EffectType.MUSTCRIT] = " 触发必定暴击",
	[FightEnum.EffectType.CARDAREAREDORBLUE] = " (梁月大)手牌红蓝分区Buff",
	[FightEnum.EffectType.TOCARDAREAREDORBLUE] = " (梁月大)决定操作区手牌红蓝分区",
	[FightEnum.EffectType.REDORBLUECOUNT] = " (梁月大)红蓝区计数Buff",
	[FightEnum.EffectType.REDORBLUECOUNTCHANGE] = " (梁月大)红蓝区计数变更",
	[FightEnum.EffectType.REDORBLUECHANGETRIGGER] = " (梁月大)红蓝区计数触发阈值变更buff",
	[FightEnum.EffectType.CARDHEATINIT] = " 卡牌热力初始化",
	[FightEnum.EffectType.CARDHEATVALUECHANGE] = " 卡牌热力值变化",
	[FightEnum.EffectType.CARDDECKNUM] = " 牌库数量",
	[FightEnum.EffectType.REDORBLUECOUNTEXSKILL] = " (梁月大)红蓝区队列满触发追击",
	[FightEnum.EffectType.STORAGEDAMAGE] = " 存储伤害",
	[FightEnum.EffectType.ELUSIVE] = " 场上有其他未携带该buff的友方时携带该buff的单位无法被选为主目标",
	[FightEnum.EffectType.ENCHANTDEPRESSEDAMAGE] = " 附魔 气脉郁结 伤害",
	[FightEnum.EffectType.SAVEFIGHTRECORDSTART] = " 战场回溯开始",
	[FightEnum.EffectType.SAVEFIGHTRECORDUPDATE] = " 战场回溯更新实体信息",
	[FightEnum.EffectType.SAVEFIGHTRECORDEND] = " 战场回溯结束",
	[FightEnum.EffectType.ROUNDOFFSET] = " 回合数偏移",
	[FightEnum.EffectType.SAVEFIGHTRECORD] = " 战场回溯buff",
	[FightEnum.EffectType.ADDSPHANDCARD] = " 添加SP手牌 78有问题 没有完整cardInfo 少用 ",
	[FightEnum.EffectType.TRIGGER] = "触发器"
}

function slot0.getEffectTypeName(slot0)
	return uv0.EffectTypeNameDict[slot0]
end

return slot0
