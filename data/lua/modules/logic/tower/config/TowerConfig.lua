module("modules.logic.tower.config.TowerConfig", package.seeall)

local var_0_0 = class("TowerConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.TowerConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
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

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("on%sLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.ontower_assist_attributeLoaded(arg_4_0, arg_4_1)
	arg_4_0.towerAssistAttrbuteConfig = arg_4_1
end

function var_0_0.ontower_limited_episodeLoaded(arg_5_0, arg_5_1)
	arg_5_0.towerLimitedEpisodeConfig = arg_5_1

	arg_5_0:buildTowerLimitedTimeCo()
end

function var_0_0.buildTowerLimitedTimeCo(arg_6_0)
	arg_6_0.limitEpisodeCoMap = {}

	local var_6_0 = arg_6_0.towerLimitedEpisodeConfig.configList

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = arg_6_0.limitEpisodeCoMap[iter_6_1.season]

		if not var_6_1 then
			var_6_1 = {}
			arg_6_0.limitEpisodeCoMap[iter_6_1.season] = var_6_1
		end

		if not var_6_1[iter_6_1.entrance] then
			var_6_1[iter_6_1.entrance] = {}
		end

		table.insert(var_6_1[iter_6_1.entrance], iter_6_1)
	end
end

function var_0_0.ontower_limited_timeLoaded(arg_7_0, arg_7_1)
	arg_7_0.towerLimitedTimeConfig = arg_7_1
end

function var_0_0.ontower_taskLoaded(arg_8_0, arg_8_1)
	arg_8_0.taskConfig = arg_8_1
end

function var_0_0.ontower_boss_timeLoaded(arg_9_0, arg_9_1)
	arg_9_0.bossTimeConfig = arg_9_1
end

function var_0_0.ontower_constLoaded(arg_10_0, arg_10_1)
	arg_10_0.towerConstConfig = arg_10_1
end

function var_0_0.ontower_bossLoaded(arg_11_0, arg_11_1)
	arg_11_0.bossTowerConfig = arg_11_1
end

function var_0_0.ontower_boss_episodeLoaded(arg_12_0, arg_12_1)
	arg_12_0.bossTowerEpisodeConfig = arg_12_1
end

function var_0_0.ontower_assist_talentLoaded(arg_13_0, arg_13_1)
	arg_13_0.assistTalentConfig = arg_13_1
end

function var_0_0.ontower_permanent_timeLoaded(arg_14_0, arg_14_1)
	arg_14_0.towerPermanentTimeConfig = arg_14_1
end

function var_0_0.ontower_assist_bossLoaded(arg_15_0, arg_15_1)
	arg_15_0.towerAssistBossConfig = arg_15_1
end

function var_0_0.ontower_assist_developLoaded(arg_16_0, arg_16_1)
	arg_16_0.towerAssistDevelopConfig = arg_16_1
end

function var_0_0.ontower_permanent_episodeLoaded(arg_17_0, arg_17_1)
	arg_17_0.towerPermanentEpisodeConfig = arg_17_1

	arg_17_0:buildPermanentEpisodeList()
end

function var_0_0.buildPermanentEpisodeList(arg_18_0)
	arg_18_0.permanentEpisodeList = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.towerPermanentEpisodeConfig.configList) do
		if not arg_18_0.permanentEpisodeList[iter_18_1.stageId] then
			arg_18_0.permanentEpisodeList[iter_18_1.stageId] = {}
		end

		table.insert(arg_18_0.permanentEpisodeList[iter_18_1.stageId], iter_18_1)
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0.permanentEpisodeList) do
		table.sort(iter_18_3, function(arg_19_0, arg_19_1)
			return arg_19_0.layerId < arg_19_1.layerId
		end)
	end
end

function var_0_0.ontower_mop_upLoaded(arg_20_0, arg_20_1)
	arg_20_0.towerMopUpConfig = arg_20_1
end

function var_0_0.getBossTimeTowerConfig(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.bossTimeConfig.configDict[arg_21_1]

	return var_21_0 and var_21_0[arg_21_2]
end

function var_0_0.getAssistTalentConfig(arg_22_0)
	return arg_22_0.assistTalentConfig
end

function var_0_0.getBossTowerConfig(arg_23_0, arg_23_1)
	return arg_23_0.bossTowerConfig.configDict[arg_23_1]
end

function var_0_0.getPermanentEpisodeCo(arg_24_0, arg_24_1)
	return arg_24_0.towerPermanentEpisodeConfig.configDict[arg_24_1]
end

function var_0_0.getPermanentEpisodeStageCoList(arg_25_0, arg_25_1)
	return arg_25_0.permanentEpisodeList[arg_25_1]
end

function var_0_0.getPermanentEpisodeLayerCo(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:getPermanentEpisodeStageCoList(arg_26_1)

	if not var_26_0 or tabletool.len(var_26_0) == 0 then
		logError("该阶段数据不存在，请检查: stageId:" .. tostring(arg_26_1))

		return
	end

	return var_26_0[arg_26_2]
end

function var_0_0.getTowerPermanentTimeCo(arg_27_0, arg_27_1)
	return arg_27_0.towerPermanentTimeConfig.configDict[arg_27_1]
end

function var_0_0.getTowerPermanentTimeCoList(arg_28_0)
	return arg_28_0.towerPermanentTimeConfig.configList
end

function var_0_0.getAssistBossList(arg_29_0)
	return arg_29_0.towerAssistBossConfig.configList
end

function var_0_0.getAssistBossConfig(arg_30_0, arg_30_1)
	return arg_30_0.towerAssistBossConfig.configDict[arg_30_1]
end

function var_0_0.getAssistDevelopConfig(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.towerAssistDevelopConfig.configDict[arg_31_1]

	return var_31_0 and var_31_0[arg_31_2]
end

function var_0_0.getAssistBossMaxLev(arg_32_0, arg_32_1)
	if not arg_32_0._bossLevDict then
		arg_32_0._bossLevDict = {}
	end

	if not arg_32_0._bossLevDict[arg_32_1] then
		local var_32_0 = 0
		local var_32_1 = arg_32_0.towerAssistDevelopConfig.configDict[arg_32_1]

		for iter_32_0, iter_32_1 in pairs(var_32_1) do
			if var_32_0 < iter_32_0 then
				var_32_0 = iter_32_0
			end
		end

		arg_32_0._bossLevDict[arg_32_1] = var_32_0
	end

	return arg_32_0._bossLevDict[arg_32_1]
end

function var_0_0.getMaxMopUpConfigByLayerId(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.towerMopUpConfig.configList
	local var_33_1

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		if arg_33_1 >= iter_33_1.layerNum then
			var_33_1 = iter_33_1
		else
			break
		end
	end

	return var_33_1
end

function var_0_0.getTowerMopUpCo(arg_34_0, arg_34_1)
	return arg_34_0.towerMopUpConfig.configDict[arg_34_1]
end

function var_0_0.getTowerConstConfig(arg_35_0, arg_35_1)
	return arg_35_0.towerConstConfig.configDict[arg_35_1] and arg_35_0.towerConstConfig.configDict[arg_35_1].value
end

function var_0_0.getTowerMopUpCoList(arg_36_0)
	return arg_36_0.towerMopUpConfig.configList
end

function var_0_0.getBossTowerIdByEpisodeId(arg_37_0, arg_37_1)
	if arg_37_0._episodeId2BossTowerIdDict == nil then
		arg_37_0._episodeId2BossTowerIdDict = {}

		local var_37_0 = arg_37_0.bossTowerEpisodeConfig.configList

		for iter_37_0, iter_37_1 in ipairs(var_37_0) do
			arg_37_0._episodeId2BossTowerIdDict[iter_37_1.episodeId] = iter_37_1.towerId
		end
	end

	return arg_37_0._episodeId2BossTowerIdDict[arg_37_1]
end

function var_0_0.getBossTowerEpisodeConfig(arg_38_0, arg_38_1, arg_38_2)
	return arg_38_0.bossTowerEpisodeConfig.configDict[arg_38_1][arg_38_2]
end

function var_0_0.getBossTowerEpisodeCoList(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.bossTowerEpisodeConfig.configDict[arg_39_1]

	table.sort(var_39_0, function(arg_40_0, arg_40_1)
		return arg_40_0.layerId < arg_40_1.layerId
	end)

	return var_39_0
end

function var_0_0.getTaskListByGroupId(arg_41_0, arg_41_1)
	if arg_41_0._groupId2TaskListDict == nil then
		arg_41_0._groupId2TaskListDict = {}

		local var_41_0 = arg_41_0.taskConfig.configList

		for iter_41_0, iter_41_1 in ipairs(var_41_0) do
			if not arg_41_0._groupId2TaskListDict[iter_41_1.taskGroupId] then
				arg_41_0._groupId2TaskListDict[iter_41_1.taskGroupId] = {}
			end

			table.insert(arg_41_0._groupId2TaskListDict[iter_41_1.taskGroupId], iter_41_1.id)
		end
	end

	return arg_41_0._groupId2TaskListDict[arg_41_1]
end

function var_0_0.getTowerBossTimeCoByTaskGroupId(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.bossTimeConfig.configList

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if iter_42_1.taskGroupId == arg_42_1 then
			return iter_42_1
		end
	end
end

function var_0_0.getTowerLimitedCoByTaskGroupId(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:getAllTowerLimitedTimeCoList()

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if iter_43_1.taskGroupId == arg_43_1 then
			return iter_43_1
		end
	end
end

function var_0_0.getAllTowerLimitedTimeCoList(arg_44_0)
	return arg_44_0.towerLimitedTimeConfig.configList
end

function var_0_0.getTowerLimitedTimeCo(arg_45_0, arg_45_1)
	return arg_45_0.towerLimitedTimeConfig.configDict[arg_45_1]
end

function var_0_0.getTowerTaskConfig(arg_46_0, arg_46_1)
	return arg_46_0.taskConfig.configDict[arg_46_1]
end

function var_0_0.getTowerLimitedTimeCoList(arg_47_0, arg_47_1, arg_47_2)
	return arg_47_0.limitEpisodeCoMap[arg_47_1] and arg_47_0.limitEpisodeCoMap[arg_47_1][arg_47_2]
end

function var_0_0.getTowerLimitedTimeCoByEpisodeId(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = arg_48_0:getTowerLimitedTimeCoList(arg_48_1, arg_48_2)

	for iter_48_0, iter_48_1 in ipairs(var_48_0) do
		if iter_48_1.episodeId == arg_48_3 then
			return iter_48_1
		end
	end
end

function var_0_0.getTowerLimitedTimeCoByDifficulty(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = arg_49_0:getTowerLimitedTimeCoList(arg_49_1, arg_49_2)

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		if iter_49_1.difficulty == arg_49_3 then
			return iter_49_1
		end
	end
end

function var_0_0.getPassiveSKills(arg_50_0, arg_50_1)
	if arg_50_0.bossPassiveSkillDict == nil then
		arg_50_0.bossPassiveSkillDict = {}
	end

	if not arg_50_0.bossPassiveSkillDict[arg_50_1] then
		local var_50_0 = var_0_0.instance:getAssistBossConfig(arg_50_1)

		arg_50_0.bossPassiveSkillDict[arg_50_1] = {}

		local var_50_1 = string.splitToNumber(var_50_0.passiveSkills, "#")

		table.insert(arg_50_0.bossPassiveSkillDict[arg_50_1], var_50_1)
		arg_50_0:getPassiveSkillActiveLev(arg_50_1, 0)

		local var_50_2 = arg_50_0.bossPassiveSkillLevDict[arg_50_1]
		local var_50_3 = {}

		for iter_50_0, iter_50_1 in pairs(var_50_2) do
			table.insert(var_50_3, {
				skillId = iter_50_0,
				lev = iter_50_1
			})
		end

		if #var_50_3 > 1 then
			table.sort(var_50_3, SortUtil.keyLower("lev"))
		end

		for iter_50_2, iter_50_3 in ipairs(var_50_3) do
			table.insert(arg_50_0.bossPassiveSkillDict[arg_50_1], {
				iter_50_3.skillId
			})
		end
	end

	return arg_50_0.bossPassiveSkillDict[arg_50_1]
end

function var_0_0.getPassiveSkillActiveLev(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_0.bossPassiveSkillLevDict == nil then
		arg_51_0.bossPassiveSkillLevDict = {}
	end

	if not arg_51_0.bossPassiveSkillLevDict[arg_51_1] then
		arg_51_0.bossPassiveSkillLevDict[arg_51_1] = {}

		local var_51_0 = arg_51_0.towerAssistDevelopConfig.configDict[arg_51_1]

		if var_51_0 then
			local var_51_1 = 1
			local var_51_2 = var_51_0[var_51_1]

			while var_51_2 do
				if not string.nilorempty(var_51_2.passiveSkills) then
					local var_51_3 = string.splitToNumber(var_51_2.passiveSkills, "#")

					for iter_51_0, iter_51_1 in ipairs(var_51_3) do
						arg_51_0.bossPassiveSkillLevDict[arg_51_1][iter_51_1] = var_51_1
					end
				end

				if not string.nilorempty(var_51_2.extraRule) then
					local var_51_4 = GameUtil.splitString2(var_51_2.extraRule, true)

					for iter_51_2, iter_51_3 in ipairs(var_51_4) do
						arg_51_0.bossPassiveSkillLevDict[arg_51_1][iter_51_3[2]] = var_51_1
					end
				end

				var_51_1 = var_51_1 + 1
				var_51_2 = var_51_0[var_51_1]
			end
		end
	end

	return arg_51_0.bossPassiveSkillLevDict[arg_51_1][arg_51_2] or 0
end

function var_0_0.isSkillActive(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	return arg_52_3 >= arg_52_0:getPassiveSkillActiveLev(arg_52_1, arg_52_2)
end

function var_0_0.getAssistAttribute(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0.towerAssistAttrbuteConfig.configDict[arg_53_1]

	return var_53_0 and var_53_0[arg_53_2]
end

function var_0_0.getBossAddAttr(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = arg_54_0:getBossAddAttrDict(arg_54_1, arg_54_2)
	local var_54_1 = {}

	for iter_54_0, iter_54_1 in pairs(var_54_0) do
		table.insert(var_54_1, {
			key = iter_54_0,
			val = iter_54_1
		})
	end

	if #var_54_1 > 0 then
		table.sort(var_54_1, SortUtil.keyLower("key"))
	end

	return var_54_1
end

function var_0_0.getBossAddAttrDict(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_2 or 0
	local var_55_1 = {}

	for iter_55_0 = 1, var_55_0 do
		local var_55_2 = var_0_0.instance:getAssistDevelopConfig(arg_55_1, iter_55_0)

		if var_55_2 then
			local var_55_3 = GameUtil.splitString2(var_55_2.attribute, true)

			if var_55_3 then
				for iter_55_1, iter_55_2 in pairs(var_55_3) do
					if var_55_1[iter_55_2[1]] == nil then
						var_55_1[iter_55_2[1]] = iter_55_2[2]
					else
						var_55_1[iter_55_2[1]] = var_55_1[iter_55_2[1]] + iter_55_2[2]
					end
				end
			end
		end
	end

	return var_55_1
end

function var_0_0.getHeroGroupAddAttr(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	local var_56_0 = var_0_0.instance:getAssistAttribute(arg_56_1, arg_56_2)
	local var_56_1 = arg_56_0:getBossAddAttrDict(arg_56_1, arg_56_3)
	local var_56_2 = {}

	for iter_56_0, iter_56_1 in pairs(TowerEnum.AttrKey) do
		local var_56_3 = TowerEnum.AttrKey2AttrId[iter_56_1]
		local var_56_4 = var_56_1[var_56_3] or 0
		local var_56_5 = var_56_0 and var_56_0[iter_56_1]

		if var_56_4 > 0 or var_56_5 ~= nil then
			table.insert(var_56_2, {
				key = var_56_3,
				val = var_56_5,
				add = var_56_4,
				upAttr = TowerEnum.UpAttrId[iter_56_1] ~= nil
			})
		end
	end

	if #var_56_2 > 0 then
		table.sort(var_56_2, SortUtil.keyLower("key"))
	end

	return var_56_2
end

function var_0_0.getLimitEpisodeConfig(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = arg_57_0.towerLimitedEpisodeConfig.configDict[arg_57_1]

	return var_57_0 and var_57_0[arg_57_2]
end

function var_0_0.setTalentImg(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	local var_58_0

	if arg_58_2.isBigNode == 1 then
		var_58_0 = string.format("towertalent_branchbigskill_%s", arg_58_2.nodeType)
	else
		var_58_0 = string.format("towertalent_branchskill_%s", arg_58_2.nodeType)
	end

	UISpriteSetMgr.instance:setTowerSprite(arg_58_1, var_58_0, arg_58_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
