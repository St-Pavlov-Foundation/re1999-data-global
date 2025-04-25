module("modules.logic.activity.model.ActivityModel", package.seeall)

slot0 = class("ActivityModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._actInfo = {}
	slot0._finishActTab = {}
	slot0._actMoTab = {}
	slot0._isNoviceTaskUnlock = false
	slot0._targetActivityCategoryId = 0
end

function slot0.setActivityInfo(slot0, slot1)
	slot0._actInfo = {}

	for slot5, slot6 in ipairs(slot1.activityInfos) do
		if ActivityConfig.instance:getActivityCo(slot6.id) then
			slot8 = ActivityInfoMo.New()

			slot8:init(slot6)

			slot0._actInfo[slot6.id] = slot8
		end
	end
end

function slot0.updateActivityInfo(slot0, slot1)
	slot2 = ActivityInfoMo.New()

	slot2:init(slot1)

	slot0._actInfo[slot1.id] = slot2
end

function slot0.updateInfoNoRepleace(slot0, slot1)
	if not slot0._actInfo[slot1.id] then
		slot0._actInfo[slot1.id] = ActivityInfoMo.New()
	end

	slot2:init(slot1)
end

function slot0.endActivity(slot0, slot1)
	if slot0._actInfo[slot1] then
		slot0._actInfo[slot1].online = false
	end
end

function slot0.getActivityInfo(slot0)
	return slot0._actInfo
end

function slot0.getActMO(slot0, slot1)
	return slot0._actInfo[slot1]
end

function slot0.isActOnLine(slot0, slot1)
	return slot0._actInfo[slot1] and slot0._actInfo[slot1].online
end

function slot0.getOnlineActIdByType(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in pairs(slot0._actInfo) do
		if slot7.actType == slot1 and slot7.online then
			table.insert(slot2 or {}, slot6)
		end
	end

	return slot2
end

function slot0.getActStartTime(slot0, slot1)
	return slot0._actInfo[slot1].startTime
end

function slot0.getActEndTime(slot0, slot1)
	return slot0._actInfo[slot1].endTime
end

function slot0.hasActivityUnlock(slot0, slot1)
	for slot5, slot6 in pairs(slot0._actInfo) do
		if slot6.online then
			return true
		end
	end

	return false
end

function slot0.getTargetActivityCategoryId(slot0, slot1)
	if not next(slot0._actInfo) then
		slot0._targetActivityCategoryId = 0

		return 0
	end

	for slot5, slot6 in pairs(slot0._actInfo) do
		if slot6.id == slot0._targetActivityCategoryId and slot6.centerId == slot1 and slot6.online then
			return slot0._targetActivityCategoryId
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot0._actInfo) do
		if slot7.centerId == slot1 and slot7.online then
			table.insert(slot2, slot7.id)

			slot0._actMoTab[slot7.id] = slot7
		end
	end

	slot2 = slot0:removeUnExitAct(slot2)

	table.sort(slot2, function (slot0, slot1)
		return ActivityConfig.instance:getActivityCo(slot0).displayPriority < ActivityConfig.instance:getActivityCo(slot1).displayPriority
	end)

	slot0._targetActivityCategoryId = #slot2 > 0 and slot2[1] or 0

	return slot0._targetActivityCategoryId
end

function slot0.setTargetActivityCategoryId(slot0, slot1)
	slot0._targetActivityCategoryId = slot1
end

function slot0.getCurTargetActivityCategoryId(slot0)
	return slot0._targetActivityCategoryId
end

function slot0.addFinishActivity(slot0, slot1)
	slot0._finishActTab[slot1] = slot1
end

function slot0.removeUnExitAct(slot0, slot1)
	if GameUtil.getTabLen(slot1) == 0 then
		return
	end

	for slot5, slot6 in pairs(slot0._finishActTab) do
		tabletool.removeValue(slot1, slot6)
	end

	return slot1
end

function slot0.getActivityCenter(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._actInfo) do
		if slot6.centerId ~= 0 and slot6.online then
			if not slot1[slot6.centerId] then
				slot1[slot6.centerId] = {}
			end

			table.insert(slot1[slot6.centerId], slot6.id)
		end
	end

	return slot1
end

function slot0.getCenterActivities(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._actInfo) do
		if slot7.centerId == slot1 and slot7.online then
			table.insert(slot2, slot7.id)
		end
	end

	return slot2
end

function slot0.hasNorSignRewardUnReceived(slot0)
	if ActivityType101Model.instance:getType101Info(ActivityEnum.Activity.NorSign) then
		for slot5, slot6 in pairs(slot1) do
			if slot6.state == 1 then
				return true
			end
		end
	end

	return false
end

function slot0.hasNoviceSignRewardUnReceived(slot0)
	if ActivityType101Model.instance:getType101Info(ActivityEnum.Activity.NoviceSign) then
		for slot5, slot6 in pairs(slot1) do
			if slot6.state == 1 then
				return true
			end
		end
	end

	return false
end

function slot0.getRemainTime(slot0, slot1)
	if slot0:getActMO(slot1) then
		slot3 = slot2.endTime / 1000 - ServerTime.now()
		slot5 = slot3 % TimeUtil.OneDaySecond

		return Mathf.Floor(slot3 / TimeUtil.OneDaySecond), Mathf.Floor(slot5 / TimeUtil.OneHourSecond), Mathf.Ceil(slot5 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond)
	end
end

function slot0.removeFinishedCategory(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot6 == ActivityEnum.Activity.DreamShow and TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.ActivityShow) and next(slot7) and TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow) and slot8[1].config.maxFinishCount <= slot8[1].finishCount then
			slot1[slot5] = nil

			slot0:addFinishActivity(slot6)
		end
	end
end

function slot0.removeFinishedWelfare(slot0, slot1)
	slot2 = false
	slot3 = ActivityType101Model.instance:hasReceiveAllReward(ActivityEnum.Activity.NoviceSign)
	slot4 = TeachNoteModel.instance:isFinalRewardGet()
	slot5 = nil

	for slot9, slot10 in pairs(slot1) do
		if slot10 == ActivityEnum.Activity.StoryShow and TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
			slot2 = true
			slot1[slot9] = nil

			slot0:addFinishActivity(slot10)
		end

		if slot10 == ActivityEnum.Activity.ClassShow and slot4 then
			slot1[slot9] = nil

			slot0:addFinishActivity(slot10)
		end

		if slot10 == ActivityEnum.Activity.NoviceSign and slot3 then
			slot1[slot9] = nil

			slot0:addFinishActivity(slot10)
		end

		if slot10 == ActivityEnum.Activity.NewWelfare then
			slot5 = slot9
		end
	end

	if slot5 and not Activity160Model.instance:hasRewardCanGet(ActivityEnum.Activity.NewWelfare) and slot4 and slot2 and slot3 then
		slot1[slot5] = nil

		slot0:addFinishActivity(ActivityEnum.Activity.NewWelfare)
	end
end

function slot0.getRemainTimeSec(slot0, slot1)
	if slot0:getActMO(slot1) then
		return slot2.endTime / 1000 - ServerTime.now()
	end
end

function slot0.setPermanentUnlock(slot0, slot1)
	if slot0:getActMO(slot1) then
		slot2:setPermanentUnlock()
	end
end

function slot0.isReceiveAllBonus(slot0, slot1)
	if slot0:getActMO(slot1) then
		return slot2.isReceiveAllBonus
	end

	return false
end

function slot0.checkIsShowLogoVisible()
	if not ActivityConfig.instance:getMainActAtmosphereConfig() then
		return false
	end

	return slot0.isShowLogo or false
end

function slot0.checkIsShowActBgVisible()
	if not ActivityConfig.instance:getMainActAtmosphereConfig() then
		return false
	end

	return slot0.isShowActBg or false
end

function slot0.showActivityEffect()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FastDungeon) then
		return false
	end

	if not DungeonModel.instance:hasPassLevelAndStory(ActivityEnum.ShowVersionActivityEpisode) then
		return false
	end

	if not ActivityConfig.instance:getMainActAtmosphereConfig() then
		return false
	end

	if ActivityHelper.getActivityStatus(slot1.id) == ActivityEnum.ActivityStatus.Normal or slot3 == ActivityEnum.ActivityStatus.NotUnlock then
		return true
	end

	return false
end

slot0.instance = slot0.New()

return slot0
