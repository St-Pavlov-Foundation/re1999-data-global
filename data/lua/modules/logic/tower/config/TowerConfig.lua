module("modules.logic.tower.config.TowerConfig", package.seeall)

slot0 = class("TowerConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.TowerConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"tower_const",
		"tower_permanent_time",
		"tower_permanent_episode",
		"tower_mop_up",
		"tower_boss",
		"tower_boss_time",
		"tower_task",
		"tower_limited_time",
		"tower_boss_episode",
		"tower_limited_episode",
		"tower_assist_talent",
		"tower_assist_boss",
		"tower_assist_develop",
		"tower_assist_attribute"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("on%sLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot0.ontower_assist_attributeLoaded(slot0, slot1)
	slot0.towerAssistAttrbuteConfig = slot1
end

function slot0.ontower_limited_episodeLoaded(slot0, slot1)
	slot0.towerLimitedEpisodeConfig = slot1

	slot0:buildTowerLimitedTimeCo()
end

function slot0.buildTowerLimitedTimeCo(slot0)
	slot0.limitEpisodeCoMap = {}

	for slot5, slot6 in ipairs(slot0.towerLimitedEpisodeConfig.configList) do
		if not slot0.limitEpisodeCoMap[slot6.season] then
			slot0.limitEpisodeCoMap[slot6.season] = {}
		end

		if not slot7[slot6.entrance] then
			slot7[slot6.entrance] = {}
		end

		table.insert(slot7[slot6.entrance], slot6)
	end
end

function slot0.ontower_limited_timeLoaded(slot0, slot1)
	slot0.towerLimitedTimeConfig = slot1
end

function slot0.ontower_taskLoaded(slot0, slot1)
	slot0.taskConfig = slot1
end

function slot0.ontower_boss_timeLoaded(slot0, slot1)
	slot0.bossTimeConfig = slot1
end

function slot0.ontower_constLoaded(slot0, slot1)
	slot0.towerConstConfig = slot1
end

function slot0.ontower_bossLoaded(slot0, slot1)
	slot0.bossTowerConfig = slot1
end

function slot0.ontower_boss_episodeLoaded(slot0, slot1)
	slot0.bossTowerEpisodeConfig = slot1
end

function slot0.ontower_assist_talentLoaded(slot0, slot1)
	slot0.assistTalentConfig = slot1
end

function slot0.ontower_permanent_timeLoaded(slot0, slot1)
	slot0.towerPermanentTimeConfig = slot1
end

function slot0.ontower_assist_bossLoaded(slot0, slot1)
	slot0.towerAssistBossConfig = slot1
end

function slot0.ontower_assist_developLoaded(slot0, slot1)
	slot0.towerAssistDevelopConfig = slot1
end

function slot0.ontower_permanent_episodeLoaded(slot0, slot1)
	slot0.towerPermanentEpisodeConfig = slot1

	slot0:buildPermanentEpisodeList()
end

function slot0.buildPermanentEpisodeList(slot0)
	slot0.permanentEpisodeList = {}

	for slot4, slot5 in ipairs(slot0.towerPermanentEpisodeConfig.configList) do
		if not slot0.permanentEpisodeList[slot5.stageId] then
			slot0.permanentEpisodeList[slot5.stageId] = {}
		end

		table.insert(slot0.permanentEpisodeList[slot5.stageId], slot5)
	end

	for slot4, slot5 in pairs(slot0.permanentEpisodeList) do
		table.sort(slot5, function (slot0, slot1)
			return slot0.layerId < slot1.layerId
		end)
	end
end

function slot0.ontower_mop_upLoaded(slot0, slot1)
	slot0.towerMopUpConfig = slot1
end

function slot0.getBossTimeTowerConfig(slot0, slot1, slot2)
	return slot0.bossTimeConfig.configDict[slot1] and slot3[slot2]
end

function slot0.getAssistTalentConfig(slot0)
	return slot0.assistTalentConfig
end

function slot0.getBossTowerConfig(slot0, slot1)
	return slot0.bossTowerConfig.configDict[slot1]
end

function slot0.getPermanentEpisodeCo(slot0, slot1)
	return slot0.towerPermanentEpisodeConfig.configDict[slot1]
end

function slot0.getPermanentEpisodeStageCoList(slot0, slot1)
	return slot0.permanentEpisodeList[slot1]
end

function slot0.getPermanentEpisodeLayerCo(slot0, slot1, slot2)
	if not slot0:getPermanentEpisodeStageCoList(slot1) or tabletool.len(slot3) == 0 then
		logError("该阶段数据不存在，请检查: stageId:" .. tostring(slot1))

		return
	end

	return slot3[slot2]
end

function slot0.getTowerPermanentTimeCo(slot0, slot1)
	return slot0.towerPermanentTimeConfig.configDict[slot1]
end

function slot0.getTowerPermanentTimeCoList(slot0)
	return slot0.towerPermanentTimeConfig.configList
end

function slot0.getAssistBossList(slot0)
	return slot0.towerAssistBossConfig.configList
end

function slot0.getAssistBossConfig(slot0, slot1)
	return slot0.towerAssistBossConfig.configDict[slot1]
end

function slot0.getAssistDevelopConfig(slot0, slot1, slot2)
	return slot0.towerAssistDevelopConfig.configDict[slot1] and slot3[slot2]
end

function slot0.getAssistBossMaxLev(slot0, slot1)
	if not slot0._bossLevDict then
		slot0._bossLevDict = {}
	end

	if not slot0._bossLevDict[slot1] then
		for slot7, slot8 in pairs(slot0.towerAssistDevelopConfig.configDict[slot1]) do
			if 0 < slot7 then
				slot2 = slot7
			end
		end

		slot0._bossLevDict[slot1] = slot2
	end

	return slot0._bossLevDict[slot1]
end

function slot0.getMaxMopUpConfigByLayerId(slot0, slot1)
	slot3 = nil

	for slot7, slot8 in ipairs(slot0.towerMopUpConfig.configList) do
		if slot8.layerNum <= slot1 then
			slot3 = slot8
		else
			break
		end
	end

	return slot3
end

function slot0.getTowerMopUpCo(slot0, slot1)
	return slot0.towerMopUpConfig.configDict[slot1]
end

function slot0.getTowerConstConfig(slot0, slot1)
	return slot0.towerConstConfig.configDict[slot1] and slot0.towerConstConfig.configDict[slot1].value
end

function slot0.getTowerMopUpCoList(slot0)
	return slot0.towerMopUpConfig.configList
end

function slot0.getBossTowerIdByEpisodeId(slot0, slot1)
	if slot0._episodeId2BossTowerIdDict == nil then
		slot0._episodeId2BossTowerIdDict = {}

		for slot6, slot7 in ipairs(slot0.bossTowerEpisodeConfig.configList) do
			slot0._episodeId2BossTowerIdDict[slot7.episodeId] = slot7.towerId
		end
	end

	return slot0._episodeId2BossTowerIdDict[slot1]
end

function slot0.getBossTowerEpisodeConfig(slot0, slot1, slot2)
	return slot0.bossTowerEpisodeConfig.configDict[slot1][slot2]
end

function slot0.getBossTowerEpisodeCoList(slot0, slot1)
	slot2 = slot0.bossTowerEpisodeConfig.configDict[slot1]

	table.sort(slot2, function (slot0, slot1)
		return slot0.layerId < slot1.layerId
	end)

	return slot2
end

function slot0.getTaskListByGroupId(slot0, slot1)
	if slot0._groupId2TaskListDict == nil then
		slot0._groupId2TaskListDict = {}

		for slot6, slot7 in ipairs(slot0.taskConfig.configList) do
			if not slot0._groupId2TaskListDict[slot7.taskGroupId] then
				slot0._groupId2TaskListDict[slot7.taskGroupId] = {}
			end

			table.insert(slot0._groupId2TaskListDict[slot7.taskGroupId], slot7.id)
		end
	end

	return slot0._groupId2TaskListDict[slot1]
end

function slot0.getTowerBossTimeCoByTaskGroupId(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.bossTimeConfig.configList) do
		if slot7.taskGroupId == slot1 then
			return slot7
		end
	end
end

function slot0.getTowerLimitedCoByTaskGroupId(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getAllTowerLimitedTimeCoList()) do
		if slot7.taskGroupId == slot1 then
			return slot7
		end
	end
end

function slot0.getAllTowerLimitedTimeCoList(slot0)
	return slot0.towerLimitedTimeConfig.configList
end

function slot0.getTowerLimitedTimeCo(slot0, slot1)
	return slot0.towerLimitedTimeConfig.configDict[slot1]
end

function slot0.getTowerTaskConfig(slot0, slot1)
	return slot0.taskConfig.configDict[slot1]
end

function slot0.getTowerLimitedTimeCoList(slot0, slot1, slot2)
	return slot0.limitEpisodeCoMap[slot1] and slot0.limitEpisodeCoMap[slot1][slot2]
end

function slot0.getTowerLimitedTimeCoByEpisodeId(slot0, slot1, slot2, slot3)
	for slot8, slot9 in ipairs(slot0:getTowerLimitedTimeCoList(slot1, slot2)) do
		if slot9.episodeId == slot3 then
			return slot9
		end
	end
end

function slot0.getTowerLimitedTimeCoByDifficulty(slot0, slot1, slot2, slot3)
	for slot8, slot9 in ipairs(slot0:getTowerLimitedTimeCoList(slot1, slot2)) do
		if slot9.difficulty == slot3 then
			return slot9
		end
	end
end

function slot0.getPassiveSKills(slot0, slot1)
	if slot0.bossPassiveSkillDict == nil then
		slot0.bossPassiveSkillDict = {}
	end

	if not slot0.bossPassiveSkillDict[slot1] then
		slot0.bossPassiveSkillDict[slot1] = {}

		table.insert(slot0.bossPassiveSkillDict[slot1], string.splitToNumber(uv0.instance:getAssistBossConfig(slot1).passiveSkills, "#"))
		slot0:getPassiveSkillActiveLev(slot1, 0)

		slot5 = {}

		for slot9, slot10 in pairs(slot0.bossPassiveSkillLevDict[slot1]) do
			table.insert(slot5, {
				skillId = slot9,
				lev = slot10
			})
		end

		if #slot5 > 1 then
			table.sort(slot5, SortUtil.keyLower("lev"))
		end

		for slot9, slot10 in ipairs(slot5) do
			table.insert(slot0.bossPassiveSkillDict[slot1], {
				slot10.skillId
			})
		end
	end

	return slot0.bossPassiveSkillDict[slot1]
end

function slot0.getPassiveSkillActiveLev(slot0, slot1, slot2)
	if slot0.bossPassiveSkillLevDict == nil then
		slot0.bossPassiveSkillLevDict = {}
	end

	if not slot0.bossPassiveSkillLevDict[slot1] then
		slot0.bossPassiveSkillLevDict[slot1] = {}

		if slot0.towerAssistDevelopConfig.configDict[slot1] then
			slot5 = slot3[1]

			while slot5 do
				if not string.nilorempty(slot5.passiveSkills) then
					for slot10, slot11 in ipairs(string.splitToNumber(slot5.passiveSkills, "#")) do
						slot0.bossPassiveSkillLevDict[slot1][slot11] = slot4
					end
				end

				if not string.nilorempty(slot5.extraRule) then
					for slot10, slot11 in ipairs(GameUtil.splitString2(slot5.extraRule, true)) do
						slot0.bossPassiveSkillLevDict[slot1][slot11[2]] = slot4
					end
				end

				slot5 = slot3[slot4 + 1]
			end
		end
	end

	return slot0.bossPassiveSkillLevDict[slot1][slot2] or 0
end

function slot0.isSkillActive(slot0, slot1, slot2, slot3)
	return slot0:getPassiveSkillActiveLev(slot1, slot2) <= slot3
end

function slot0.getAssistAttribute(slot0, slot1, slot2)
	return slot0.towerAssistAttrbuteConfig.configDict[slot1] and slot3[slot2]
end

function slot0.getBossAddAttr(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in pairs(slot0:getBossAddAttrDict(slot1, slot2)) do
		table.insert(slot4, {
			key = slot8,
			val = slot9
		})
	end

	if #slot4 > 0 then
		table.sort(slot4, SortUtil.keyLower("key"))
	end

	return slot4
end

function slot0.getBossAddAttrDict(slot0, slot1, slot2)
	slot4 = {}

	for slot8 = 1, slot2 or 0 do
		if uv0.instance:getAssistDevelopConfig(slot1, slot8) and GameUtil.splitString2(slot9.attribute, true) then
			for slot14, slot15 in pairs(slot10) do
				if slot4[slot15[1]] == nil then
					slot4[slot15[1]] = slot15[2]
				else
					slot4[slot15[1]] = slot4[slot15[1]] + slot15[2]
				end
			end
		end
	end

	return slot4
end

function slot0.getHeroGroupAddAttr(slot0, slot1, slot2, slot3)
	slot4 = uv0.instance:getAssistAttribute(slot1, slot2)
	slot6 = {}

	for slot10, slot11 in pairs(TowerEnum.AttrKey) do
		slot14 = slot4 and slot4[slot11]

		if (slot0:getBossAddAttrDict(slot1, slot3)[TowerEnum.AttrKey2AttrId[slot11]] or 0) > 0 or slot14 ~= nil then
			table.insert(slot6, {
				key = slot12,
				val = slot14,
				add = slot13,
				upAttr = TowerEnum.UpAttrId[slot11] ~= nil
			})
		end
	end

	if #slot6 > 0 then
		table.sort(slot6, SortUtil.keyLower("key"))
	end

	return slot6
end

function slot0.getLimitEpisodeConfig(slot0, slot1, slot2)
	return slot0.towerLimitedEpisodeConfig.configDict[slot1] and slot3[slot2]
end

function slot0.setTalentImg(slot0, slot1, slot2, slot3)
	slot4 = nil

	UISpriteSetMgr.instance:setTowerSprite(slot1, (slot2.isBigNode ~= 1 or string.format("towertalent_branchbigskill_%s", slot2.nodeType)) and string.format("towertalent_branchskill_%s", slot2.nodeType), slot3)
end

slot0.instance = slot0.New()

return slot0
