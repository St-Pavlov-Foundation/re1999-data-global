module("modules.logic.versionactivity2_5.challenge.model.Act183Model", package.seeall)

slot0 = class("Act183Model", BaseModel)

function slot0.reInit(slot0)
	slot0._activityId = nil
	slot0._actInfo = nil
	slot0._readyUseBadgeNum = nil
	slot0._selectConditions = nil
	slot0._recordRepressEpisodeId = nil

	slot0:clearBattleFinishedInfo()

	slot0._unfinishTaskMap = nil
	slot0._initDone = false
end

function slot0.init(slot0, slot1, slot2)
	slot0._activityId = slot1
	slot0._actInfo = Act183InfoMO.New()

	slot0._actInfo:init(slot2)

	slot0._initDone = true
end

function slot0.isInitDone(slot0)
	return slot0._initDone
end

function slot0.getActInfo(slot0)
	return slot0._actInfo
end

function slot0.getGroupEpisodeMo(slot0, slot1)
	return slot0._actInfo and slot0._actInfo:getGroupEpisodeMo(slot1)
end

function slot0.getEpisodeMo(slot0, slot1, slot2)
	if slot0:getGroupEpisodeMo(slot1) then
		return slot3:getEpisodeMo(slot2)
	end
end

function slot0.getEpisodeMoById(slot0, slot1)
	if Act183Config.instance:getEpisodeCo(slot1) then
		return slot0:getEpisodeMo(slot2.groupId, slot1)
	end
end

function slot0.setActivityId(slot0, slot1)
	if slot1 then
		slot0._activityId = slot1
	end
end

function slot0.getActivityId(slot0)
	return slot0._activityId or VersionActivity2_5Enum.ActivityId.Challenge
end

function slot0.getBadgeNum(slot0)
	if not slot0._actInfo then
		logError("活动数据不存在")

		return
	end

	return slot0._actInfo:getBadgeNum()
end

function slot0.recordEpisodeReadyUseBadgeNum(slot0, slot1)
	slot0._readyUseBadgeNum = slot1 or 0
end

function slot0.getEpisodeReadyUseBadgeNum(slot0)
	return slot0._readyUseBadgeNum or 0
end

function slot0.clearEpisodeReadyUseBadgeNum(slot0)
	slot0._readyUseBadgeNum = nil
end

function slot0.getUnlockSupportHeros(slot0)
	return slot0._actInfo and slot0._actInfo:getUnlockSupportHeros()
end

function slot0.recordBattleFinishedInfo(slot0, slot1)
	slot0:clearBattleFinishedInfo()

	slot0._battleFinishedInfo = slot1

	if slot0._actInfo and slot0._battleFinishedInfo then
		slot0:recordNewFinishEpisodeId()
		slot0:recordNewFinishGroupId()
		slot0:recordNewUnlockHardMainGroup()
	end
end

function slot0.getBattleFinishedInfo(slot0)
	return slot0._battleFinishedInfo
end

function slot0.clearBattleFinishedInfo(slot0)
	slot0._battleFinishedInfo = nil
	slot0._newFinishEpisodeId = nil
	slot0._newFinishGroupId = nil
	slot0._isHardMainGroupNewUnlock = false
end

function slot0.isHeroRepressInEpisode(slot0, slot1, slot2)
	return slot0:getGroupEpisodeMo(Act183Config.instance:getEpisodeCo(slot1) and slot3.groupId) and slot5:isHeroRepress(slot2)
end

function slot0.isHeroRepressInPreEpisode(slot0, slot1, slot2)
	return slot0:getGroupEpisodeMo(Act183Config.instance:getEpisodeCo(slot1) and slot3.groupId):isHeroRepressInPreEpisode(slot1, slot2)
end

function slot0.recordEpisodeSelectConditions(slot0, slot1)
	slot0._selectConditions = {}

	for slot5, slot6 in pairs(slot1) do
		if slot6 == true then
			table.insert(slot0._selectConditions, slot5)
		end
	end
end

function slot0.getRecordEpisodeSelectConditions(slot0)
	return slot0._selectConditions
end

function slot0.recordNewFinishEpisodeId(slot0)
	if slot0._battleFinishedInfo.win then
		slot2 = slot0._battleFinishedInfo.episodeMo

		if slot0:getEpisodeMoById(slot2:getEpisodeId()):getStatus() ~= slot2:getStatus() then
			slot0._newFinishEpisodeId = slot3
		end
	end
end

function slot0.recordNewFinishGroupId(slot0)
	if slot0._battleFinishedInfo.win and slot0._battleFinishedInfo.groupFinished then
		slot3 = slot0._battleFinishedInfo.episodeMo

		if not (slot0:getGroupEpisodeMo(slot3:getGroupId()) and slot6:isGroupFinished()) and (slot6 and slot6:getEpisodeCount() or 0) <= slot3:getPassOrder() then
			slot0._newFinishGroupId = slot4
		end
	end
end

function slot0.recordNewUnlockHardMainGroup(slot0)
	if slot0._newFinishGroupId and (slot0:getGroupEpisodeMo(slot0._newFinishGroupId) and slot1:getGroupType()) == Act183Enum.GroupType.NormalMain and not slot1:isHasFinished() then
		slot0._isHardMainGroupNewUnlock = true
	end
end

function slot0.getNewFinishEpisodeId(slot0)
	return slot0._newFinishEpisodeId
end

function slot0.isEpisodeNewUnlock(slot0, slot1)
	if (slot0:getEpisodeMoById(slot1) and slot2:getStatus()) ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	if not slot0._battleFinishedInfo then
		return
	end

	if slot2:getPreEpisodeIds() then
		return tabletool.indexOf(slot4, slot0._battleFinishedInfo.episodeMo and slot5:getEpisodeId()) ~= nil
	end
end

function slot0.getNewFinishGroupId(slot0)
	return slot0._newFinishGroupId
end

function slot0.isHardMainGroupNewUnlock(slot0)
	return slot0._isHardMainGroupNewUnlock
end

function slot0.initTaskStatusMap(slot0)
	if slot0._initUnfinishTaskMapDone then
		return
	end

	slot0._unfinishTaskMap = {}

	if TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity183, slot0._activityId) then
		for slot5, slot6 in ipairs(slot1) do
			slot8 = slot6.config and slot7.groupId
			slot0._unfinishTaskMap[slot8] = slot0._unfinishTaskMap[slot8] or {}

			if not Act183Helper.isTaskFinished(slot7.id) then
				table.insert(slot0._unfinishTaskMap[slot8], slot7.id)
			end
		end
	end

	slot0._initUnfinishTaskMapDone = true
end

function slot0.getUnfinishTaskMap(slot0)
	return slot0._unfinishTaskMap
end

function slot0.recordLastRepressEpisodeId(slot0, slot1)
	slot0._recordRepressEpisodeId = slot1
end

function slot0.getRecordLastRepressEpisodeId(slot0)
	return slot0._recordRepressEpisodeId
end

function slot0.clearRecordLastRepressEpisodeId(slot0)
	slot0._recordRepressEpisodeId = nil
end

slot0.instance = slot0.New()

return slot0
