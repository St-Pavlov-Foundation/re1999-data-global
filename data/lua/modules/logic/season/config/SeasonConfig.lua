module("modules.logic.season.config.SeasonConfig", package.seeall)

slot0 = class("SeasonConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity104_episode",
		"activity104_const",
		"activity104_retail",
		"activity104_special",
		"activity104_equip",
		"activity104_equip_attr",
		"activity104_equip_tag",
		"activity104_trial"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity104_episode" then
		slot0._episodeConfig = slot2
	elseif slot1 == "activity104_const" then
		slot0._constConfig = slot2
	elseif slot1 == "activity104_retail" then
		slot0._retailConfig = slot2
	elseif slot1 == "activity104_special" then
		slot0._specialConfig = slot2
	elseif slot1 == "activity104_equip" then
		slot0._equipConfig = slot2

		slot0:preprocessEquip()
	elseif slot1 == "activity104_equip_tag" then
		slot0._equipTagConfig = slot2
	elseif slot1 == "activity104_equip_attr" then
		slot0._equipAttrConfig = slot2
	elseif slot1 == "activity104_equip_attr" then
		slot0._equipAttrConfig = slot2
	elseif slot1 == "activity104_trial" then
		slot0._trialConfig = slot2
	end
end

function slot0.getTrialConfig(slot0, slot1, slot2)
	return slot0._trialConfig.configDict[slot1] and slot0._trialConfig.configDict[slot1][slot2]
end

function slot0.preprocessEquip(slot0)
	slot0._equipIsOptionalDict = {}

	for slot4, slot5 in pairs(slot0._equipConfig.configList) do
		if slot5.isOptional == 1 then
			slot0._equipIsOptionalDict[slot5.equipId] = true
		end
	end
end

function slot0.getSeasonEpisodeCos(slot0, slot1)
	return slot0._episodeConfig.configDict[slot1]
end

function slot0.getSeasonEpisodeCo(slot0, slot1, slot2)
	return slot0._episodeConfig.configDict[slot1][slot2]
end

function slot0.getSeasonConstCo(slot0, slot1, slot2)
	if not (slot0._constConfig.configDict[slot1] and slot3[slot2]) then
		logError(string.format("const no exist seasonid:%s constid:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getSeasonRetailCos(slot0, slot1)
	return slot0._retailConfig.configDict[slot1]
end

function slot0.getSeasonRetailCo(slot0, slot1, slot2)
	return slot0._retailConfig.configDict[slot1][slot2]
end

function slot0.getSeasonSpecialCos(slot0, slot1)
	return slot0._specialConfig.configDict[slot1]
end

function slot0.getSeasonSpecialCo(slot0, slot1, slot2)
	return slot0._specialConfig.configDict[slot1][slot2]
end

function slot0.getSeasonEquipCos(slot0)
	return slot0._equipConfig.configDict
end

function slot0.getSeasonEquipCo(slot0, slot1)
	return slot0._equipConfig.configDict[slot1]
end

function slot0.getSeasonOptionalEquipCos(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._equipConfig.configDict) do
		if slot6.isOptional == 1 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getSeasonTagDict(slot0, slot1)
	return slot0._equipTagConfig.configDict[slot1]
end

function slot0.getSeasonTagDesc(slot0, slot1, slot2)
	if not (slot0:getSeasonTagDict(slot1) and slot3[slot2]) then
		logError(string.format("not tag config seasonId:%s tagId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getEquipIsOptional(slot0, slot1)
	return slot0._equipIsOptionalDict[slot1]
end

function slot0.getEquipCoByCondition(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._equipConfig.configList) do
		if slot1(slot7) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getSeasonEquipAttrCo(slot0, slot1)
	return slot0._equipAttrConfig.configDict[slot1]
end

function slot0.getConfigByEpisodeId(slot0, slot1)
	slot0:_initEpisodeId2Config()

	return slot0._episodeId2Config and slot0._episodeId2Config[slot1]
end

function slot0._initEpisodeId2Config(slot0)
	if slot0._episodeId2Config then
		return
	end

	slot0._episodeId2Config = {}

	for slot4, slot5 in pairs(slot0._episodeConfig.configDict) do
		slot0._episodeId2Config[slot5.episodeId] = slot5
	end
end

function slot0.getStoryIds(slot0, slot1)
	return {
		slot0:getSeasonConstCo(slot1, Activity104Enum.ConstEnum.SeasonOpenStorys).value1
	}
end

function slot0.getRetailTicket(slot0, slot1)
	return slot0:getSeasonConstCo(slot1, Activity104Enum.ConstEnum.RetailTicket).value1
end

function slot0.getRuleTips(slot0, slot1)
	return string.splitToNumber(slot0:getSeasonConstCo(slot1, Activity104Enum.ConstEnum.RuleTips).value2, "#")
end

function slot0.isExistInRuleTips(slot0, slot1, slot2)
	if not slot0._ruleDict then
		slot0._ruleDict = {}
	end

	if not slot0._ruleDict[slot1] then
		slot0._ruleDict[slot1] = {}

		if slot0:getRuleTips(slot1) then
			for slot7, slot8 in pairs(slot3) do
				slot0._ruleDict[slot1][slot8] = true
			end
		end
	end

	return slot0._ruleDict[slot1][slot2] ~= nil
end

function slot0.filterRule(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot7, slot8 in pairs(slot1) do
			if not slot0:isExistInRuleTips(Activity104Model.instance:getCurSeasonId(), slot8[2]) then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
