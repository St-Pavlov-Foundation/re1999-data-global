module("modules.logic.fight.entity.mgr.FightSkillBuffMgr", package.seeall)

slot0 = class("FightSkillBuffMgr")

function slot0.ctor(slot0)
	slot0:_init()
end

function slot0._init(slot0)
	slot0._buffPlayDict = {}
	slot0._buffEffectPlayDict = {}
end

function slot0.clearCompleteBuff(slot0)
	slot0:_init()
end

function slot0.playSkillBuff(slot0, slot1, slot2)
	if not slot0:hasPlayBuff(slot2) then
		FightWork2Work.New(FightWorkStepBuff, slot1, slot2):onStart()

		slot5 = slot2.buff
		slot0._buffPlayDict[slot2.clientId] = true

		if slot1.stepUid and slot2.effectType == FightEnum.EffectType.BUFFADD and lua_skill_buff.configDict[slot5.buffId] and slot7.effect ~= "0" and not string.nilorempty(slot7.effect) then
			slot0._buffEffectPlayDict[string.format(slot6 .. "-" .. slot5.entityId .. "-" .. slot7.effect)] = true
		end
	end
end

function slot0.hasPlayBuff(slot0, slot1)
	return slot0._buffPlayDict[slot1.clientId]
end

function slot0.hasPlayBuffEffect(slot0, slot1, slot2, slot3)
	slot4 = lua_skill_buff.configDict[slot2.buffId]

	if slot3 and slot4 and slot4.effect ~= "0" and not string.nilorempty(slot4.effect) then
		return slot0._buffEffectPlayDict[string.format(slot3 .. "-" .. slot1 .. "-" .. slot4.effect)]
	end

	return false
end

slot0.StackBuffFeatureList = {
	FightEnum.BuffType_DeadlyPoison
}

function slot0.buffIsStackerBuff(slot0, slot1)
	if not slot1 then
		return false
	end

	for slot6, slot7 in ipairs(uv0.StackBuffFeatureList) do
		if FightConfig.instance:hasBuffFeature(slot1.id, slot7) then
			return true, FightStrUtil.instance:getSplitCache(lua_skill_bufftype.configDict[slot1.typeId].includeTypes, "#")[1]
		end
	end

	if lua_skill_bufftype.configDict[slot1.typeId] and (FightStrUtil.instance:getSplitCache(slot3.includeTypes, "#")[1] == FightEnum.BuffIncludeTypes.Stacked or slot5 == FightEnum.BuffIncludeTypes.Stacked12 or slot5 == FightEnum.BuffIncludeTypes.Stacked15 or slot5 == FightEnum.BuffIncludeTypes.Stacked14) then
		return true, slot5
	end
end

slot0.tempSignKeyDict = {}

function slot0.dealStackerBuff(slot0, slot1)
	tabletool.clear(uv0.tempSignKeyDict)

	for slot6 = #slot1, 1, -1 do
		if lua_skill_buff.configDict[slot1[slot6].buffId] and slot0:buffIsStackerBuff(slot8) then
			if not slot2[FightBuffHelper.getBuffMoSignKey(slot7)] then
				slot2[slot9] = true
			else
				table.remove(slot1, slot6)
			end
		end
	end
end

function slot0.getStackedCount(slot0, slot1, slot2)
	if not slot0:buffIsStackerBuff(lua_skill_buff.configDict[slot2.buffId]) then
		return 1
	end

	if FightDataHelper.entityMgr:getById(slot1) and slot4:getBuffDic() then
		for slot11, slot12 in pairs(slot5) do
			if FightBuffHelper.getBuffMoSignKey(slot2) == FightBuffHelper.getBuffMoSignKey(slot12) then
				if slot12.layer and slot12.layer ~= 0 then
					slot7 = 0 + 1 + slot12.layer - 1
				end
			end
		end

		return slot7
	end

	return 1
end

slot0.instance = slot0.New()

return slot0
