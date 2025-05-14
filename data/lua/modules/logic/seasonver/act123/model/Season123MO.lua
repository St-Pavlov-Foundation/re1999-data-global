module("modules.logic.seasonver.act123.model.Season123MO", package.seeall)

local var_0_0 = pureTable("Season123MO")

function var_0_0.updateInfo(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.stage = arg_1_1.stage or 0

	if arg_1_1.act123Retail then
		arg_1_0.retailId = arg_1_1.act123Retail.id
	else
		arg_1_0.retailId = nil
	end

	arg_1_0:setUnlockAct123EquipIds(arg_1_1.unlockAct123EquipIds)
	arg_1_0:initItems(arg_1_1.act123Equips)
	arg_1_0:initStages(arg_1_1.act123Stage)

	arg_1_0.heroGroupSnapshot = Season123HeroGroupUtils.buildSnapshotHeroGroups(arg_1_1.heroGroupSnapshot)
	arg_1_0.heroGroupSnapshotSubId = arg_1_1.heroGroupSnapshotSubId
	arg_1_0.retailHeroGroups = Season123HeroGroupUtils.buildSnapshotHeroGroups(arg_1_1.retailHeroGroupSnapshot)
	arg_1_0.unlockIndexes = {}
	arg_1_0.unlockIndexSet = {}

	arg_1_0:updateUnlockIndexes(arg_1_1.unlockEquipIndexs)
	arg_1_0:updateTrial(arg_1_1.trial)
	Season123CardPackageModel.instance:initData(arg_1_0.activityId)
end

function var_0_0.updateInfoBattle(arg_2_0, arg_2_1)
	arg_2_0.stage = arg_2_1.stage

	arg_2_0:updateUnlockIndexes(arg_2_1.unlockEquipIndexs)
	arg_2_0:initStages(arg_2_1.act123Stage)
	arg_2_0:updateTrial(arg_2_1.trial)
end

function var_0_0.initStages(arg_3_0, arg_3_1)
	arg_3_0.stageList = {}
	arg_3_0.stageMap = {}

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_0 = arg_3_1[iter_3_0]
		local var_3_1 = Season123StageMO.New()

		var_3_1:init(var_3_0)
		table.insert(arg_3_0.stageList, var_3_1)

		arg_3_0.stageMap[var_3_0.stage] = var_3_1
	end
end

function var_0_0.initItems(arg_4_0, arg_4_1)
	arg_4_0.itemMap = {}

	for iter_4_0 = 1, #arg_4_1 do
		local var_4_0 = arg_4_1[iter_4_0]
		local var_4_1 = Season123ItemMO.New()

		var_4_1:setData(var_4_0)

		arg_4_0.itemMap[var_4_0.uid] = var_4_1
	end
end

function var_0_0.updateStages(arg_5_0, arg_5_1)
	local var_5_0 = false

	for iter_5_0 = 1, #arg_5_1 do
		local var_5_1 = arg_5_1[iter_5_0]
		local var_5_2 = arg_5_0.stageMap[var_5_1.stage]

		if not var_5_2 then
			var_5_2 = Season123StageMO.New()

			var_5_2:init(var_5_1)
			table.insert(arg_5_0.stageList, var_5_2)

			var_5_0 = true
			arg_5_0.stageMap[var_5_1.stage] = var_5_2
		else
			var_5_2:init(var_5_1)
		end
	end

	if var_5_0 then
		table.sort(arg_5_0.stageList, function(arg_6_0, arg_6_1)
			return arg_6_0.stage < arg_6_1.stage
		end)
	end
end

function var_0_0.updateEpisodes(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.stageMap[arg_7_1]

	if not var_7_0 then
		return
	end

	var_7_0:updateEpisodes(arg_7_2)
end

function var_0_0.updateUnlockIndexes(arg_8_0, arg_8_1)
	if not arg_8_1 or #arg_8_1 < 1 then
		return
	end

	arg_8_0.unlockIndexes = {}
	arg_8_0.unlockIndexSet = {}

	for iter_8_0 = 1, #arg_8_1 do
		arg_8_0.unlockIndexes = arg_8_1[iter_8_0]
		arg_8_0.unlockIndexSet[arg_8_1[iter_8_0]] = true
	end
end

function var_0_0.updateTrial(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1.id ~= 0 then
		arg_9_0.trial = arg_9_1.id
	else
		arg_9_0.trial = 0
	end
end

function var_0_0.getStageMO(arg_10_0, arg_10_1)
	return arg_10_0.stageMap[arg_10_1]
end

function var_0_0.getCurrentStage(arg_11_0)
	return arg_11_0:getStageMO(arg_11_0.stage)
end

function var_0_0.getCurHeroGroup(arg_12_0)
	return arg_12_0.heroGroupSnapshot[arg_12_0.heroGroupSnapshotSubId]
end

function var_0_0.getAllItemMap(arg_13_0)
	return arg_13_0.itemMap
end

function var_0_0.getItemMO(arg_14_0, arg_14_1)
	if arg_14_0.itemMap then
		return arg_14_0.itemMap[arg_14_1]
	end
end

function var_0_0.getItemIdByUid(arg_15_0, arg_15_1)
	if arg_15_0.itemMap and arg_15_0.itemMap[arg_15_1] then
		return arg_15_0.itemMap[arg_15_1].itemId
	end
end

function var_0_0.isNotInStage(arg_16_0)
	return arg_16_0.stage == 0
end

function var_0_0.getTotalRound(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = arg_17_0.stageMap[arg_17_1]

	if not var_17_1 then
		return 0
	end

	for iter_17_0, iter_17_1 in pairs(var_17_1.episodeMap) do
		var_17_0 = var_17_0 + iter_17_1.round
	end

	return var_17_0
end

function var_0_0.isStageSlotUnlock(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._stage2UnlockSets = arg_18_0._stage2UnlockSets or {}

	local var_18_0 = arg_18_0._stage2UnlockSets[arg_18_1]

	if not var_18_0 then
		var_18_0 = {}

		local var_18_1 = Season123Config.instance:getSeasonEpisodeStageCos(arg_18_0.activityId, arg_18_1)

		if var_18_1 then
			for iter_18_0, iter_18_1 in ipairs(var_18_1) do
				if iter_18_0 ~= #var_18_1 then
					local var_18_2 = string.splitToNumber(iter_18_1.unlockEquipIndex, "#")

					for iter_18_2, iter_18_3 in pairs(var_18_2) do
						var_18_0[iter_18_3] = true
					end
				end
			end
		end

		arg_18_0._stage2UnlockSets[arg_18_1] = var_18_0
	end

	return var_18_0[arg_18_2]
end

function var_0_0.setUnlockAct123EquipIds(arg_19_0, arg_19_1)
	arg_19_0.unlockAct123EquipIds = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		arg_19_0.unlockAct123EquipIds[iter_19_1] = iter_19_1
	end
end

function var_0_0.initStageRewardConfig(arg_20_0)
	arg_20_0.stageRewardMap = arg_20_0.stageRewardMap or {}

	local var_20_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {}

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if iter_20_1.config and iter_20_1.config.seasonId == arg_20_0.activityId and iter_20_1.config.isRewardView == Activity123Enum.TaskRewardViewType then
			local var_20_1 = Season123Config.instance:getTaskListenerParamCache(iter_20_1.config)
			local var_20_2 = tonumber(var_20_1[1])
			local var_20_3 = arg_20_0.stageRewardMap[var_20_2] or {}

			var_20_3[iter_20_0] = iter_20_1
			arg_20_0.stageRewardMap[var_20_2] = var_20_3
		end
	end
end

function var_0_0.getStageRewardCount(arg_21_0, arg_21_1)
	arg_21_0:initStageRewardConfig()

	local var_21_0 = arg_21_0.stageRewardMap[arg_21_1]
	local var_21_1 = Season123Config.instance:getRewardTaskCount(arg_21_0.activityId, arg_21_1)

	if not var_21_0 then
		return 0, var_21_1
	end

	local var_21_2 = 0

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		if iter_21_1.finishCount >= iter_21_1.config.maxFinishCount or iter_21_1.hasFinished then
			var_21_2 = var_21_2 + 1
		end
	end

	return var_21_2, var_21_1
end

return var_0_0
