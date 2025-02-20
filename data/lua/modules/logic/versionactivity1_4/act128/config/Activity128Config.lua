module("modules.logic.versionactivity1_4.act128.config.Activity128Config", package.seeall)

slot0 = class("Activity128Config", BaseConfig)

function slot0.ctor(slot0, slot1)
	slot0.__activityId = slot1
end

function slot0.reqConfigNames(slot0)
	return {
		"activity128_stage",
		"activity128_episode",
		"activity128_rewards",
		"activity128_task",
		"activity128_countboss",
		"activity128_const",
		"activity128_assess",
		"activity128_evaluate",
		"activity128_enhance",
		"monster_group",
		"monster",
		"monster_template",
		"battle",
		"episode",
		"skin"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity128_stage" then
		-- Nothing
	elseif slot1 == "activity128_episode" then
		-- Nothing
	elseif slot1 == "activity128_rewards" then
		slot0:__getOrCreateStageRewardList()
	elseif slot1 == "activity128_task" then
		slot0:__getOrCreateTaskList()
		slot0:_initActLayer4rewards()
	elseif slot1 == "activity128_countboss" then
		-- Nothing
	elseif slot1 == "activity128_const" then
		-- Nothing
	elseif slot1 == "activity128_evaluate" then
		-- Nothing
	elseif slot1 == "activity128_enhance" then
		-- Nothing
	end
end

function slot1(slot0)
	return lua_scene_level.configDict[slot0]
end

function slot2(slot0)
	return uv0(slot0).resName
end

function slot3(slot0)
	return lua_battle.configDict[slot0]
end

function slot4(slot0)
	return uv0(slot0).monsterGroupIds
end

function slot5(slot0)
	return lua_monster_group.configDict[slot0]
end

function slot6(slot0)
	return lua_monster.configDict[slot0]
end

function slot7(slot0)
	return lua_episode.configDict[slot0]
end

function slot8(slot0)
	return lua_monster_template.configDict[slot0]
end

function slot9(slot0)
	return uv0(slot0.template)
end

function slot10(slot0)
	return uv1(uv0(slot0))
end

function slot11(slot0)
	return lua_activity128_stage.configDict[slot0]
end

function slot12(slot0, slot1)
	return lua_activity128_stage.configDict[slot0][slot1]
end

function slot13(slot0, slot1)
	return lua_activity128_episode.configDict[slot0][slot1]
end

function slot14(slot0, slot1, slot2)
	return lua_activity128_episode.configDict[slot0][slot1][slot2]
end

function slot15(slot0, slot1, slot2)
	return lua_activity128_episode.configDict[slot0][slot1][slot2]
end

function slot16(slot0)
	return lua_activity128_countboss.configDict[slot0]
end

function slot17(slot0)
	return lua_activity128_evaluate.configDict[slot0]
end

function slot0.__getOrCreateStageRewardList(slot0)
	slot1 = slot0.__activityId

	if slot0.__cumulativeRewards then
		return slot0.__cumulativeRewards
	end

	slot0.__cumulativeRewards = {}

	if lua_activity128_rewards.configDict[slot1] then
		for slot6, slot7 in pairs(lua_activity128_rewards.configDict[slot1]) do
			if not slot2[slot7.stage] then
				slot2[slot8] = {}
			end

			table.insert(slot2[slot8], slot7)
		end
	end

	for slot6, slot7 in pairs(slot2) do
		table.sort(slot7, function (slot0, slot1)
			if slot0.rewardPointNum ~= slot1.rewardPointNum then
				return slot0.rewardPointNum < slot1.rewardPointNum
			end

			return slot0.id < slot1.id
		end)
	end

	return slot2
end

function slot0.__getOrCreateTaskList(slot0)
	slot1 = slot0.__activityId

	if slot0.__taskList then
		return slot0.__taskList
	end

	slot0.__taskList = {}

	for slot6, slot7 in ipairs(lua_activity128_task.configList) do
		if slot7.isOnline and slot1 == slot7.activityId and slot7.totalTaskType == 0 then
			slot2[#slot2 + 1] = slot7
		end
	end

	return slot2
end

function slot0.getStageRewardList(slot0, slot1)
	slot0:__getOrCreateStageRewardList()

	return slot0.__cumulativeRewards[slot1]
end

function slot0.getAllTaskList(slot0)
	return slot0:__getOrCreateTaskList()
end

function slot0.getTaskCO(slot0, slot1)
	return lua_activity128_task.configDict[slot1]
end

function slot0.getStages(slot0)
	return uv0(slot0.__activityId)
end

function slot0.getStageCO(slot0, slot1)
	return uv0(slot0.__activityId, slot1)
end

function slot0.getStageCOMaxPoints(slot0, slot1)
	slot2 = slot0:getStageRewardList(slot1)

	return slot2[#slot2].rewardPointNum
end

function slot0.getEpisodeStages(slot0, slot1)
	return uv0(slot0.__activityId, slot1)
end

function slot0.getEpisodeCO(slot0, slot1, slot2)
	return uv0(slot0.__activityId, slot1, slot2)
end

function slot0.getDungeonEpisodeId(slot0, slot1, slot2)
	return slot0:getEpisodeCO(slot1, slot2).episodeId
end

function slot0.getDungeonEpisodeCO(slot0, slot1, slot2)
	return uv0(slot0:getDungeonEpisodeId(slot1, slot2))
end

function slot0.getDungeonBattleId(slot0, slot1, slot2)
	return slot0:getDungeonEpisodeCO(slot1, slot2).battleId
end

function slot0.getDungeonBattleCO(slot0, slot1, slot2)
	return uv0(slot0:getDungeonBattleId(slot1, slot2))
end

function slot0.getDungeonBattleScenceIds(slot0, slot1, slot2)
	return slot0:getDungeonBattleCO(slot1, slot2).sceneIds
end

function slot0.getAchievementTaskCO(slot0, slot1, slot2)
	return uv0(slot0.__activityId, slot1, slot2)
end

function slot0.isInfinite(slot0, slot1, slot2)
	return slot0:getEpisodeCO(slot1, slot2).type == 1
end

function slot0.getStageCOOpenDay(slot0, slot1)
	return slot0:getStageCO(slot1).openDay
end

function slot0.getEpisodeCOOpenDay(slot0, slot1)
	if slot0:getEpisodeStages(slot1) then
		slot3, slot4 = next(slot2)

		if slot3 then
			return slot4.openDay
		end
	end
end

function slot0.getBattleCOByASL(slot0, slot1, slot2)
	return uv0(slot0:getDungeonBattleId(slot1, slot2))
end

function slot0.getMonsterGroupBossId(slot0, slot1)
	return uv0(slot1).bossId
end

function slot0.getBattleMaxPoints(slot0, slot1, slot2)
	return uv0(slot0:getDungeonBattleId(slot1, slot2)).maxPoints
end

function slot0.getFinalMonsterId(slot0, slot1, slot2)
	return tonumber(uv0(slot0:getDungeonBattleId(slot1, slot2)).finalMonsterId)
end

function slot0.getDungeonBattleSceneResName(slot0, slot1, slot2)
	return uv1(string.splitToNumber(uv0(slot0:getDungeonBattleId(slot1, slot2)).sceneIds, "#")[1])
end

function slot0.getDungeonBattleMonsterSkinCOs(slot0, slot1, slot2)
	slot9 = {}

	for slot13, slot14 in ipairs(string.splitToNumber(uv1(string.splitToNumber(uv0(slot0:getDungeonBattleId(slot1, slot2)), "#")[1]).monster, "#")) do
		slot9[#slot9 + 1] = FightConfig.instance:getSkinCO(uv2(slot14).skinId)
	end

	return slot9
end

function slot0.getConst(slot0, slot1)
	slot2 = lua_activity128_const.configDict[slot1]

	return slot2.value1, slot2.value2
end

function slot0.tryGetStageAndLayerByEpisodeId(slot0, slot1)
	for slot5, slot6 in ipairs(lua_activity128_episode.configList) do
		if slot6.episodeId == slot1 then
			return slot6.stage, slot6.layer
		end
	end
end

function slot0.tryGetStageNextLayer(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:getEpisodeStages(slot1)) do
		if slot2 + 1 == slot8.layer then
			return slot9
		end
	end
end

function slot0.getEvaluateConfig(slot0, slot1)
	return uv0(slot1)
end

slot18 = {
	GEqual_1Day = 1,
	GEqual_1Hour = 2,
	GEqual_1Second = 4,
	GEqual_1Min = 3
}
slot0.ETimeFmtStyle = {
	Default = {
		[slot18.GEqual_1Day] = "v1a4_bossrushleveldetail_remain_days_hours",
		[slot18.GEqual_1Hour] = "v1a4_bossrushleveldetail_remain_hours",
		[slot18.GEqual_1Min] = "v1a4_bossrushleveldetail_remain_mins",
		[slot18.GEqual_1Second] = "v1a4_bossrushleveldetail_remain_1min"
	},
	UnLock = {
		[slot18.GEqual_1Day] = "v1a4_bossrushleveldetail_unlock_days_hours",
		[slot18.GEqual_1Hour] = "v1a4_bossrushleveldetail_unlock_hours",
		[slot18.GEqual_1Min] = "v1a4_bossrushleveldetail_unlock_mins",
		[slot18.GEqual_1Second] = "v1a4_bossrushleveldetail_unlock_1min"
	}
}

function slot0.getRemainTimeStrWithFmt(slot0, slot1, slot2)
	slot3, slot4, slot5, slot6 = TimeUtil.secondsToDDHHMMSS(slot1)

	if slot3 >= 1 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang((slot2 or uv0.ETimeFmtStyle.Default)[uv1.GEqual_1Day]), {
			slot3,
			slot4
		})
	end

	if slot4 >= 1 then
		return formatLuaLang(slot2[uv1.GEqual_1Hour], slot4)
	end

	if slot5 >= 1 then
		return formatLuaLang(slot2[uv1.GEqual_1Min], slot5)
	end

	return luaLang(slot2[uv1.GEqual_1Second])
end

function slot0.getRemainTimeStr(slot0, slot1, slot2)
	return slot0:getRemainTimeStrWithFmt(slot1 - ServerTime.now(), slot2)
end

function slot0.checkActivityId(slot0, slot1)
	return slot0.__activityId == slot1
end

function slot0.getActivityId(slot0)
	return slot0.__activityId
end

function slot0.getActRoleEnhance(slot0)
	return lua_activity128_enhance.configDict[slot0.__activityId]
end

function slot0._initActLayer4rewards(slot0)
	slot0.layer4Rewards = {}

	for slot4, slot5 in ipairs(lua_activity128_task.configList) do
		if slot5.totalTaskType == 1 then
			if not slot0.layer4Rewards[slot5.activityId] then
				slot0.layer4Rewards[slot5.activityId] = {}
			end

			if not slot6[slot5.stage] then
				slot6[slot5.stage] = {}
			end

			table.insert(slot7, slot5)
		end
	end
end

function slot0.getActLayer4rewards(slot0, slot1)
	if slot0.layer4Rewards[slot0.__activityId] then
		return slot0.layer4Rewards[slot0.__activityId][slot1]
	end

	return {}
end

return slot0
