module("modules.logic.achievement.view.AchievementSelectItem", package.seeall)

slot0 = class("AchievementSelectItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gosingle = gohelper.findChild(slot0.viewGO, "#go_single")
	slot0._gogroup = gohelper.findChild(slot0.viewGO, "#go_group")
	slot0._gosingleitem = gohelper.findChild(slot0.viewGO, "#go_single/#go_singleitem")
	slot0._gogroupselected = gohelper.findChild(slot0.viewGO, "#go_group/#go_groupselected")
	slot0._btngroupselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_group/#btn_groupselect")
	slot0._gogroupcontainer = gohelper.findChild(slot0.viewGO, "#go_group/#go_groupcontainer")
	slot0._simagegroupbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_group/#simage_groupbg")
	slot0._goallcollect = gohelper.findChild(slot0.viewGO, "#go_group/#go_allcollect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngroupselect:AddClickListener(slot0._btngroupselectOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngroupselect:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._anim = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.onDestroy(slot0)
	if slot0._singleItems then
		for slot4, slot5 in pairs(slot0._singleItems) do
			slot5:dispose()
		end

		slot0._singleItems = nil
	end

	if slot0._groupItems then
		for slot4, slot5 in pairs(slot0._groupItems) do
			slot5:dispose()
		end

		slot0._groupItems = nil
	end

	slot0._simagegroupbg:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._playItemOpenAim, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1 = slot0._mo.groupId ~= 0

	gohelper.setActive(slot0._gosingle, not slot1)
	gohelper.setActive(slot0._gogroup, slot1)

	if slot1 then
		slot0:refreshGroup()
	else
		slot0:refreshSingle()
	end

	slot0:_playAnim()
end

function slot0.refreshSingle(slot0)
	slot0:checkInitSingle()

	for slot4 = 1, AchievementEnum.MainListLineCount do
		gohelper.setActive(slot0._singleItems[slot4].viewGO, slot0._mo.achievementCfgs[slot4] ~= nil)

		if slot6 then
			if AchievementController.instance:getMaxLevelFinishTask(slot6.id) then
				slot5:setData(slot8)
			else
				gohelper.setActive(slot5.viewGO, false)
			end
		end
	end
end

function slot0.refreshGroup(slot0)
	if AchievementConfig.instance:getGroup(slot0._mo.groupId) then
		slot0._simagegroupbg:LoadImage(AchievementConfig.instance:getGroupBgUrl(slot1, AchievementEnum.GroupParamType.List, AchievementModel.instance:isAchievementTaskFinished(slot2.unLockAchievement)))
		slot0:refreshSingleInGroup()
	end

	gohelper.setActive(slot0._gogroupselected, AchievementSelectListModel.instance:isGroupSelected(slot1))
end

function slot0.refreshSingleInGroup(slot0)
	slot2 = {}

	if AchievementConfig.instance:getGroupParamIdTab(slot0._mo.groupId, AchievementEnum.GroupParamType.List) then
		for slot7, slot8 in ipairs(slot1) do
			slot9 = slot0:getOrCreateSingleItemInGroup(slot7)
			slot2[slot9] = true

			slot0:_setGroupAchievementPosAndScale(slot9.viewGO, slot0._mo.groupId, slot7)
			gohelper.setActive(slot9.viewGO, AchievementConfig.instance:getAchievementsByGroupId(slot0._mo.groupId)[slot8] ~= nil)

			if slot10 then
				if AchievementController.instance:getMaxLevelFinishTask(slot10.id) then
					slot9:setData(slot11)
					slot9:setNameTxtVisible(false)
					slot9:setSelectIconVisible(false)
					slot9:setBgVisible(false)
					gohelper.setActive(slot9.viewGO, not AchievementModel.instance:achievementHasLocked(slot10.id))
				else
					gohelper.setActive(slot9.viewGO, false)
				end
			end
		end
	end

	if slot2 and slot0._groupItems then
		for slot6, slot7 in pairs(slot0._groupItems) do
			if not slot2[slot7] then
				gohelper.setActive(slot7.viewGO, false)
			end
		end
	end

	gohelper.setActive(slot0._goallcollect, AchievementModel.instance:isGroupFinished(slot0._mo.groupId))
end

function slot0.getOrCreateSingleItemInGroup(slot0, slot1)
	slot0._groupItems = slot0._groupItems or {}

	if not slot0._groupItems[slot1] then
		slot2 = AchievementMainIcon.New()

		slot2:init(slot0._view:getResInst(AchievementEnum.MainIconPath, slot0._gogroupcontainer, "#go_icon" .. slot1))

		slot0._groupItems[slot1] = slot2
	end

	return slot2
end

function slot0._setGroupAchievementPosAndScale(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6, slot7 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(slot2, slot3, AchievementEnum.GroupParamType.List)

	if slot1 then
		recthelper.setAnchor(slot1.transform, slot4 or 0, slot5 or 0)
		transformhelper.setLocalScale(slot1.transform, slot6 or 1, slot7 or 1, 1)
	end
end

slot0.IconStartX = -535
slot0.IconIntervalX = 265

function slot0.checkInitSingle(slot0)
	if slot0._singleItems then
		return
	end

	slot0._singleItems = {}

	for slot4 = 1, AchievementEnum.MainListLineCount do
		slot5 = AchievementSelectIcon.New()
		slot6 = gohelper.cloneInPlace(slot0._gosingleitem, "item" .. tostring(slot4))

		slot5:init(slot6, slot0._view:getResInst(AchievementEnum.MainIconPath, slot6, "#go_icon"))
		recthelper.setAnchorX(slot6.transform, uv0.IconStartX + (slot4 - 1) * uv0.IconIntervalX)

		slot0._singleItems[slot4] = slot5
	end
end

function slot0._btngroupselectOnClick(slot0)
	AchievementSelectController.instance:changeGroupSelect(slot0._mo.groupId)
	AudioMgr.instance:trigger(AchievementSelectListModel.instance:isGroupSelected(slot0._mo.groupId) and AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone)
end

slot0.AnimDelayDelta = 0.06
slot0.OneScreenItemCountInSingle = 3
slot0.OneScreenItemCountInGroup = 2

function slot0._playAnim(slot0)
	TaskDispatcher.cancelTask(slot0._playItemOpenAim, slot0)
	slot0._anim:Play("close", 0, 0)

	if slot0._index <= (slot0._mo.groupId ~= 0 and uv0.OneScreenItemCountInGroup or uv0.OneScreenItemCountInSingle) and AchievementSelectListModel.instance:getItemAniHasShownIndex() < slot0._index then
		TaskDispatcher.runDelay(slot0._playItemOpenAim, slot0, uv0.AnimDelayDelta * (slot0._index - 1))
	else
		slot0._anim:Play("idle", 0, 0)
	end
end

function slot0._playItemOpenAim(slot0)
	slot0._anim:Play("open", 0, 0)
	AchievementSelectListModel.instance:setItemAniHasShownIndex(slot0._index)
end

return slot0
