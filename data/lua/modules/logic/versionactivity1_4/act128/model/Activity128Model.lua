module("modules.logic.versionactivity1_4.act128.model.Activity128Model", package.seeall)

slot0 = class("Activity128Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.__activityId = false
	slot0.__config = false
	slot0.__stageInfos = {}
	slot0.__stageHasGetBonusIds = {}
	slot0._layer4Score = {}
	slot0._layer4HighestScore = {}
end

function slot0._internal_set_activity(slot0, slot1)
	slot0.__activityId = slot1
end

function slot0._internal_set_config(slot0, slot1)
	assert(isTypeOf(slot1, Activity128Config), debug.traceback())

	slot0.__config = slot1
end

function slot0.getConfig(slot0)
	return assert(slot0.__config, "pleaes call self:_internal_set_config(config) first")
end

function slot0.getActivityId(slot0)
	return slot0.__activityId
end

function slot0.getStageInfo(slot0, slot1)
	return slot0.__stageInfos[slot1]
end

function slot0.hasPassLevel(slot0, slot1, slot2)
	return DungeonModel.instance:hasPassLevel(slot0.__config:getDungeonEpisodeId(slot1, slot2))
end

function slot0.isBossLayerOpen(slot0, slot1, slot2)
	if not slot0:isBossOnline(slot1) then
		return false
	end

	if slot2 <= 1 then
		return true
	end

	return slot0:hasPassLevel(slot1, slot2 - 1)
end

function slot0.hasGetBonusIds(slot0, slot1, slot2)
	if type(slot0.__stageHasGetBonusIds[slot1]) ~= "table" then
		return false
	end

	return slot3[slot2] and true or false
end

function slot0.getTaskMoList(slot0)
	return TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity128, slot0.__activityId)
end

function slot0.getHighestPoint(slot0, slot1)
	return slot0:getStageInfo(slot1) and slot2.highestPoint or 0
end

function slot0.setHighestPoint(slot0, slot1, slot2, slot3)
	if type(slot2) ~= "number" then
		return
	end

	if not slot0:getStageInfo(slot1)[slot1] then
		return
	end

	if slot3 then
		slot2 = GameUtil.clamp(slot2, 0, slot0.__config:getStageCOMaxPoints(slot1))
	end

	slot4.highestPoint = math.max(slot0:getHighestPoint(slot1), slot2)
end

function slot0.getTotalPoint(slot0, slot1)
	return slot0:getStageInfo(slot1) and slot2.totalPoint or 0
end

function slot0.setTotalPoint(slot0, slot1, slot2)
	if type(slot2) ~= "number" then
		return
	end

	if not slot0:getStageInfo(slot1)[slot1] then
		return
	end

	slot3.totalPoint = math.max(slot0:getTotalPoint(slot1), slot2)
end

function slot0.getStageOpenServerTime(slot0, slot1)
	return slot0:getRealStartTimeStamp() + ((slot0.__config:getEpisodeCOOpenDay(slot1) or 1) - 1) * 86400
end

function slot0.getActMO(slot0)
	return ActivityModel.instance:getActMO(slot0.__activityId)
end

function slot0.isActOnLine(slot0)
	return ActivityHelper.getActivityStatus(slot0.__activityId, true) == ActivityEnum.ActivityStatus.Normal
end

function slot0.getRealStartTimeStamp(slot0)
	return slot0:getActMO():getRealStartTimeStamp()
end

function slot0.getRealEndTimeStamp(slot0)
	return slot0:getActMO():getRealEndTimeStamp()
end

function slot0.getRemainTimeStr(slot0)
	slot1 = ActivityModel.instance:getRemainTimeSec(slot0.__activityId)

	if not slot0.__config then
		return
	end

	return slot0.__config:getRemainTimeStrWithFmt(slot1)
end

function slot0.isBossOnline(slot0, slot1)
	return slot0:getStageOpenServerTime(slot1) <= ServerTime.now()
end

function slot0._updateHasGetBonusIds(slot0, slot1, slot2)
	slot0.__stageHasGetBonusIds[slot1] = {}

	for slot7, slot8 in ipairs(slot2) do
		slot0.__stageHasGetBonusIds[slot1][slot8] = true
	end
end

function slot0._updateSingleHasGetBonusIds(slot0, slot1, slot2)
	if not slot0.__stageHasGetBonusIds[slot1] then
		slot0.__stageHasGetBonusIds[slot1] = {}
	end

	slot0.__stageHasGetBonusIds[slot1][slot2] = true
end

function slot0._updateAll(slot0, slot1)
	slot0._activityId = slot1.activityId

	for slot5, slot6 in ipairs(slot1.bossDetail) do
		slot7 = slot6.bossId
		slot0.__stageInfos[slot7] = slot6

		slot0:_updateHasGetBonusIds(slot7, slot6.hasGetBonusIds)
		slot0:_setLayer4Score(slot6.bossId, slot6 and slot6.layer4TotalPoint or 0)
		slot0:_setLayer4HightScore(slot6.bossId, slot6 and slot6.layer4HighestPoint or 0)
	end
end

function slot0.onReceiveGet128InfosReply(slot0, slot1)
	slot0:_updateAll(slot1)
	slot0:_onReceiveGet128InfosReply(slot1)
end

function slot0._setLayer4Score(slot0, slot1, slot2)
	slot0._layer4Score[slot1] = tonumber(slot2)
end

function slot0.getLayer4CurScore(slot0, slot1)
	return slot0._layer4Score[slot1] or 0
end

function slot0._setLayer4HightScore(slot0, slot1, slot2)
	slot0._layer4HighestScore[slot1] = tonumber(slot2)
end

function slot0.getLayer4HightScore(slot0, slot1)
	return slot0._layer4HighestScore[slot1] or 0
end

function slot0.onReceiveAct128GetTotalRewardsReply(slot0, slot1)
	slot0:_updateHasGetBonusIds(slot1.bossId, slot1.hasGetBonusIds)
	slot0:_onReceiveAct128GetTotalRewardsReply(slot1)
end

function slot0.onReceiveAct128SingleRewardReply(slot0, slot1)
	slot0:_updateSingleHasGetBonusIds(slot1.bossId, slot1.rewardId)
	slot0:_onReceiveAct128SingleRewardReply(slot1)
end

function slot0.onReceiveAct128DoublePointReply(slot0, slot1)
	slot5 = slot0:getStageInfo(slot1.bossId)
	slot5.doubleNum = slot1.doubleNum
	slot5.totalPoint = slot1.totalPoint

	slot0:_onReceiveAct128DoublePointReply(slot1)
end

function slot0.onReceiveAct128InfoUpdatePush(slot0, slot1)
	slot0:_updateAll(slot1)
	slot0:_onReceiveAct128InfoUpdatePush(slot1)
end

function slot0._onReceiveGet128InfosReply(slot0, slot1)
end

function slot0._onReceiveAct128GetTotalRewardsReply(slot0, slot1)
end

function slot0._onReceiveAct128DoublePointReply(slot0, slot1)
end

return slot0
