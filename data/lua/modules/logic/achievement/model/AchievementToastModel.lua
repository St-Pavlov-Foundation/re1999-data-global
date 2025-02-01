module("modules.logic.achievement.model.AchievementToastModel", package.seeall)

slot0 = class("AchievementToastModel", BaseModel)

function slot0.onInit(slot0)
	slot0._waitToastList = {}
	slot0._groupUnlockToastMap = {}
	slot0._groupFinishedToastMap = {}
end

function slot0.reInit(slot0)
	slot0:release()
end

function slot0.release(slot0)
	slot0._waitToastList = nil
	slot0._groupUnlockToastMap = nil
	slot0._groupFinishedToastMap = nil
end

function slot0.updateNeedPushToast(slot0, slot1)
	slot0._waitToastList = slot0._waitToastList or {}
	slot0._waitToastMap = slot0._waitToastMap or {}
	slot0._groupUnlockToastMap = slot0._groupUnlockToastMap or {}
	slot0._groupFinishedToastMap = slot0._groupFinishedToastMap or {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			if slot6 and slot6.new then
				slot0:checkTaskSatify(slot6.id)
			end
		end
	end
end

function slot0.checkTaskSatify(slot0, slot1)
	slot3 = slot0:getToastTypeList()

	if AchievementConfig.instance:getTask(slot1) and slot3 then
		for slot7, slot8 in ipairs(slot3) do
			if slot0:getToastCheckFunction(slot8) and slot9(slot0, slot2) then
				table.insert(slot0._waitToastList, {
					taskId = slot1,
					toastType = slot7
				})
			end
		end
	end
end

function slot0.getToastCheckFunction(slot0, slot1)
	if not slot0._toastCheckFuncTab then
		slot0._toastCheckFuncTab = {
			[AchievementEnum.ToastType.TaskFinished] = slot0.checkIsTaskFinished,
			[AchievementEnum.ToastType.GroupUnlocked] = slot0.checkGroupUnlocked,
			[AchievementEnum.ToastType.GroupUpgrade] = slot0.checkGroupUpgrade,
			[AchievementEnum.ToastType.GroupFinished] = slot0.checkIsGroupFinished
		}
	end

	return slot0._toastCheckFuncTab[slot1]
end

function slot0.getToastTypeList(slot0)
	if not slot0._toastTypeList then
		slot0._toastTypeList = {
			AchievementEnum.ToastType.TaskFinished,
			AchievementEnum.ToastType.GroupUnlocked,
			AchievementEnum.ToastType.GroupUpgrade,
			AchievementEnum.ToastType.GroupFinished
		}
	end

	return slot0._toastTypeList
end

function slot0.checkIsTaskFinished(slot0, slot1)
	return AchievementModel.instance:isAchievementTaskFinished(slot1.id)
end

function slot0.checkGroupUnlocked(slot0, slot1)
	slot2 = false
	slot5 = AchievementConfig.instance:getAchievement(slot1.achievementId) and slot4.groupId

	if AchievementModel.instance:isAchievementTaskFinished(slot1.id) and slot5 and slot5 ~= 0 and not slot0._groupUnlockToastMap[slot5] and (AchievementModel.instance:getGroupFinishTaskList(slot5) and #slot6 or 0) <= 1 then
		slot2 = true
		slot0._groupUnlockToastMap[slot5] = true
	end

	return slot2
end

function slot0.checkGroupUpgrade(slot0, slot1)
	slot3 = false

	if AchievementConfig.instance:getAchievement(slot1.achievementId) and slot2.groupId ~= 0 then
		slot3 = AchievementConfig.instance:getGroup(slot2.groupId) and slot4.unLockAchievement == slot1.id
	end

	return slot3
end

function slot0.checkIsGroupFinished(slot0, slot1)
	slot3 = false

	if AchievementConfig.instance:getAchievement(slot1.achievementId) and slot2.groupId and slot4 ~= 0 and not slot0._groupFinishedToastMap[slot4] and AchievementModel.instance:isGroupFinished(slot2.groupId) then
		slot0._groupFinishedToastMap[slot4] = true
	end

	return slot3
end

function slot0.getWaitToastList(slot0)
	return slot0._waitToastList
end

function slot0.onToastFinished(slot0)
	slot0._waitToastList = nil
end

slot0.instance = slot0.New()

return slot0
