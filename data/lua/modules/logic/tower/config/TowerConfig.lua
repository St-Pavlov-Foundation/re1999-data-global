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
		"tower_assist_attribute",
		"tower_talent_plan",
		"tower_hero_trial",
		"tower_boss_teach",
		"tower_score_to_star"
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

function var_0_0.ontower_talent_planLoaded(arg_21_0, arg_21_1)
	arg_21_0.towerTalentPlanConfig = arg_21_1
end

function var_0_0.ontower_hero_trialLoaded(arg_22_0, arg_22_1)
	arg_22_0.heroTrialConfig = arg_22_1
end

function var_0_0.ontower_boss_teachLoaded(arg_23_0, arg_23_1)
	arg_23_0.towerBossTeachConfig = arg_23_1

	arg_23_0:buildBossTeachConfigList()
end

function var_0_0.ontower_score_to_starLoaded(arg_24_0, arg_24_1)
	arg_24_0.scoreToStarConfig = arg_24_1
end

function var_0_0.getBossTimeTowerConfig(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.bossTimeConfig.configDict[arg_25_1]

	return var_25_0 and var_25_0[arg_25_2]
end

function var_0_0.getAssistTalentConfig(arg_26_0)
	return arg_26_0.assistTalentConfig
end

function var_0_0.getAssistTalentConfigById(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.assistTalentConfig.configDict[arg_27_1]

	return var_27_0 and var_27_0[arg_27_2]
end

function var_0_0.getBossTowerConfig(arg_28_0, arg_28_1)
	return arg_28_0.bossTowerConfig.configDict[arg_28_1]
end

function var_0_0.getPermanentEpisodeCo(arg_29_0, arg_29_1)
	return arg_29_0.towerPermanentEpisodeConfig.configDict[arg_29_1]
end

function var_0_0.getPermanentEpisodeStageCoList(arg_30_0, arg_30_1)
	return arg_30_0.permanentEpisodeList[arg_30_1]
end

function var_0_0.getPermanentEpisodeLayerCo(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getPermanentEpisodeStageCoList(arg_31_1)

	if not var_31_0 or tabletool.len(var_31_0) == 0 then
		logError("该阶段数据不存在，请检查: stageId:" .. tostring(arg_31_1))

		return
	end

	return var_31_0[arg_31_2]
end

function var_0_0.getTowerPermanentTimeCo(arg_32_0, arg_32_1)
	return arg_32_0.towerPermanentTimeConfig.configDict[arg_32_1]
end

function var_0_0.getTowerPermanentTimeCoList(arg_33_0)
	return arg_33_0.towerPermanentTimeConfig.configList
end

function var_0_0.getAssistBossList(arg_34_0)
	return arg_34_0.towerAssistBossConfig.configList
end

function var_0_0.getAssistBossConfig(arg_35_0, arg_35_1)
	return arg_35_0.towerAssistBossConfig.configDict[arg_35_1]
end

function var_0_0.getAssistDevelopConfig(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0.towerAssistDevelopConfig.configDict[arg_36_1]

	return var_36_0 and var_36_0[arg_36_2]
end

function var_0_0.getAssistBossMaxLev(arg_37_0, arg_37_1)
	if not arg_37_0._bossLevDict then
		arg_37_0._bossLevDict = {}
	end

	if not arg_37_0._bossLevDict[arg_37_1] then
		local var_37_0 = 0
		local var_37_1 = arg_37_0.towerAssistDevelopConfig.configDict[arg_37_1]

		for iter_37_0, iter_37_1 in pairs(var_37_1) do
			if var_37_0 < iter_37_0 then
				var_37_0 = iter_37_0
			end
		end

		arg_37_0._bossLevDict[arg_37_1] = var_37_0
	end

	return arg_37_0._bossLevDict[arg_37_1]
end

function var_0_0.getMaxMopUpConfigByLayerId(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.towerMopUpConfig.configList
	local var_38_1

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		if arg_38_1 >= iter_38_1.layerNum then
			var_38_1 = iter_38_1
		else
			break
		end
	end

	return var_38_1
end

function var_0_0.getTowerMopUpCo(arg_39_0, arg_39_1)
	return arg_39_0.towerMopUpConfig.configDict[arg_39_1]
end

function var_0_0.getTowerConstConfig(arg_40_0, arg_40_1)
	return arg_40_0.towerConstConfig.configDict[arg_40_1] and arg_40_0.towerConstConfig.configDict[arg_40_1].value
end

function var_0_0.getTowerConstLangConfig(arg_41_0, arg_41_1)
	return arg_41_0.towerConstConfig.configDict[arg_41_1] and arg_41_0.towerConstConfig.configDict[arg_41_1].value2
end

function var_0_0.getTowerMopUpCoList(arg_42_0)
	return arg_42_0.towerMopUpConfig.configList
end

function var_0_0.getBossTowerIdByEpisodeId(arg_43_0, arg_43_1)
	if arg_43_0._episodeId2BossTowerIdDict == nil then
		arg_43_0._episodeId2BossTowerIdDict = {}

		local var_43_0 = arg_43_0.bossTowerEpisodeConfig.configList

		for iter_43_0, iter_43_1 in ipairs(var_43_0) do
			arg_43_0._episodeId2BossTowerIdDict[iter_43_1.episodeId] = iter_43_1.towerId
		end
	end

	return arg_43_0._episodeId2BossTowerIdDict[arg_43_1]
end

function var_0_0.getBossTowerEpisodeConfig(arg_44_0, arg_44_1, arg_44_2)
	return arg_44_0.bossTowerEpisodeConfig.configDict[arg_44_1][arg_44_2]
end

function var_0_0.getBossTowerEpisodeCoList(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0.bossTowerEpisodeConfig.configDict[arg_45_1]

	table.sort(var_45_0, function(arg_46_0, arg_46_1)
		return arg_46_0.layerId < arg_46_1.layerId
	end)

	return var_45_0
end

function var_0_0.getTaskListByGroupId(arg_47_0, arg_47_1)
	if arg_47_0._groupId2TaskListDict == nil then
		arg_47_0._groupId2TaskListDict = {}

		local var_47_0 = arg_47_0.taskConfig.configList

		for iter_47_0, iter_47_1 in ipairs(var_47_0) do
			if not arg_47_0._groupId2TaskListDict[iter_47_1.taskGroupId] then
				arg_47_0._groupId2TaskListDict[iter_47_1.taskGroupId] = {}
			end

			table.insert(arg_47_0._groupId2TaskListDict[iter_47_1.taskGroupId], iter_47_1.id)
		end
	end

	return arg_47_0._groupId2TaskListDict[arg_47_1]
end

function var_0_0.getTowerBossTimeCoByTaskGroupId(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.bossTimeConfig.configList

	for iter_48_0, iter_48_1 in ipairs(var_48_0) do
		if iter_48_1.taskGroupId == arg_48_1 then
			return iter_48_1
		end
	end
end

function var_0_0.getTowerLimitedCoByTaskGroupId(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:getAllTowerLimitedTimeCoList()

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		if iter_49_1.taskGroupId == arg_49_1 then
			return iter_49_1
		end
	end
end

function var_0_0.getAllTowerLimitedTimeCoList(arg_50_0)
	return arg_50_0.towerLimitedTimeConfig.configList
end

function var_0_0.getTowerLimitedTimeCo(arg_51_0, arg_51_1)
	return arg_51_0.towerLimitedTimeConfig.configDict[arg_51_1]
end

function var_0_0.getTowerTaskConfig(arg_52_0, arg_52_1)
	return arg_52_0.taskConfig.configDict[arg_52_1]
end

function var_0_0.getTowerLimitedTimeCoList(arg_53_0, arg_53_1, arg_53_2)
	return arg_53_0.limitEpisodeCoMap[arg_53_1] and arg_53_0.limitEpisodeCoMap[arg_53_1][arg_53_2]
end

function var_0_0.getTowerLimitedTimeCoByEpisodeId(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_0:getTowerLimitedTimeCoList(arg_54_1, arg_54_2)

	for iter_54_0, iter_54_1 in ipairs(var_54_0) do
		if iter_54_1.episodeId == arg_54_3 then
			return iter_54_1
		end
	end
end

function var_0_0.getTowerLimitedTimeCoByDifficulty(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = arg_55_0:getTowerLimitedTimeCoList(arg_55_1, arg_55_2)

	for iter_55_0, iter_55_1 in ipairs(var_55_0) do
		if iter_55_1.difficulty == arg_55_3 then
			return iter_55_1
		end
	end
end

function var_0_0.getPassiveSKills(arg_56_0, arg_56_1)
	if arg_56_0.bossPassiveSkillDict == nil then
		arg_56_0.bossPassiveSkillDict = {}
	end

	if not arg_56_0.bossPassiveSkillDict[arg_56_1] then
		local var_56_0 = var_0_0.instance:getAssistBossConfig(arg_56_1)

		arg_56_0.bossPassiveSkillDict[arg_56_1] = {}

		local var_56_1 = string.splitToNumber(var_56_0.passiveSkills, "#")

		table.insert(arg_56_0.bossPassiveSkillDict[arg_56_1], var_56_1)
		arg_56_0:getPassiveSkillActiveLev(arg_56_1, 0)

		local var_56_2 = arg_56_0.bossPassiveSkillLevDict[arg_56_1]
		local var_56_3 = {}

		for iter_56_0, iter_56_1 in pairs(var_56_2) do
			table.insert(var_56_3, {
				skillId = iter_56_0,
				lev = iter_56_1
			})
		end

		if #var_56_3 > 1 then
			table.sort(var_56_3, SortUtil.keyLower("lev"))
		end

		for iter_56_2, iter_56_3 in ipairs(var_56_3) do
			table.insert(arg_56_0.bossPassiveSkillDict[arg_56_1], {
				iter_56_3.skillId
			})
		end
	end

	return arg_56_0.bossPassiveSkillDict[arg_56_1]
end

function var_0_0.getPassiveSkillActiveLev(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_0.bossPassiveSkillLevDict == nil then
		arg_57_0.bossPassiveSkillLevDict = {}
	end

	if not arg_57_0.bossPassiveSkillLevDict[arg_57_1] then
		arg_57_0.bossPassiveSkillLevDict[arg_57_1] = {}

		local var_57_0 = arg_57_0.towerAssistDevelopConfig.configDict[arg_57_1]

		if var_57_0 then
			local var_57_1 = 1
			local var_57_2 = var_57_0[var_57_1]

			while var_57_2 do
				if not string.nilorempty(var_57_2.passiveSkills) then
					local var_57_3 = string.splitToNumber(var_57_2.passiveSkills, "#")

					for iter_57_0, iter_57_1 in ipairs(var_57_3) do
						arg_57_0.bossPassiveSkillLevDict[arg_57_1][iter_57_1] = var_57_1
					end
				end

				if not string.nilorempty(var_57_2.extraRule) then
					local var_57_4 = GameUtil.splitString2(var_57_2.extraRule, true)

					for iter_57_2, iter_57_3 in ipairs(var_57_4) do
						arg_57_0.bossPassiveSkillLevDict[arg_57_1][iter_57_3[2]] = var_57_1
					end
				end

				var_57_1 = var_57_1 + 1
				var_57_2 = var_57_0[var_57_1]
			end
		end
	end

	return arg_57_0.bossPassiveSkillLevDict[arg_57_1][arg_57_2] or 0
end

function var_0_0.isSkillActive(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	return arg_58_3 >= arg_58_0:getPassiveSkillActiveLev(arg_58_1, arg_58_2)
end

function var_0_0.getAssistAttribute(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = arg_59_0.towerAssistAttrbuteConfig.configDict[arg_59_1]

	return var_59_0 and var_59_0[arg_59_2]
end

function var_0_0.getBossAddAttr(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_0:getBossAddAttrDict(arg_60_1, arg_60_2)
	local var_60_1 = {}

	for iter_60_0, iter_60_1 in pairs(var_60_0) do
		table.insert(var_60_1, {
			key = iter_60_0,
			val = iter_60_1
		})
	end

	if #var_60_1 > 0 then
		table.sort(var_60_1, SortUtil.keyLower("key"))
	end

	return var_60_1
end

function var_0_0.getBossAddAttrDict(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_2 or 0
	local var_61_1 = {}

	for iter_61_0 = 1, var_61_0 do
		local var_61_2 = var_0_0.instance:getAssistDevelopConfig(arg_61_1, iter_61_0)

		if var_61_2 then
			local var_61_3 = GameUtil.splitString2(var_61_2.attribute, true)

			if var_61_3 then
				for iter_61_1, iter_61_2 in pairs(var_61_3) do
					if var_61_1[iter_61_2[1]] == nil then
						var_61_1[iter_61_2[1]] = iter_61_2[2]
					else
						var_61_1[iter_61_2[1]] = var_61_1[iter_61_2[1]] + iter_61_2[2]
					end
				end
			end
		end
	end

	return var_61_1
end

function var_0_0.getHeroGroupAddAttr(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	local var_62_0 = var_0_0.instance:getAssistAttribute(arg_62_1, arg_62_2)
	local var_62_1 = arg_62_0:getBossAddAttrDict(arg_62_1, arg_62_3)
	local var_62_2 = {}

	for iter_62_0, iter_62_1 in pairs(TowerEnum.AttrKey) do
		local var_62_3 = TowerEnum.AttrKey2AttrId[iter_62_1]
		local var_62_4 = var_62_1[var_62_3] or 0
		local var_62_5 = var_62_0 and var_62_0[iter_62_1]

		if var_62_4 > 0 or var_62_5 ~= nil then
			table.insert(var_62_2, {
				key = var_62_3,
				val = var_62_5,
				add = var_62_4,
				upAttr = TowerEnum.UpAttrId[iter_62_1] ~= nil
			})
		end
	end

	if #var_62_2 > 0 then
		table.sort(var_62_2, SortUtil.keyLower("key"))
	end

	return var_62_2
end

function var_0_0.getLimitEpisodeConfig(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0.towerLimitedEpisodeConfig.configDict[arg_63_1]

	return var_63_0 and var_63_0[arg_63_2]
end

function var_0_0.setTalentImg(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0

	if arg_64_2.isBigNode == 1 then
		var_64_0 = string.format("towertalent_branchbigskill_%s", arg_64_2.nodeType)
	else
		var_64_0 = string.format("towertalent_branchskill_%s", arg_64_2.nodeType)
	end

	UISpriteSetMgr.instance:setTowerSprite(arg_64_1, var_64_0, arg_64_3)
end

function var_0_0.getTalentPlanConfig(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = arg_65_0.towerTalentPlanConfig.configDict[arg_65_1]

	return var_65_0 and var_65_0[arg_65_2]
end

function var_0_0.getAllTalentPlanConfig(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_0.towerTalentPlanConfig.configDict[arg_66_1]
	local var_66_1 = {}

	if not var_66_0 then
		logError("bossId: " .. arg_66_1 .. "没有推荐天赋方案")

		return var_66_1
	end

	for iter_66_0, iter_66_1 in pairs(var_66_0) do
		table.insert(var_66_1, iter_66_1)
	end

	table.sort(var_66_1, function(arg_67_0, arg_67_1)
		return arg_67_0.planId < arg_67_1.planId
	end)

	return var_66_1
end

function var_0_0.getTalentPlanNodeIds(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = arg_68_0:getTalentPlanConfig(arg_68_1, arg_68_2)

	if not var_68_0 then
		logError("boss:" .. arg_68_1 .. " 对应的推荐天赋方案: " .. arg_68_2 .. "配置不存在")

		return {}
	end

	local var_68_1 = {}
	local var_68_2 = string.splitToNumber(var_68_0.talentIds, "#")
	local var_68_3 = arg_68_0:getAllTalentPoint(arg_68_1, arg_68_3)
	local var_68_4 = 0

	for iter_68_0, iter_68_1 in ipairs(var_68_2) do
		var_68_4 = var_68_4 + arg_68_0:getAssistTalentConfigById(arg_68_1, iter_68_1).consume

		if var_68_4 <= var_68_3 then
			table.insert(var_68_1, iter_68_1)
		else
			break
		end
	end

	return var_68_1
end

function var_0_0.getAllTalentPoint(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = 0
	local var_69_1 = arg_69_0.towerAssistDevelopConfig.configDict[arg_69_1]

	for iter_69_0, iter_69_1 in pairs(var_69_1) do
		if arg_69_2 >= iter_69_1.level then
			var_69_0 = var_69_0 + iter_69_1.talentPoint
		end
	end

	return var_69_0
end

function var_0_0.getHeroTrialConfig(arg_70_0, arg_70_1)
	return arg_70_0.heroTrialConfig.configDict[arg_70_1]
end

function var_0_0.getBossTeachConfig(arg_71_0, arg_71_1, arg_71_2)
	return arg_71_0.towerBossTeachConfig.configDict[arg_71_1] and arg_71_0.towerBossTeachConfig.configDict[arg_71_1][arg_71_2]
end

function var_0_0.buildBossTeachConfigList(arg_72_0)
	if not arg_72_0.bossTeachCoList then
		arg_72_0.bossTeachCoList = {}
	end

	for iter_72_0, iter_72_1 in ipairs(arg_72_0.towerBossTeachConfig.configList) do
		if not arg_72_0.bossTeachCoList[iter_72_1.towerId] then
			arg_72_0.bossTeachCoList[iter_72_1.towerId] = {}
		end

		table.insert(arg_72_0.bossTeachCoList[iter_72_1.towerId], iter_72_1)
	end
end

function var_0_0.getAllBossTeachConfigList(arg_73_0, arg_73_1)
	if arg_73_0.bossTeachCoList[arg_73_1] then
		return arg_73_0.bossTeachCoList[arg_73_1]
	else
		logError("该boss塔没有教学配置: " .. arg_73_1)

		return {}
	end
end

function var_0_0.getScoreToStarConfig(arg_74_0, arg_74_1)
	local var_74_0 = 0

	for iter_74_0, iter_74_1 in ipairs(arg_74_0.scoreToStarConfig.configList) do
		if arg_74_1 >= iter_74_1.needScore then
			var_74_0 = iter_74_1.level
		end
	end

	return var_74_0
end

function var_0_0.checkIsPermanentFinalStageEpisode(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0.permanentEpisodeList[#arg_75_0.permanentEpisodeList]

	for iter_75_0, iter_75_1 in ipairs(var_75_0) do
		local var_75_1 = string.splitToNumber(iter_75_1.episodeIds, "|")

		if tabletool.indexOf(var_75_1, arg_75_1) then
			return true, iter_75_1
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
