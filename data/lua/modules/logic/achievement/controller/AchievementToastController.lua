module("modules.logic.achievement.controller.AchievementToastController", package.seeall)

slot0 = class("AchievementToastController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:registerCallback(AchievementEvent.LoginShowToast, slot0.handleLoginEnterMainScene, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.checkToastTrigger, slot0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0.checkToastTrigger, slot0)
end

function slot0.reInit(slot0)
	slot0._isLoginScene = false
	slot0._isToastShowing = false

	if slot0._toastLoader then
		slot0._toastLoader:dispose()

		slot0._toastLoader = nil
	end

	AchievementToastModel.instance:release()
end

function slot0.onUpdateAchievements(slot0)
	if not PlayerModel.instance:getPlayinfo() or slot1.userId == 0 then
		return
	end

	if slot0:canPopUpToast() then
		slot0:showNextToast()
	end
end

function slot0.handleLoginEnterMainScene(slot0)
	slot0._isLoginScene = true

	if slot0:canPopUpToast() then
		slot0:showNextToast()
	end
end

function slot0.checkToastTrigger(slot0)
	if slot0:canPopUpToast() then
		slot0:showNextToast()
	end
end

function slot0.canPopUpToast(slot0)
	return slot0._isLoginScene and not ViewMgr.instance:isOpen(ViewName.StoryView) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) and not ViewMgr.instance:isOpen(ViewName.AiZiLaGameView) and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight
end

function slot0.showNextToast(slot0)
	if AchievementToastModel.instance:getWaitToastList() and #slot1 > 0 then
		slot0:tryShowToast(slot1)
		AchievementToastModel.instance:onToastFinished()
	end
end

function slot0.tryShowToast(slot0, slot1)
	if slot1 then
		slot2 = #slot1
		slot7 = 1

		for slot7 = Mathf.Clamp(slot2 - AchievementEnum.ShowMaxToastCount + 1, slot7, slot2), slot2 do
			slot8 = slot1[slot7]

			slot0:showToastByTaskId(slot8.taskId, slot8.toastType)
		end
	end
end

function slot0.showToastByTaskId(slot0, slot1, slot2)
	slot6 = false

	if slot0:getToastShowFunction(slot2) then
		slot6 = slot5(slot0, slot3, AchievementConfig.instance:getAchievement(AchievementConfig.instance:getTask(slot1).achievementId))
	end

	return slot6
end

function slot0.getToastShowFunction(slot0, slot1)
	return uv0.AchievementToastShowFuncTab[slot1]
end

function slot0.onShowTaskFinishedToast(slot0, slot1, slot2)
	slot3 = false

	if slot1 then
		slot4 = formatLuaLang("achievementtoastitem_achievementcompleted", slot0:getToastName(slot2, slot1.level))

		ToastController.instance:showToastWithCustomData(ToastEnum.AchievementCompleted, slot0.fillToastObj, slot0, {
			toastTip = slot4,
			icon = ResUrl.getAchievementIcon("badgeicon/" .. slot1.icon)
		}, slot4)

		slot3 = true
	end

	return slot3
end

function slot0.onShowGroupUnlockedToast(slot0, slot1, slot2)
	slot3 = false

	if slot1 and slot2 then
		slot3 = slot0:showToastByGroupId(AchievementConfig.instance:getAchievement(slot1.achievementId) and slot4.groupId, ToastEnum.AchievementUnLockGroup)
	end

	return slot3
end

function slot0.onShowGroupUpgrade(slot0, slot1, slot2)
	slot4 = false

	if AchievementConfig.instance:getGroup(slot2.groupId) then
		ToastController.instance:showToastWithCustomData(ToastEnum.AchievementGroupUpGrade, slot0.fillToastObj, slot0, {
			toastTip = formatLuaLang("achievementtoastitem_upgradegroup", slot3.name),
			icon = ResUrl.getAchievementIcon("badgeicon/achievementgroupicon")
		}, slot3.name)

		slot4 = true
	end

	return slot4
end

function slot0.onShowGroupFinishedToast(slot0, slot1, slot2)
	slot4 = false

	if (slot2 and slot2.groupId) ~= 0 then
		slot4 = slot0:showToastByGroupId(slot3, ToastEnum.AchievementGroupCollect)
	end

	return slot4
end

function slot0.getToastName(slot0, slot1, slot2)
	if AchievementModel.instance:getAchievementTaskCoList(slot1.id) and #slot3 == 1 then
		return slot1.name
	end

	if LangSettings.instance:isEn() then
		return string.format("%s %s", slot1.name, GameUtil.getRomanNums(slot2))
	else
		return string.format("%s%s", slot1.name, GameUtil.getRomanNums(slot2))
	end
end

function slot0.fillToastObj(slot0, slot1, slot2)
	slot3 = ToastCallbackGroup.New()
	slot3.onClose = slot0.onCloseWhenToastRemove
	slot3.onCloseObj = slot0
	slot3.onCloseParam = slot2
	slot3.onOpen = slot0.onOpenToast
	slot3.onOpenObj = slot0
	slot3.onOpenParam = slot2
	slot1.callbackGroup = slot3
end

function slot0.onOpenToast(slot0, slot1, slot2)
	slot1.item = AchievementToastItem.New()

	slot1.item:init(slot2, slot1)
end

function slot0.onCloseWhenToastRemove(slot0, slot1, slot2)
	if slot1.item then
		slot1.item:dispose()

		slot1.item = nil
	end
end

function slot0.showToastByGroupId(slot0, slot1, slot2)
	if AchievementConfig.instance:getGroup(slot1) then
		ToastController.instance:showToast(slot2, slot3.name)

		return true
	end
end

function slot0.tryGetToastAsset(slot0)
	if slot0._toastLoader and not slot0._toastLoader.isLoading then
		return slot0._toastLoader:getAssetItem(AchievementEnum.AchievementToastPath):GetResource(AchievementEnum.AchievementToastPath)
	end

	if not slot0._toastLoader then
		slot0._toastLoader = slot0._toastLoader or MultiAbLoader.New()

		slot0._toastLoader:addPath(AchievementEnum.AchievementToastPath)
		slot0._toastLoader:startLoad()
	end

	return nil
end

slot0.AchievementToastShowFuncTab = {
	[AchievementEnum.ToastType.TaskFinished] = slot0.onShowTaskFinishedToast,
	[AchievementEnum.ToastType.GroupUnlocked] = slot0.onShowGroupUnlockedToast,
	[AchievementEnum.ToastType.GroupUpgrade] = slot0.onShowGroupUpgrade,
	[AchievementEnum.ToastType.GroupFinished] = slot0.onShowGroupFinishedToast
}
slot0.instance = slot0.New()

return slot0
