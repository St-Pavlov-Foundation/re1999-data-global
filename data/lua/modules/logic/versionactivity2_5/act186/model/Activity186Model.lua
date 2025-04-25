module("modules.logic.versionactivity2_5.act186.model.Activity186Model", package.seeall)

slot0 = class("Activity186Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.localPrefsDict = {}
end

function slot0.getActId(slot0)
	return ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.Act186) and slot1[1]
end

function slot0.isActivityOnline(slot0)
	if not slot0:getActId() then
		return false
	end

	return ActivityModel.instance:isActOnLine(slot1)
end

function slot0.setActInfo(slot0, slot1)
	slot0:getActMo(slot1.activityId):updateInfo(slot1)
end

function slot0.getActMo(slot0, slot1)
	if not slot0:getById(slot1) then
		slot2 = Activity186MO.New()

		slot2:init(slot1)
		slot0:addAtLast(slot2)
	end

	return slot2
end

function slot0.onFinishAct186Task(slot0, slot1)
	if slot0:getById(slot1.activityId) then
		slot2:finishTask(slot1.taskId)
	end
end

function slot0.onGetAct186MilestoneReward(slot0, slot1)
	if slot0:getById(slot1.activityId) then
		slot2:acceptRewards(slot1.getMilestoneProgress)
	end
end

function slot0.onGetAct186DailyCollection(slot0, slot1)
	if slot0:getById(slot1.activityId) then
		slot2:onGetDailyCollection()
	end
end

function slot0.onAct186TaskPush(slot0, slot1)
	if slot0:getById(slot1.activityId) then
		slot2:pushTask(slot1.act186Tasks, slot1.deleteTasks)
	end
end

function slot0.onAct186LikePush(slot0, slot1)
	if slot0:getById(slot1.activityId) then
		slot2:pushLike(slot1.likeInfos)
	end
end

function slot0.onFinishAct186Game(slot0, slot1)
	if slot0:getById(slot1.activityId) then
		slot2:finishGame(slot1)
	end
end

function slot0.onBTypeGamePlay(slot0, slot1)
	if slot0:getById(slot1.activityId) then
		slot2:playBTypeGame(slot1)
	end
end

function slot0.onGetAct186SpBonusInfo(slot0, slot1)
	slot0:getActMo(slot1.act186ActivityId):setSpBonusStage(slot1.spBonusStage)
end

function slot0.onAcceptAct186SpBonus(slot0, slot1)
	slot0:getActMo(slot1.act186ActivityId):setSpBonusStage(2)
end

function slot0.onGetOnceBonusReply(slot0, slot1)
	if slot0:getById(slot1.activityId) then
		slot2:onGetOnceBonus(slot1)
	end
end

function slot0.getLocalPrefsTab(slot0, slot1, slot2)
	if not slot0.localPrefsDict[slot0:prefabKeyPrefs(slot1, slot2)] then
		slot4 = {}

		if GameUtil.splitString2(Activity186Controller.instance:getPlayerPrefs(slot3), true) then
			for slot10, slot11 in ipairs(slot6) do
				slot4[slot11[1]] = slot11[2]
			end
		end

		slot0.localPrefsDict[slot3] = slot4
	end

	return slot0.localPrefsDict[slot3]
end

function slot0.getLocalPrefsState(slot0, slot1, slot2, slot3, slot4)
	return slot0:getLocalPrefsTab(slot1, slot2)[slot3] or slot4
end

function slot0.setLocalPrefsState(slot0, slot1, slot2, slot3, slot4)
	if slot0:getLocalPrefsTab(slot1, slot2)[slot3] == slot4 then
		return
	end

	slot5[slot3] = slot4
	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		table.insert(slot6, string.format("%s#%s", slot10, slot11))
	end

	Activity186Controller.instance:setPlayerPrefs(slot0:prefabKeyPrefs(slot1, slot2), table.concat(slot6, "|"))
end

function slot0.prefabKeyPrefs(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return slot1
	end

	return string.format("%s_%s", slot1, slot2)
end

function slot0.checkReadTasks(slot0, slot1)
	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			slot0:checkReadTask(slot6)
		end
	end
end

function slot0.checkReadTask(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0:getActMo(slot0:getActId()) then
		return
	end

	if not slot2:getTaskInfo(slot1) then
		return
	end

	if slot3.hasGetBonus then
		return
	end

	if slot2:checkTaskCanReward(slot3) then
		return
	end

	TaskRpc.instance:sendFinishReadTaskRequest(slot1)
end

function slot0.isShowSignRed(slot0)
	if ActivityHelper.getActivityStatus(ActivityEnum.Activity.V2a5_Act186Sign) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	slot3 = false

	if slot0:getById(slot0:getActId()) then
		slot3 = slot5.spBonusStage == 1
	end

	return slot3 or ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot1)
end

slot0.instance = slot0.New()

return slot0
