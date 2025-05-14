module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5RevivalTaskModel", package.seeall)

local var_0_0 = class("VersionActivity1_5RevivalTaskModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.playedIdList = nil
end

function var_0_0.updateExploreTaskInfo(arg_3_0, arg_3_1)
	arg_3_0.heroTaskMoList = arg_3_0.heroTaskMoList or {}

	if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.exploreTaskUnlockEpisodeId) then
		return
	end

	local var_3_0 = arg_3_0:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId)

	if not var_3_0 then
		var_3_0 = VersionActivity1_5HeroTaskMo.New()

		var_3_0:initByCo({
			id = VersionActivity1_5DungeonEnum.ExploreTaskId,
			preEpisodeId = VersionActivity1_5DungeonConfig.instance:getExploreUnlockEpisodeId(),
			toastId = VersionActivity1_5DungeonConfig.instance.exploreTaskLockToastId
		})
		table.insert(arg_3_0.heroTaskMoList, var_3_0)
	end

	var_3_0:updateGainedReward(arg_3_1)
end

function var_0_0.updateHeroTaskInfos(arg_4_0, arg_4_1)
	arg_4_0.heroTaskMoList = arg_4_0.heroTaskMoList or {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = arg_4_0:getTaskMo(iter_4_1.id)

		if not var_4_0 then
			var_4_0 = VersionActivity1_5HeroTaskMo.New()

			var_4_0:initById(iter_4_1.id)
			table.insert(arg_4_0.heroTaskMoList, var_4_0)
		end

		var_4_0:updateGainedReward(iter_4_1.gainedReward)
		var_4_0:updateSubHeroTaskGainedReward(iter_4_1.gainedSubTaskIds)
	end
end

function var_0_0.getTaskMoList(arg_5_0)
	return arg_5_0.heroTaskMoList
end

function var_0_0.getTaskMo(arg_6_0, arg_6_1)
	if not arg_6_0.heroTaskMoList then
		return nil
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.heroTaskMoList) do
		if iter_6_1.id == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.setSelectHeroTaskId(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0.selectTaskId then
		return
	end

	arg_7_0.selectTaskId = arg_7_1

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange)
end

function var_0_0.getSelectHeroTaskId(arg_8_0)
	return arg_8_0.selectTaskId
end

function var_0_0.getSubHeroTaskStatus(arg_9_0, arg_9_1)
	if arg_9_0:checkSubHeroTaskGainedReward(arg_9_1) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.GainedReward
	end

	if arg_9_0:checkSubHeroTaskIsFinish(arg_9_1) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished
	end

	if arg_9_0:checkSubHeroTaskIsUnlock(arg_9_1) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal
	end

	return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock
end

function var_0_0.checkSubHeroTaskGainedReward(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getTaskMo(arg_10_1.taskId)

	return var_10_0 and var_10_0:subTaskIsGainedReward(arg_10_1.id)
end

function var_0_0.checkSubHeroTaskIsFinish(arg_11_0, arg_11_1)
	local var_11_0 = string.splitToNumber(arg_11_1.elementIds, "#")

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not DungeonMapModel.instance:elementIsFinished(iter_11_1) then
			return false
		end
	end

	return true
end

function var_0_0.checkSubHeroTaskIsUnlock(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.unlockParam

	if arg_12_1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishElement then
		return arg_12_0:_checkFinishElement(tonumber(var_12_0))
	elseif arg_12_1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishEpisode then
		return arg_12_0:_checkFinishEpisode(tonumber(var_12_0))
	elseif arg_12_1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishSubHeroTask then
		return arg_12_0:_checkFinishSubTask(tonumber(var_12_0))
	elseif arg_12_1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishElementAndEpisode then
		local var_12_1 = string.splitToNumber(var_12_0, "#")

		return arg_12_0:_checkFinishElement(var_12_1[1]) and arg_12_0:_checkFinishEpisode(var_12_1[2])
	elseif arg_12_1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishSubHeroTaskAndEpisode then
		local var_12_2 = string.splitToNumber(var_12_0, "#")

		return arg_12_0:_checkFinishSubTask(var_12_2[1]) and arg_12_0:_checkFinishEpisode(var_12_2[2])
	else
		return true
	end
end

function var_0_0._checkFinishElement(arg_13_0, arg_13_1)
	return DungeonMapModel.instance:elementIsFinished(arg_13_1)
end

function var_0_0._checkFinishAnyOneElement(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if arg_14_0:_checkFinishElement(iter_14_1) then
			return true
		end
	end

	return false
end

function var_0_0._checkFinishEpisode(arg_15_0, arg_15_1)
	local var_15_0 = DungeonModel.instance:getEpisodeInfo(arg_15_1)

	return var_15_0 and var_15_0.star >= DungeonEnum.StarType.Normal
end

function var_0_0._checkFinishSubTask(arg_16_0, arg_16_1)
	local var_16_0 = lua_act139_sub_hero_task.configDict[arg_16_1]

	return var_16_0 and arg_16_0:getSubHeroTaskStatus(var_16_0) >= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished
end

function var_0_0.gainedExploreTaskReward(arg_17_0)
	arg_17_0:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId):updateGainedReward(true)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedExploreReward)
end

function var_0_0.gainedHeroTaskReward(arg_18_0, arg_18_1)
	arg_18_0:getTaskMo(arg_18_1):updateGainedReward(true)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedHeroTaskReward, arg_18_1)
end

function var_0_0.gainedSubTaskReward(arg_19_0, arg_19_1)
	local var_19_0 = lua_act139_sub_hero_task.configDict[arg_19_1]

	arg_19_0:getTaskMo(var_19_0.taskId):gainedSubHeroTaskId(arg_19_1)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, arg_19_1)
end

function var_0_0.checkExploreTaskGainedTotalReward(arg_20_0)
	local var_20_0 = arg_20_0:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId)

	return var_20_0 and var_20_0.gainedReward
end

function var_0_0.getExploreTaskStatus(arg_21_0, arg_21_1)
	if not arg_21_0:checkExploreTaskUnlock(arg_21_1) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock
	end

	if arg_21_0:checkExploreTaskRunning(arg_21_1) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running
	end

	if arg_21_0:checkExploreTaskGainedReward(arg_21_1) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward
	end

	if arg_21_0:checkExploreTaskFinish(arg_21_1) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Finished
	end

	return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Normal
end

function var_0_0.checkExploreTaskGainedReward(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_1.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(iter_22_1) then
			return false
		end
	end

	return true
end

function var_0_0.checkExploreTaskFinish(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.elementList[1]

	if arg_23_1.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch then
		local var_23_1 = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(var_23_0)

		return var_23_1 and var_23_1:isFinish()
	end

	local var_23_2 = lua_chapter_map_element.configDict[var_23_0]
	local var_23_3 = tonumber(var_23_2.param)

	return DungeonModel.instance:hasPassLevel(var_23_3)
end

function var_0_0.checkExploreTaskRunning(arg_24_0, arg_24_1)
	if arg_24_1.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight then
		return false
	end

	local var_24_0 = arg_24_1.elementList[1]
	local var_24_1 = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(var_24_0)

	return var_24_1 and var_24_1:isRunning()
end

function var_0_0.checkExploreTaskUnlock(arg_25_0, arg_25_1)
	if arg_25_1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElement then
		return arg_25_0:_checkFinishElement(tonumber(arg_25_1.unlockParam))
	elseif arg_25_1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisode then
		return arg_25_0:_checkFinishEpisode(tonumber(arg_25_1.unlockParam))
	elseif arg_25_1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElementAndEpisode then
		local var_25_0 = string.splitToNumber(arg_25_1.unlockParam, "#")

		return arg_25_0:_checkFinishElement(var_25_0[1]) and arg_25_0:_checkFinishEpisode(var_25_0[2])
	elseif arg_25_1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishAnyOneElement then
		local var_25_1 = string.splitToNumber(arg_25_1.unlockParam, "#")

		return arg_25_0:_checkFinishAnyOneElement(var_25_1)
	elseif arg_25_1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisodeAndAnyOneElement then
		local var_25_2 = string.split(arg_25_1.unlockParam, "#")

		return arg_25_0:_checkFinishEpisode(tonumber(var_25_2[1])) and arg_25_0:_checkFinishAnyOneElement(string.splitToNumber(var_25_2[2], "|"))
	else
		return true
	end
end

function var_0_0.clear(arg_26_0)
	arg_26_0.heroTaskMoList = nil

	arg_26_0:clearSelectTaskId()
end

function var_0_0.clearSelectTaskId(arg_27_0)
	arg_27_0.selectTaskId = nil
end

function var_0_0.checkIsPlayedUnlockAnimation(arg_28_0, arg_28_1)
	arg_28_0:initPlayedUnlockDict()

	return tabletool.indexOf(arg_28_0.playedIdList, arg_28_1)
end

function var_0_0.playedUnlockAnimation(arg_29_0, arg_29_1)
	arg_29_0:initPlayedUnlockDict()

	if tabletool.indexOf(arg_29_0.playedIdList, arg_29_1) then
		return
	end

	table.insert(arg_29_0.playedIdList, arg_29_1)

	local var_29_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskUnlockKey)

	PlayerPrefsHelper.setString(var_29_0, table.concat(arg_29_0.playedIdList, "|"))
end

function var_0_0.initPlayedUnlockDict(arg_30_0)
	if not arg_30_0.playedIdList then
		arg_30_0.playedIdList = {}

		local var_30_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskUnlockKey)

		arg_30_0.playedIdList = string.splitToNumber(PlayerPrefsHelper.getString(var_30_0, ""), "|")
	end
end

function var_0_0.checkNeedShowElementRedDot(arg_31_0)
	if arg_31_0.preCalculateFrame == Time.frameCount then
		return arg_31_0.isShowElementRedDot
	end

	arg_31_0.preCalculateFrame = Time.frameCount
	arg_31_0.isShowElementRedDot = false

	local var_31_0 = VersionActivity1_5DungeonConfig.instance:getExploreTaskList()

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1.elementList) do
			if not DungeonMapModel.instance:elementIsFinished(iter_31_3) then
				local var_31_1 = DungeonConfig.instance:getChapterMapElement(iter_31_3)
				local var_31_2 = var_31_1.type
				local var_31_3 = false

				if var_31_2 == DungeonEnum.ElementType.Fight then
					var_31_3 = DungeonModel.instance:hasPassLevel(tonumber(var_31_1.param))
				elseif var_31_2 == DungeonEnum.ElementType.EnterDialogue then
					var_31_3 = DialogueModel.instance:isFinishDialogue(tonumber(var_31_1.param))
				elseif var_31_2 == DungeonEnum.ElementType.EnterDispatch then
					local var_31_4 = VersionActivity1_5DungeonModel.instance:getDispatchMo(tonumber(var_31_1.param))

					var_31_3 = var_31_4 and var_31_4:isFinish()
				end

				if var_31_3 then
					arg_31_0.isShowElementRedDot = true

					if SLFramework.FrameworkSettings.IsEditor then
						logNormal("need show element reddot, id : " .. tostring(iter_31_3))
					end

					return arg_31_0.isShowElementRedDot
				end
			end
		end
	end

	return arg_31_0.isShowElementRedDot
end

function var_0_0.setIsPlayingOpenAnim(arg_32_0, arg_32_1)
	arg_32_0.isPlayingOpenAnim = arg_32_1

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OpenAnimPlayingStatusChange, arg_32_0.isPlayingOpenAnim)
end

function var_0_0.getIsPlayingOpenAnim(arg_33_0)
	return arg_33_0.isPlayingOpenAnim
end

var_0_0.instance = var_0_0.New()

return var_0_0
