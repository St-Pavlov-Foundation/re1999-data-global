module("modules.logic.versionactivity1_6.act148.config.Activity148Config", package.seeall)

slot0 = class("Activity148Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._cfgDict = {}
	slot0._activityConstDict = {}
	slot0._skillTypeCfgDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity148",
		"activity148_const",
		"activity148_skill_type"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity148" then
		slot0:initAct148CfgDict(slot2)
	elseif slot1 == "activity148_const" then
		slot0._activityConstDict = slot2.configDict
	elseif slot1 == "activity148_skill_type" then
		slot0._skillTypeCfgDict = slot2.configDict
	end
end

function slot0.initAct148CfgDict(slot0, slot1)
	slot0._cfgDict = slot1.configDict
	slot0._skillTypeDict = {}

	for slot5, slot6 in pairs(slot0._cfgDict) do
		if not slot0._skillTypeDict[slot6.type] then
			slot0._skillTypeDict[slot7] = {}
		end

		slot0._skillTypeDict[slot7][slot6.level] = slot6
	end
end

function slot0.getAct148Cfg(slot0, slot1)
	return slot0._cfgDict[slot1]
end

function slot0.getAct148CfgByTypeLv(slot0, slot1, slot2)
	if not slot2 or not slot1 then
		return nil
	end

	return slot0._skillTypeDict[slot1] and slot3[slot2]
end

function slot0.getAct148ConstValue(slot0, slot1, slot2)
	return slot0._activityConstDict[slot2][slot1].value
end

function slot0.getAct148CfgDictByType(slot0, slot1)
	if not slot1 then
		return nil
	end

	return slot0._skillTypeDict[slot1]
end

function slot0.getAct148SkillTypeCfg(slot0, slot1)
	if not slot1 then
		return nil
	end

	return slot0._skillTypeCfgDict[slot1]
end

function slot0.getAct148SkillPointCost(slot0, slot1, slot2)
	if slot2 == 0 then
		return 0
	end

	if not slot0._skillTypeDict[slot1] then
		return slot3
	end

	for slot8 = 1, slot2 do
		slot3 = slot3 + string.splitToNumber(slot4[slot8].cost, "#")[3]
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
