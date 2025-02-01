module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5RevivalTaskModel", package.seeall)

slot0 = class("VersionActivity1_5RevivalTaskModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0.playedIdList = nil
end

function slot0.updateExploreTaskInfo(slot0, slot1)
	slot0.heroTaskMoList = slot0.heroTaskMoList or {}

	if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.exploreTaskUnlockEpisodeId) then
		return
	end

	if not slot0:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId) then
		slot2 = VersionActivity1_5HeroTaskMo.New()

		slot2:initByCo({
			id = VersionActivity1_5DungeonEnum.ExploreTaskId,
			preEpisodeId = VersionActivity1_5DungeonConfig.instance:getExploreUnlockEpisodeId(),
			toastId = VersionActivity1_5DungeonConfig.instance.exploreTaskLockToastId
		})
		table.insert(slot0.heroTaskMoList, slot2)
	end

	slot2:updateGainedReward(slot1)
end

function slot0.updateHeroTaskInfos(slot0, slot1)
	slot0.heroTaskMoList = slot0.heroTaskMoList or {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0:getTaskMo(slot6.id) then
			slot7 = VersionActivity1_5HeroTaskMo.New()

			slot7:initById(slot6.id)
			table.insert(slot0.heroTaskMoList, slot7)
		end

		slot7:updateGainedReward(slot6.gainedReward)
		slot7:updateSubHeroTaskGainedReward(slot6.gainedSubTaskIds)
	end
end

function slot0.getTaskMoList(slot0)
	return slot0.heroTaskMoList
end

function slot0.getTaskMo(slot0, slot1)
	if not slot0.heroTaskMoList then
		return nil
	end

	for slot5, slot6 in ipairs(slot0.heroTaskMoList) do
		if slot6.id == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.setSelectHeroTaskId(slot0, slot1)
	if slot1 == slot0.selectTaskId then
		return
	end

	slot0.selectTaskId = slot1

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange)
end

function slot0.getSelectHeroTaskId(slot0)
	return slot0.selectTaskId
end

function slot0.getSubHeroTaskStatus(slot0, slot1)
	if slot0:checkSubHeroTaskGainedReward(slot1) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.GainedReward
	end

	if slot0:checkSubHeroTaskIsFinish(slot1) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished
	end

	if slot0:checkSubHeroTaskIsUnlock(slot1) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal
	end

	return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock
end

function slot0.checkSubHeroTaskGainedReward(slot0, slot1)
	return slot0:getTaskMo(slot1.taskId) and slot2:subTaskIsGainedReward(slot1.id)
end

function slot0.checkSubHeroTaskIsFinish(slot0, slot1)
	for slot6, slot7 in ipairs(string.splitToNumber(slot1.elementIds, "#")) do
		if not DungeonMapModel.instance:elementIsFinished(slot7) then
			return false
		end
	end

	return true
end

function slot0.checkSubHeroTaskIsUnlock(slot0, slot1)
	if slot1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishElement then
		return slot0:_checkFinishElement(tonumber(slot1.unlockParam))
	elseif slot1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishEpisode then
		return slot0:_checkFinishEpisode(tonumber(slot2))
	elseif slot1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishSubHeroTask then
		return slot0:_checkFinishSubTask(tonumber(slot2))
	elseif slot1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishElementAndEpisode then
		return slot0:_checkFinishElement(string.splitToNumber(slot2, "#")[1]) and slot0:_checkFinishEpisode(slot3[2])
	elseif slot1.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishSubHeroTaskAndEpisode then
		return slot0:_checkFinishSubTask(string.splitToNumber(slot2, "#")[1]) and slot0:_checkFinishEpisode(slot3[2])
	else
		return true
	end
end

function slot0._checkFinishElement(slot0, slot1)
	return DungeonMapModel.instance:elementIsFinished(slot1)
end

function slot0._checkFinishAnyOneElement(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0:_checkFinishElement(slot6) then
			return true
		end
	end

	return false
end

function slot0._checkFinishEpisode(slot0, slot1)
	return DungeonModel.instance:getEpisodeInfo(slot1) and DungeonEnum.StarType.Normal <= slot2.star
end

function slot0._checkFinishSubTask(slot0, slot1)
	return lua_act139_sub_hero_task.configDict[slot1] and VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished <= slot0:getSubHeroTaskStatus(slot2)
end

function slot0.gainedExploreTaskReward(slot0)
	slot0:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId):updateGainedReward(true)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedExploreReward)
end

function slot0.gainedHeroTaskReward(slot0, slot1)
	slot0:getTaskMo(slot1):updateGainedReward(true)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedHeroTaskReward, slot1)
end

function slot0.gainedSubTaskReward(slot0, slot1)
	slot0:getTaskMo(lua_act139_sub_hero_task.configDict[slot1].taskId):gainedSubHeroTaskId(slot1)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, slot1)
end

function slot0.checkExploreTaskGainedTotalReward(slot0)
	return slot0:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId) and slot1.gainedReward
end

function slot0.getExploreTaskStatus(slot0, slot1)
	if not slot0:checkExploreTaskUnlock(slot1) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock
	end

	if slot0:checkExploreTaskRunning(slot1) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running
	end

	if slot0:checkExploreTaskGainedReward(slot1) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward
	end

	if slot0:checkExploreTaskFinish(slot1) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Finished
	end

	return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Normal
end

function slot0.checkExploreTaskGainedReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(slot6) then
			return false
		end
	end

	return true
end

function slot0.checkExploreTaskFinish(slot0, slot1)
	slot2 = slot1.elementList[1]

	if slot1.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch then
		return VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(slot2) and slot3:isFinish()
	end

	return DungeonModel.instance:hasPassLevel(tonumber(lua_chapter_map_element.configDict[slot2].param))
end

function slot0.checkExploreTaskRunning(slot0, slot1)
	if slot1.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight then
		return false
	end

	return VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(slot1.elementList[1]) and slot3:isRunning()
end

function slot0.checkExploreTaskUnlock(slot0, slot1)
	if slot1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElement then
		return slot0:_checkFinishElement(tonumber(slot1.unlockParam))
	elseif slot1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisode then
		return slot0:_checkFinishEpisode(tonumber(slot1.unlockParam))
	elseif slot1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElementAndEpisode then
		return slot0:_checkFinishElement(string.splitToNumber(slot1.unlockParam, "#")[1]) and slot0:_checkFinishEpisode(slot2[2])
	elseif slot1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishAnyOneElement then
		return slot0:_checkFinishAnyOneElement(string.splitToNumber(slot1.unlockParam, "#"))
	elseif slot1.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisodeAndAnyOneElement then
		return slot0:_checkFinishEpisode(tonumber(string.split(slot1.unlockParam, "#")[1])) and slot0:_checkFinishAnyOneElement(string.splitToNumber(slot2[2], "|"))
	else
		return true
	end
end

function slot0.clear(slot0)
	slot0.heroTaskMoList = nil

	slot0:clearSelectTaskId()
end

function slot0.clearSelectTaskId(slot0)
	slot0.selectTaskId = nil
end

function slot0.checkIsPlayedUnlockAnimation(slot0, slot1)
	slot0:initPlayedUnlockDict()

	return tabletool.indexOf(slot0.playedIdList, slot1)
end

function slot0.playedUnlockAnimation(slot0, slot1)
	slot0:initPlayedUnlockDict()

	if tabletool.indexOf(slot0.playedIdList, slot1) then
		return
	end

	table.insert(slot0.playedIdList, slot1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskUnlockKey), table.concat(slot0.playedIdList, "|"))
end

function slot0.initPlayedUnlockDict(slot0)
	if not slot0.playedIdList then
		slot0.playedIdList = {}
		slot0.playedIdList = string.splitToNumber(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskUnlockKey), ""), "|")
	end
end

function slot0.checkNeedShowElementRedDot(slot0)
	if slot0.preCalculateFrame == Time.frameCount then
		return slot0.isShowElementRedDot
	end

	slot0.preCalculateFrame = Time.frameCount
	slot0.isShowElementRedDot = false

	for slot5, slot6 in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		for slot10, slot11 in ipairs(slot6.elementList) do
			if not DungeonMapModel.instance:elementIsFinished(slot11) then
				slot14 = false

				if DungeonConfig.instance:getChapterMapElement(slot11).type == DungeonEnum.ElementType.Fight then
					slot14 = DungeonModel.instance:hasPassLevel(tonumber(slot12.param))
				elseif slot13 == DungeonEnum.ElementType.EnterDialogue then
					slot14 = DialogueModel.instance:isFinishDialogue(tonumber(slot12.param))
				elseif slot13 == DungeonEnum.ElementType.EnterDispatch then
					slot14 = VersionActivity1_5DungeonModel.instance:getDispatchMo(tonumber(slot12.param)) and slot15:isFinish()
				end

				if slot14 then
					slot0.isShowElementRedDot = true

					if SLFramework.FrameworkSettings.IsEditor then
						logNormal("need show element reddot, id : " .. tostring(slot11))
					end

					return slot0.isShowElementRedDot
				end
			end
		end
	end

	return slot0.isShowElementRedDot
end

function slot0.setIsPlayingOpenAnim(slot0, slot1)
	slot0.isPlayingOpenAnim = slot1

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OpenAnimPlayingStatusChange, slot0.isPlayingOpenAnim)
end

function slot0.getIsPlayingOpenAnim(slot0)
	return slot0.isPlayingOpenAnim
end

slot0.instance = slot0.New()

return slot0
