module("modules.logic.fight.config.StressConfig", package.seeall)

slot0 = class("StressConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"stress_const",
		"stress",
		"stress_rule",
		"stress_identity"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "stress" then
		slot0:buildStressConfig(slot2)
	elseif slot1 == "stress_identity" then
		slot0:buildStressIdentityConfig(slot2)
	end
end

function slot0.buildStressConfig(slot0, slot1)
	slot0.identity2Stress = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if not slot0.identity2Stress[slot6.identity] then
			slot0.identity2Stress[slot7] = {}
		end

		if not slot8[slot6.type] then
			slot8[slot9] = {}
		end

		table.insert(slot10, slot6)
	end
end

function slot0.buildStressIdentityConfig(slot0, slot1)
	slot0.identityType2List = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if not slot0.identityType2List[slot6.identity] then
			slot0.identityType2List[slot7] = {}
		end

		table.insert(slot8, slot6)
	end
end

function slot0.getStressDict(slot0, slot1)
	return tonumber(slot1) and slot0.identity2Stress[slot1]
end

function slot0.getStressBehaviourName(slot0, slot1)
	if not slot0.behaviour2ConstId then
		slot0.behaviour2ConstId = {
			[FightEnum.StressBehaviour.Positive] = 12,
			[FightEnum.StressBehaviour.Negative] = 13,
			[FightEnum.StressBehaviour.Meltdown] = 14,
			[FightEnum.StressBehaviour.Resolute] = 15,
			[FightEnum.StressBehaviour.BaseAdd] = 17,
			[FightEnum.StressBehaviour.BaseReduce] = 18,
			[FightEnum.StressBehaviour.BaseResolute] = 19,
			[FightEnum.StressBehaviour.BaseMeltdown] = 20
		}
	end

	if not slot0.behaviour2ConstId[slot1] then
		logError("不支持的压力行为:" .. tostring(slot1))

		return ""
	end

	return lua_stress_const.configDict[slot2] and slot3.value2
end

function slot0.getHeroIdentityList(slot0, slot1)
	slot0.tempIdentityList = slot0.tempIdentityList or {}

	tabletool.clear(slot0.tempIdentityList)

	for slot7, slot8 in ipairs(slot0.identityType2List[FightEnum.IdentityType.Career]) do
		if tonumber(slot8.typeParam) == slot1.career then
			table.insert(slot0.tempIdentityList, slot8)
		end
	end

	for slot9, slot10 in ipairs(slot0.identityType2List[FightEnum.IdentityType.HeroType]) do
		if tonumber(slot10.typeParam) == slot1.heroType then
			table.insert(slot0.tempIdentityList, slot10)
		end
	end

	slot7 = slot0.identityType2List[FightEnum.IdentityType.BattleTag]

	for slot11, slot12 in ipairs(string.split(slot1.battleTag, "#")) do
		for slot16, slot17 in ipairs(slot7) do
			if slot17.typeParam == slot12 then
				table.insert(slot0.tempIdentityList, slot17)

				break
			end
		end
	end

	for slot13, slot14 in ipairs(slot0.identityType2List[FightEnum.IdentityType.HeroId]) do
		if tonumber(slot14.typeParam) == slot1.id then
			table.insert(slot0.tempIdentityList, slot14)
		end
	end

	return slot0.tempIdentityList
end

function slot0.getHeroIdentityText(slot0, slot1)
	for slot7, slot8 in ipairs(slot0:getHeroIdentityList(slot1)) do
		if slot8.isNoShow ~= 1 then
			slot3 = "" .. string.format("<color=#d2c197><link=%s><u><%s></u></link></color>", slot8.id, slot8.name)
		end
	end

	return slot3
end

function slot0.getHeroTip(slot0)
	return lua_stress_const.configDict[16].value2
end

slot0.instance = slot0.New()

return slot0
