module("modules.logic.achievement.view.AchievementMainViewFocus", package.seeall)

slot0 = class("AchievementMainViewFocus", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchCategory, slot0.onSwitchCategory, slot0)
	slot0:addEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchViewType, slot0.onSwitchViewType, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchCategory, slot0.onSwitchCategory, slot0)
	slot0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchViewType, slot0.onSwitchViewType, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.focus2OriginAchievement, slot0)
	TaskDispatcher.cancelTask(slot0.triggerAchievementUnLockAduio, slot0)
	TaskDispatcher.cancelTask(slot0.setHasPlayOpenAnim, slot0)
	TaskDispatcher.cancelTask(slot0.onFocusNewestUpgradeGroupSucc, slot0)

	if slot0._scrollFocusTweenId then
		ZProj.TweenHelper.KillById(slot0._scrollFocusTweenId)

		slot0._scrollFocusTweenId = nil
	end
end

function slot0.onOpen(slot0)
	slot0:checkIsNeedFocusAchievement()
end

function slot0.onClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_Focus")
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_FocusOrigin")
end

slot1 = 2

function slot0.checkIsNeedFocusAchievement(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_FocusOrigin")
	TaskDispatcher.cancelTask(slot0.focus2OriginAchievement, slot0)
	TaskDispatcher.runDelay(slot0.focus2OriginAchievement, slot0, slot0:checkIsNeedFocusNewest() and uv0 or 0)
end

function slot0.checkIsNeedFocusNewest(slot0)
	return slot0:try2FocusNewestUpgradeGroup() or slot0:try2FocusNewestUnlockAchievement()
end

function slot0.focus2OriginAchievement(slot0)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_FocusOrigin")

	slot2 = slot0.viewParam and slot0.viewParam.focusDataId
	slot3 = false

	if slot0.viewParam and slot0.viewParam.achievementType and slot2 and slot2 ~= 0 then
		slot3 = slot0:try2FocusAchievement(slot1, slot2)
	else
		slot0:setHasPlayOpenAnim()
	end

	return slot3
end

function slot0.onSwitchCategory(slot0)
	if not slot0:checkIsNeedFocusNewest() then
		slot0:resetViewScrollPixel()
	end
end

function slot0.onSwitchViewType(slot0)
	if not slot0:checkIsNeedFocusNewest() then
		slot0:resetViewScrollPixel()
	end
end

function slot0.try2FocusAchievement(slot0, slot1, slot2)
	slot4, slot5, slot6 = AchievementMainCommonModel.instance:getViewAchievementIndex(AchievementMainCommonModel.instance:getCurrentViewType(), slot1, slot2)
	slot7 = 0

	if slot4 then
		slot7 = slot0:scrollView2TargetPixel(slot3, slot6, slot5)
	else
		logError(string.format("focus achievement failed, achievementType = %s, dataId = %s", slot1, slot2))
	end

	return slot4, slot7
end

slot2 = 0.0001
slot3 = 0
slot4 = 1

function slot0.scrollView2TargetPixel(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_Focus")
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)

	slot5 = slot0.viewContainer:getScrollView(slot1) and slot4:getCsScroll()
	slot0._curFocusAchievementIndex = slot3
	slot6 = 0

	if slot4 and slot5 then
		slot0._curFocusCsScroll = slot5
		slot9 = math.abs((slot2 or 0) - slot5.VerticalScrollPixel)
		slot6 = Mathf.Clamp(slot9 * uv0, uv1, uv2)

		if slot9 <= 0 then
			slot0:_onFocusTweenFrameCallback(slot8)
			slot0:_onFocusTweenFinishCallback()
		else
			if slot0._scrollFocusTweenId then
				ZProj.TweenHelper.KillById(slot0._scrollFocusTweenId)
			end

			slot0._scrollFocusTweenId = ZProj.TweenHelper.DOTweenFloat(slot7, slot8, slot6, slot0._onFocusTweenFrameCallback, slot0._onFocusTweenFinishCallback, slot0)
		end
	end

	return slot6
end

function slot0._onFocusTweenFrameCallback(slot0, slot1)
	if slot0._curFocusCsScroll then
		slot0._curFocusCsScroll.VerticalScrollPixel = slot1
	end
end

slot5 = 0.05

function slot0._onFocusTweenFinishCallback(slot0)
	AchievementMainTileModel.instance:markScrollFocusIndex(Mathf.Clamp(slot0._curFocusAchievementIndex - 1, 1, slot0._curFocusAchievementIndex))
	TaskDispatcher.cancelTask(slot0.setHasPlayOpenAnim, slot0)
	TaskDispatcher.runDelay(slot0.setHasPlayOpenAnim, slot0, uv0)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_Focus")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.setHasPlayOpenAnim(slot0)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(false)
	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnFocusAchievementFinished, AchievementMainCommonModel.instance:getCurrentViewType())
	AchievementMainTileModel.instance:setHasPlayOpenAnim(true)
end

function slot0.try2FocusNewestUpgradeGroup(slot0)
	slot2 = false
	slot3 = 0

	if slot0:getNewestUpgradeGroup() and slot1 ~= 0 then
		slot4, slot3 = slot0:try2FocusAchievement(AchievementEnum.AchievementType.Group, slot1)

		if slot4 then
			slot0._focusUpgradeGroupId = slot1

			AchievementMainCommonModel.instance:markGroupPlayUpgradeEffect(slot1)
			TaskDispatcher.cancelTask(slot0.onFocusNewestUpgradeGroupSucc, slot0)
			TaskDispatcher.runDelay(slot0.onFocusNewestUpgradeGroupSucc, slot0, slot3 + uv0 + 0.1)
		end
	end

	return slot2
end

function slot0.onFocusNewestUpgradeGroupSucc(slot0)
	AchievementController.instance:dispatchEvent(AchievementEvent.OnGroupUpGrade, slot0._focusUpgradeGroupId)
	slot0:triggerAchievementUnLockAduio()
end

function slot0.getNewestUpgradeGroup(slot0)
	return AchievementMainCommonModel.instance:getNewestUpgradeGroupId(AchievementMainCommonModel.instance:getCurrentCategory(), AchievementMainCommonModel.instance:getCurrentFilterType())
end

function slot0.try2FocusNewestUnlockAchievement(slot0)
	slot2 = false
	slot3 = 0

	if slot0:getNewestUnlockAchievement() and slot1 ~= 0 then
		slot4 = AchievementConfig.instance:getAchievement(slot1)
		slot6 = AchievementEnum.AchievementType.Single
		slot7 = slot1

		if AchievementMainCommonModel.instance:getCurrentViewType() == AchievementEnum.ViewType.Tile and slot4.groupId ~= 0 then
			slot6 = AchievementEnum.AchievementType.Group
			slot7 = slot4.groupId
		end

		slot8, slot3 = slot0:try2FocusAchievement(slot6, slot7)

		if slot8 then
			TaskDispatcher.cancelTask(slot0.triggerAchievementUnLockAduio, slot0)
			TaskDispatcher.runDelay(slot0.triggerAchievementUnLockAduio, slot0, slot3 + uv0)
		end
	end

	return slot2
end

function slot0.triggerAchievementUnLockAduio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_medal)
end

function slot0.getNewestUnlockAchievement(slot0)
	return AchievementMainCommonModel.instance:getNewestUnlockAchievementId(AchievementMainCommonModel.instance:getCurrentCategory(), AchievementMainCommonModel.instance:getCurrentFilterType())
end

function slot0.resetViewScrollPixel(slot0)
	for slot4, slot5 in pairs(AchievementEnum.ViewType) do
		(slot0.viewContainer:getScrollView(slot5) and slot6:getCsScroll()).VerticalScrollPixel = 0

		slot0:scrollView2TargetPixel(slot5, 0, 1)
	end
end

return slot0
