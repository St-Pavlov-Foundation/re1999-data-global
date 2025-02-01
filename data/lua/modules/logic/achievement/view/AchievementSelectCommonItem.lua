module("modules.logic.achievement.view.AchievementSelectCommonItem", package.seeall)

slot0 = class("AchievementSelectCommonItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._editableInitView(slot0)
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
	slot0._isFirstEnter = true
end

function slot0.onDestroy(slot0)
	slot0:releaseAchievementMainIcons()
	TaskDispatcher.cancelTask(slot0.playItemOpenAim, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:buildAchievementCfgs()
	slot0:refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.refreshUI(slot0)
	slot0:refreshAchievements()
	slot0:playAchievementOpenAnim()
end

slot0.LockedIconColor = "#808080"
slot0.UnLockedIconColor = "#FFFFFF"
slot0.LockedNameAlpha = 0.5
slot0.UnLockedNameAlpha = 1

function slot0.refreshAchievements(slot0)
	for slot7 = 1, slot0:getAchievementCfgs() and #slot1 do
		slot8 = slot1[slot7]
		slot9 = slot0:getOrCreateAchievementIcon(slot7)

		gohelper.setActive(slot9.viewGO, true)
		slot0:refreshAchievement(slot9, slot8, slot7)
		slot0:refreshAchievementIconPositionAndScale(slot9, slot8, slot7)
	end

	slot0:recycleUnuseAchievementIcon({
		[slot9] = true
	})
end

function slot0.buildAchievementCfgs(slot0)
	slot0._achievementCfgs = slot0._mo.achievementCfgs
end

function slot0.getAchievementCfgs(slot0)
	return slot0._achievementCfgs
end

function slot0.refreshAchievement(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if AchievementController.instance:getMaxLevelFinishTask(slot2.id) then
		slot1:setData(slot5)
		slot1:setNameTxtVisible(false)
		slot1:setBgVisible(false)
		gohelper.setActive(slot1.viewGO, not AchievementModel.instance:achievementHasLocked(slot4))
	else
		gohelper.setActive(slot1.viewGO, false)
	end
end

function slot0.refreshAchievementIconPositionAndScale(slot0, slot1, slot2, slot3)
end

function slot0.getOrCreateAchievementIcon(slot0, slot1)
	slot0._achievementIconTab = slot0._achievementIconTab or slot0:getUserDataTb_()

	if not slot0._achievementIconTab[slot1] then
		slot0._achievementIconTab[slot1] = slot0:createAchievementIcon(slot1)
	end

	return slot2
end

function slot0.createAchievementIcon(slot0, slot1)
	slot2 = AchievementMainIcon.New()

	slot2:init(slot0._view:getResInst(slot0:getAchievementIconResUrl(), slot0:getAchievementIconParentGO(), "icon" .. tostring(slot1)))
	slot2:setClickCall(slot0.onClickSingleAchievementIcon, slot0, slot1)

	return slot2
end

function slot0.getAchievementIconParentGO(slot0)
	return slot0.viewGO
end

function slot0.getAchievementIconResUrl(slot0)
	return AchievementEnum.MainIconPath
end

function slot0.recycleUnuseAchievementIcon(slot0, slot1)
	if slot1 and slot0._achievementIconTab then
		for slot5, slot6 in pairs(slot0._achievementIconTab) do
			if not slot1[slot6] then
				gohelper.setActive(slot6.viewGO, false)
			end
		end
	end
end

function slot0.releaseAchievementMainIcons(slot0)
	if slot0._achievementIconTab then
		for slot4, slot5 in pairs(slot0._achievementIconTab) do
			if slot5 and slot5.dispose then
				slot5:dispose()
			end
		end
	end

	slot0._achievementIconTab = nil
end

slot0.AnimDelayDelta = 0.06

function slot0.playAchievementAnim(slot0, slot1)
	slot0:playAchievementOpenAnim(slot1)
end

function slot0.playAchievementOpenAnim(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.playItemOpenAim, slot0)

	if slot0._isNeedPlayOpenAnim then
		slot0._animator:Play("close", 0, 0)
		TaskDispatcher.runDelay(slot0.playItemOpenAim, slot0, uv0.AnimDelayDelta * Mathf.Clamp(slot0._index - (slot1 or 1), 0, slot0._index))

		slot0._isNeedPlayOpenAnim = false
	else
		slot0._animator:Play("idle", 0, 0)
	end
end

function slot0.playItemOpenAim(slot0)
	slot0._animator:Play("open", 0, 0)

	slot0._isFirstEnter = false
end

function slot0.resetFistEnter(slot0, slot1)
	slot0._isNeedPlayOpenAnim = true

	slot0:playAchievementAnim(slot1)
end

return slot0
