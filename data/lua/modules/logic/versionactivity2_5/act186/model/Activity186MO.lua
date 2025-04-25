module("modules.logic.versionactivity2_5.act186.model.Activity186MO", package.seeall)

slot0 = pureTable("Activity186MO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.spBonusStage = 0
	slot0.taskDict = {}
end

function slot0.setSpBonusStage(slot0, slot1)
	slot0.spBonusStage = slot1
end

function slot0.updateInfo(slot0, slot1)
	slot0:updateActivityInfo(slot1.info)
	slot0:updateTaskInfos(slot1.taskInfos)
	slot0:updateLikeInfos(slot1.likeInfos)
	slot0:updateGameInfos(slot1.gameInfos)
end

function slot0.updateActivityInfo(slot0, slot1)
	slot0.currentStage = slot1.currentStage
	slot0.getDailyCollection = slot1.getDailyCollection
	slot0.getOneceBonus = slot1.getOneceBonus
	slot0.getMilestoneProgress = tonumber(slot1.getMilestoneProgress)
end

function slot0.onGetOnceBonus(slot0)
	slot0.getOneceBonus = true

	if slot0.spBonusStage == 0 then
		slot0.spBonusStage = 1
	end
end

function slot0.acceptRewards(slot0, slot1)
	slot0.getMilestoneProgress = tonumber(slot1)
end

function slot0.getMilestoneRewardStatus(slot0, slot1)
	slot2 = Activity186Enum.RewardStatus.None

	if slot3 and slot3.isLoopBonus or false then
		if (Activity186Config.instance:getMileStoneConfig(slot0.id, slot1) and slot3.coinNum or 0) <= slot0.getMilestoneProgress then
			if (slot3 and slot3.loopBonusIntervalNum or 1) <= ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId)) - slot0.getMilestoneProgress then
				slot2 = Activity186Enum.RewardStatus.Canget
			end
		elseif slot4 <= slot7 then
			slot2 = Activity186Enum.RewardStatus.Canget
		end
	elseif slot4 <= slot0.getMilestoneProgress then
		slot2 = Activity186Enum.RewardStatus.Hasget
	elseif slot4 <= slot7 then
		slot2 = Activity186Enum.RewardStatus.Canget
	end

	return slot2
end

function slot0.getMilestoneValue(slot0, slot1)
	slot3 = Activity186Config.instance:getMileStoneConfig(slot0.id, slot1) and slot2.coinNum or 0

	if not (slot2 and slot2.isLoopBonus or false) then
		return slot3
	end

	slot5 = slot2 and slot2.loopBonusIntervalNum or 1
	slot7 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId))
	slot8 = slot3

	if slot3 <= slot0.getMilestoneProgress then
		slot8 = slot3 + math.floor((slot0.getMilestoneProgress - slot3) / slot5) * slot5 + slot5
	end

	return slot8
end

function slot0.onGetDailyCollection(slot0)
	slot0.getDailyCollection = true
end

function slot0.updateTaskInfos(slot0, slot1)
	slot0.taskDict = {}

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0:updateTaskInfo(slot1[slot5])
		end
	end
end

function slot0.updateTaskInfo(slot0, slot1)
	slot2 = slot0:getTaskInfo(slot1.taskId, true)
	slot2.progress = slot1.progress
	slot2.hasGetBonus = slot1.hasGetBonus
end

function slot0.getTaskInfo(slot0, slot1, slot2)
	if not slot0.taskDict[slot1] and slot2 then
		slot0.taskDict[slot1] = {
			taskId = slot1,
			progress = 0,
			hasGetBonus = false
		}
	end

	return slot3
end

function slot0.getTaskList(slot0)
	slot1 = {}

	if slot0.taskDict then
		for slot5, slot6 in pairs(slot0.taskDict) do
			slot7 = {
				id = slot6.taskId,
				progress = slot6.progress,
				hasGetBonus = slot6.hasGetBonus,
				canGetReward = slot0:checkTaskCanReward(slot6),
				config = Activity186Config.instance:getTaskConfig(slot6.taskId)
			}
			slot7.missionorder = slot7.config.missionorder
			slot7.status = Activity186Enum.TaskStatus.None

			if slot7.hasGetBonus then
				slot7.status = Activity186Enum.TaskStatus.Hasget
			elseif slot7.canGetReward then
				slot7.status = Activity186Enum.TaskStatus.Canget
			end

			table.insert(slot1, slot7)
		end
	end

	slot3 = Activity186Config.instance:getStageConfig(slot0.id, slot0.currentStage) and slot2.globalTaskId or 0
	slot5 = {
		id = slot3,
		config = Activity173Config.instance:getTaskConfig(slot3),
		progress = TaskModel.instance:getTaskById(slot3) and slot4.progress or 0,
		hasGetBonus = slot4 and slot4.finishCount > 0 or false
	}
	slot5.canGetReward = not slot5.hasGetBonus and slot4 and slot5.config.maxProgress <= slot5.progress
	slot5.missionorder = 0
	slot5.isGlobalTask = true
	slot5.status = Activity186Enum.TaskStatus.None

	if slot5.hasGetBonus then
		slot5.status = Activity186Enum.TaskStatus.Hasget
	elseif slot5.canGetReward then
		slot5.status = Activity186Enum.TaskStatus.Canget
	end

	table.insert(slot1, slot5)

	return slot1
end

function slot0.finishTask(slot0, slot1)
	if slot0:getTaskInfo(slot1) then
		slot2.hasGetBonus = true
	end
end

function slot0.pushTask(slot0, slot1, slot2)
	if slot1 then
		for slot6 = 1, #slot1 do
			slot0:updateTaskInfo(slot1[slot6])
		end
	end

	if slot2 then
		for slot6 = 1, #slot2 do
			slot0.taskDict[slot2[slot6].taskId] = nil
		end
	end
end

function slot0.checkTaskCanReward(slot0, slot1)
	if not (type(slot1) == "number" and slot0:getTaskInfo(slot1) or slot1) then
		return false
	end

	if slot2.hasGetBonus then
		return false
	end

	return (Activity186Config.instance:getTaskConfig(slot2.taskId) and slot3.maxProgress or 0) <= slot2.progress
end

function slot0.hasCanRewardTask(slot0)
	for slot4, slot5 in pairs(slot0.taskDict) do
		if slot0:checkTaskCanReward(slot5) then
			return true
		end
	end

	return false
end

function slot0.updateLikeInfos(slot0, slot1)
	slot0.likeDict = {}

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0:updateLikeInfo(slot1[slot5])
		end
	end
end

function slot0.updateLikeInfo(slot0, slot1)
	if not slot0:getLikeInfo(slot1.likeType) then
		slot0.likeDict[slot1.likeType] = {
			likeType = slot1.likeType
		}
	end

	slot2.value = slot1.value
end

function slot0.getLikeInfo(slot0, slot1)
	return slot0.likeDict[slot1]
end

function slot0.getLikeValue(slot0, slot1)
	return slot0:getLikeInfo(slot1) and slot2.value or 0
end

function slot0.pushLike(slot0, slot1)
	if slot1 then
		for slot5 = 1, #slot1 do
			slot0:updateLikeInfo(slot1[slot5])
		end
	end
end

function slot0.getCurLikeType(slot0)
	if slot0:getLikeValue(4) < Activity186Config.instance:getConstNum(Activity186Enum.ConstId.BaseLikeValue) then
		return 0
	end

	slot3 = nil
	slot4 = 0

	for slot8, slot9 in pairs(slot0.likeDict) do
		if slot8 ~= 4 and (not slot3 or slot3 < slot9.value) then
			slot4 = slot8
			slot3 = slot9.value
		end
	end

	return slot4
end

function slot0.checkLikeEqual(slot0, slot1)
	return slot0:getCurLikeType() == slot1
end

function slot0.updateGameInfos(slot0, slot1)
	slot0.gameDict = {}

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0:updateGameInfo(slot1[slot5])
		end
	end
end

function slot0.updateGameInfo(slot0, slot1)
	if not slot0:getGameInfo(slot1.gameId) then
		slot0.gameDict[slot1.gameId] = {
			gameId = slot1.gameId
		}
	end

	slot2.gameTypeId = slot1.gameTypeId
	slot2.expireTime = slot1.expireTime

	if slot1.bTypeGameInfo then
		slot2.rewardId = slot3.rewardId
		slot2.bTypeRetryCount = slot3.bTypeRetryCount
	end
end

function slot0.getGameInfo(slot0, slot1)
	return slot0.gameDict[slot1]
end

function slot0.finishGame(slot0, slot1)
	if slot0:getGameInfo(slot1.gameId) then
		slot0.gameDict[slot1.gameId] = nil
	end
end

function slot0.playBTypeGame(slot0, slot1)
	if slot0:getGameInfo(slot1.gameId) then
		slot2.rewardId = slot1.rewardId

		if slot2.bTypeRetryCount then
			slot2.bTypeRetryCount = slot2.bTypeRetryCount - 1
		end
	end
end

function slot0.getOnlineGameList(slot0)
	slot1 = {}

	if slot0.gameDict then
		for slot5, slot6 in pairs(slot0.gameDict) do
			if ServerTime.now() < slot6.expireTime then
				table.insert(slot1, slot6)
			end
		end
	end

	return slot1
end

function slot0.isGameOnline(slot0, slot1)
	return slot0:getGameInfo(slot1) and ServerTime.now() < slot2.expireTime
end

function slot0.hasGameCanPlay(slot0)
	return #slot0:getOnlineGameList() > 0
end

function slot0.getQuestionConfig(slot0, slot1)
	slot4 = string.splitToNumber(Activity186Controller.instance:getPlayerPrefs(Activity186Model.instance:prefabKeyPrefs(Activity186Enum.LocalPrefsKey.Question, slot0.id)), "#")
	slot6 = slot4[2]

	if slot4[1] == slot1 and Activity186Config.instance:getQuestionConfig(slot1, slot6) then
		return slot7
	end

	if Activity186Config.instance:getNextQuestion(slot0.id, slot6) then
		Activity186Controller.instance:setPlayerPrefs(slot2, string.format("%s#%s", slot1, slot7.id))
	end

	return slot7
end

function slot0.hasActivityReward(slot0)
	if not slot0.getDailyCollection then
		return true
	end

	if Activity186Model.instance:isShowSignRed() then
		return true
	end

	if Activity186Config.instance:getMileStoneList(slot0.id) then
		for slot5, slot6 in ipairs(slot1) do
			if slot0:getMilestoneRewardStatus(slot6.rewardId) == Activity186Enum.RewardStatus.Canget then
				return true
			end
		end
	end

	return false
end

function slot0.isInAvgTime(slot0)
	slot2 = string.split(Activity186Config.instance:getConstStr(Activity186Enum.ConstId.AvgOpenTime), "#")

	return TimeUtil.stringToTimestamp(slot2[1]) <= ServerTime.now() and slot5 <= TimeUtil.stringToTimestamp(slot2[2])
end

function slot0.isCanShowAvgBtn(slot0)
	if slot0.getOneceBonus then
		return false
	end

	return slot0:isInAvgTime()
end

function slot0.isCanPlayAvgStory(slot0)
	if slot0.getOneceBonus then
		return false
	end

	if not slot0:isInAvgTime() then
		return
	end

	return Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.AvgMark, 0) == 0
end

return slot0
