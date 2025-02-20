module("modules.logic.achievement.view.AchievementMainListItem", package.seeall)

slot0 = class("AchievementMainListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gotop1 = gohelper.findChild(slot0.viewGO, "go_top")
	slot0._gotop2 = gohelper.findChild(slot0.viewGO, "go_top2")
	slot0._txtachievementname = gohelper.findChildText(slot0.viewGO, "go_top/image_AchievementNameBG/#txt_achievementname")
	slot0._simageAchievementGroupBG = gohelper.findChildSingleImage(slot0.viewGO, "go_top2/#simage_AchievementGroupBG")
	slot0._txtachievementgroupname = gohelper.findChildText(slot0.viewGO, "go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname")
	slot0._golayout = gohelper.findChild(slot0.viewGO, "go_layout")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "go_layout/go_taskitem")
	slot0._btnpopup = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_top2/#btn_popup")
	slot0._gooff = gohelper.findChild(slot0.viewGO, "go_top2/#btn_popup/#go_off")
	slot0._goon = gohelper.findChild(slot0.viewGO, "go_top2/#btn_popup/#go_on")
	slot0._goallcollect = gohelper.findChild(slot0.viewGO, "go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname/#go_allcollect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnpopup:AddClickListener(slot0._btnpopupOnClick, slot0)
	slot0:addEventCb(AchievementMainController.instance, AchievementEvent.OnPlayGroupFadeAnim, slot0._onPlayGroupFadeAnimation, slot0)
	slot0:addEventCb(AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, slot0._onFocusFinished, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnpopup:RemoveClickListener()
end

function slot0._btnpopupOnClick(slot0)
	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnClickGroupFoldBtn, AchievementConfig.instance:getAchievement(slot0._mo.id).groupId, not slot0._mo:getIsFold())
end

function slot0._onPlayGroupFadeAnimation(slot0, slot1)
	if not slot1 or not slot1.achievementId or slot2 ~= slot0._mo.id then
		return
	end

	slot0._isFold = slot1.isFold

	if not slot0._isFold then
		slot0._mo:setIsFold(slot0._isFold)
	end

	slot0._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(slot1.orginLineHeight, slot1.targetLineHeight, slot1.duration, slot0._onOpenTweenFrameCallback, slot0._onOpenTweenFinishCallback, slot0, nil)
end

function slot0._onOpenTweenFrameCallback(slot0, slot1)
	slot0._mo:overrideLineHeight(slot1)
	AchievementMainListModel.instance:onModelUpdate()
end

function slot0._onOpenTweenFinishCallback(slot0)
	slot0._mo:clearOverrideLineHeight()
	slot0._mo:setIsFold(slot0._isFold)
	AchievementMainListModel.instance:onModelUpdate()
end

function slot0._editableInitView(slot0)
	slot0._taskItemTab = slot0:getUserDataTb_()
	slot0._topAnimator = gohelper.onceAddComponent(slot0._gotop1, gohelper.Type_Animator)
end

function slot0.onDestroy(slot0)
	slot0._simageAchievementGroupBG:UnLoadImage()
	slot0:recycleAchievementMainIcon()
end

function slot0.onUpdateMO(slot0, slot1)
	if slot0._mo and slot0._mo ~= slot1 and slot0._openAnimTweenId then
		ZProj.TweenHelper.KillById(slot0._openAnimTweenId)

		slot0._openAnimTweenId = nil
	end

	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if AchievementConfig.instance:getAchievement(slot0._mo.id) then
		slot0._groupId = slot1.groupId

		slot0:refreshTaskList(slot0._mo:getFilterTaskList(AchievementMainCommonModel.instance:getCurrentSortType(), AchievementMainCommonModel.instance:getCurrentFilterType()))
		slot0:refreshTopUI(slot1)
	end
end

slot1 = 1
slot2 = 0.5
slot3 = 1
slot4 = 0.5
slot5 = "#FFFFFF"
slot6 = "#4D4D4D"

function slot0.refreshTaskList(slot0, slot1)
	slot2 = nil
	slot3 = slot0._mo:getIsFold()

	gohelper.setActive(slot0._golayout, not slot3)
	gohelper.setActive(slot0._goon, not slot3)
	gohelper.setActive(slot0._gooff, slot3)

	slot0._hasTaskFinished = false

	if not slot3 and slot1 then
		slot2 = {
			[slot0:getOrCreateTaskItem(slot7)] = true
		}

		for slot7, slot8 in ipairs(slot1) do
			slot11 = AchievementModel.instance:getById(slot8.id) and slot10.hasFinished
			slot9.txtTaskDesc2.text = slot8.extraDesc

			slot9.taskIcon:setData(slot8)
			slot9.taskIcon:setIconColor(slot11 and uv0 or uv1)
			ZProj.UGUIHelper.SetColorAlpha(slot9.txtTaskDesc2, slot11 and uv2 or uv3)
			ZProj.UGUIHelper.SetColorAlpha(slot9.txtTaskDesc, slot11 and uv4 or uv5)
			gohelper.setActive(slot9.goUnLockTime, slot11)
			gohelper.setActive(slot9.goNormalBG, slot11)
			gohelper.setActive(slot9.golockedBG, not slot11)

			if slot11 then
				slot9.txtUnLockedTime.text = TimeUtil.localTime2ServerTimeString(slot10.finishTime)
				slot9.txtTaskDesc.text = slot8.desc
				slot0._hasTaskFinished = true
			else
				slot9.txtTaskDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockPath"), {
					slot8.desc,
					slot10 and slot10.progress or 0,
					slot8.maxProgress
				})
			end

			slot0:playTaskAnim(slot9)
			slot0:tryPlayUpgradeEffect(slot10, slot9)
		end
	end

	slot0:recycleUnuseTaskItem(slot2)
	slot0:onTasksPlayUpgradeEffectFinished()
end

function slot0.tryPlayUpgradeEffect(slot0, slot1, slot2)
	if AchievementMainCommonModel.instance:isCurrentScrollFocusing() or not slot0.viewGO.activeInHierarchy or not slot1 or not slot2 then
		return
	end

	slot0._achievementId = AchievementConfig.instance:getTask(slot1.id) and slot3.achievementId
	slot0._isNeedPlayEffect = false

	if slot1 and slot1.hasFinished and slot1.isNew and not AchievementMainCommonModel.instance:isAchievementPlayEffect(slot0._achievementId) then
		slot0._isNeedPlayEffect = true
	end

	gohelper.setActive(slot2.goupgrade, slot0._isNeedPlayEffect)

	if slot0._isNeedPlayEffect then
		slot2.goupgradeAnimator:Play("upgrade2", 0, AchievementMainCommonModel.instance:isTaskPlayFinishedEffect(slot1.id) and 1 or 0)

		if not slot5 then
			AchievementMainCommonModel.instance:markTaskPlayFinishedEffect(slot1.id)
		end
	end
end

function slot0.onTasksPlayUpgradeEffectFinished(slot0)
	if slot0._isNeedPlayEffect and slot0._achievementId then
		AchievementMainCommonModel.instance:markAchievementPlayEffect(slot0._achievementId)
	end
end

function slot0._onFocusFinished(slot0, slot1)
	if slot1 ~= AchievementEnum.ViewType.List then
		return
	end

	if slot0._taskItemTab then
		slot8 = AchievementMainCommonModel.instance:getCurrentFilterType()

		for slot8, slot9 in ipairs(slot0._mo:getFilterTaskList(AchievementMainCommonModel.instance:getCurrentSortType(), slot8)) do
			slot0:tryPlayUpgradeEffect(AchievementModel.instance:getById(slot9.id), slot0:getOrCreateTaskItem(slot8))
		end

		slot0:onTasksPlayUpgradeEffectFinished()
	end
end

function slot0.playTaskAnim(slot0, slot1)
	if not slot1 or not slot1.viewGO.activeInHierarchy then
		return
	end

	if AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim() then
		slot1.animator:Play("idle", 0, 0)
	else
		slot1.animator:Play("open", 0, 0)
	end
end

function slot0.getOrCreateTaskItem(slot0, slot1)
	if not slot0._taskItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._gotaskitem, "task_" .. slot1)
		slot2.goNormalBG = gohelper.findChild(slot2.viewGO, "#go_NormalBG")
		slot2.golockedBG = gohelper.findChild(slot2.viewGO, "#go_lockedBG")
		slot2.txtTaskDesc = gohelper.findChildText(slot2.viewGO, "Descr/txt_taskdesc")
		slot2.txtTaskDesc2 = gohelper.findChildText(slot2.viewGO, "Descr/txt_taskdesc2")
		slot2.goUnLockTime = gohelper.findChild(slot2.viewGO, "UnLockedTime")
		slot2.txtUnLockedTime = gohelper.findChildText(slot2.viewGO, "UnLockedTime/#txt_UnLockedTime")
		slot2.goupgrade = gohelper.findChild(slot2.viewGO, "#go_upgrade")
		slot2.goupgradeAnimator = gohelper.onceAddComponent(slot2.goupgrade, gohelper.Type_Animator)
		slot2.goIcon = gohelper.findChild(slot2.viewGO, "go_icon")
		slot2.animator = gohelper.onceAddComponent(slot2.viewGO, gohelper.Type_Animator)

		if slot0._view and slot0._view.viewContainer and slot0._view.viewContainer:getPoolView() then
			slot2.taskIcon = slot3:getIcon(slot2.goIcon)

			slot2.taskIcon:setNameTxtVisible(false)
			slot2.taskIcon:setClickCall(slot0._iconClickCallBack, slot0)
		end

		slot0._taskItemTab[slot1] = slot2
	end

	gohelper.setActive(slot2.viewGO, true)

	return slot2
end

function slot0._iconClickCallBack(slot0)
end

function slot0.recycleUnuseTaskItem(slot0, slot1)
	if slot1 and slot0._taskItemTab then
		for slot5, slot6 in pairs(slot0._taskItemTab) do
			if not slot1[slot6] then
				gohelper.setActive(slot6.viewGO, false)
			end
		end
	end
end

function slot0.refreshTopUI(slot0, slot1)
	if slot1 and slot1.groupId ~= 0 and slot0._mo.isGroupTop then
		slot0:refreshGroupTopUI(AchievementConfig.instance:getGroup(slot1.groupId))
	end

	if not slot0._mo:getIsFold() then
		slot0:refreshSingleTopUI(slot1)
	end

	gohelper.setActive(slot0._gotop1, not slot4)
	gohelper.setActive(slot0._gotop2, slot3)

	if not slot4 then
		slot0:playTopAnim()
	end
end

function slot0.playTopAnim(slot0)
	if not slot0._gotop1.activeInHierarchy then
		return
	end

	if AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim() then
		slot0._topAnimator:Play("idle", 0, 0)
	else
		slot0._topAnimator:Play("open", 0, 0)
	end
end

slot7 = 1
slot8 = 0.5

function slot0.refreshSingleTopUI(slot0, slot1)
	if slot1 then
		slot0._txtachievementname.text = slot1.name

		ZProj.UGUIHelper.SetColorAlpha(slot0._txtachievementname, slot0._hasTaskFinished and uv0 or uv1)
	end
end

function slot0.refreshGroupTopUI(slot0, slot1)
	if slot1 then
		slot0._txtachievementgroupname.text = slot1.name

		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtachievementgroupname, AchievementConfig.instance:getGroupTitleColorConfig(slot1.id, AchievementEnum.GroupParamType.Player))
		slot0._simageAchievementGroupBG:LoadImage(ResUrl.getAchievementIcon(string.format("grouptitle/%s", slot1.id)))
		gohelper.setActive(slot0._goallcollect, AchievementModel.instance:isGroupFinished(slot1.id))
	end
end

function slot0.recycleAchievementMainIcon(slot0)
	if slot0._taskItemTab then
		for slot4, slot5 in pairs(slot0._taskItemTab) do
			slot5.taskIcon:dispose()
		end
	end
end

return slot0
