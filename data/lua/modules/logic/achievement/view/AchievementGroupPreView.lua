module("modules.logic.achievement.view.AchievementGroupPreView", package.seeall)

slot0 = class("AchievementGroupPreView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_view")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")
	slot0._simagegroupbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_groupbg")
	slot0._goherogroupcontainer = gohelper.findChild(slot0.viewGO, "#go_groupcontainer")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnview:AddClickListener(slot0._btnviewOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclose2:AddClickListener(slot0._btnclose2OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnview:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(AchievementController.instance, AchievementEvent.UpdateAchievements, slot0.refreshGroup, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:disposeAchievementMainIcon()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achievementgrouppreview_open)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)
	slot0:refreshGroup()
end

slot0.LockedIconColor = "#808080"
slot0.UnLockedIconColor = "#FFFFFF"
slot0.LockedNameAlpha = 0.5
slot0.UnLockedNameAlpha = 1

function slot0.refreshGroup(slot0)
	slot0:refreshGroupBg()
	slot0:refreshAchievementInGroup()
end

function slot0.refreshGroupBg(slot0)
	if AchievementConfig.instance:getGroup(slot0.viewParam.groupId) then
		slot0._simagegroupbg:LoadImage(AchievementConfig.instance:getGroupBgUrl(slot0.viewParam.groupId, AchievementEnum.GroupParamType.List, AchievementModel.instance:isAchievementTaskFinished(slot1.unLockAchievement)))
		SLFramework.UGUI.GuiHelper.SetColor(slot0._groupBgImage, AchievementModel.instance:achievementGroupHasLocked(slot0.viewParam.groupId) and uv0.LockedGroupBgColor or uv0.UnLockedGroupBgColor)
	end
end

function slot0.refreshAchievementInGroup(slot0)
	slot2 = AchievementConfig.instance:getAchievementsByGroupId(slot0.viewParam.groupId)
	slot3 = {
		[slot11] = true
	}

	for slot8 = 1, #AchievementConfig.instance:getGroupParamIdTab(slot0.viewParam.groupId, AchievementEnum.GroupParamType.List) do
		slot11 = slot0:getOrCreateAchievementIcon(slot0.viewParam.groupId, slot9, slot8)

		gohelper.setActive(slot11.viewGO, AchievementController.instance:getMaxLevelFinishTask(slot2[slot1[slot8]] and slot2[slot9].id) ~= nil)

		if slot12 then
			slot11:setData(slot12)

			slot13 = AchievementModel.instance:achievementHasLocked(slot10)

			slot11:setIsLocked(slot13)
			slot11:setIconColor(slot13 and uv0.LockedIconColor or uv0.UnLockedIconColor)
			slot11:setSelectIconVisible(false)
			slot11:setNameTxtVisible(false)
			slot11:setBgVisible(false)

			slot4 = false or slot0:playIconAnim(slot11, slot10)
		end
	end

	if slot4 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_medal)
	end

	if slot0._iconItems then
		for slot8, slot9 in pairs(slot0._iconItems) do
			if not slot3[slot9] then
				gohelper.setActive(slot9.viewGO, false)
			end
		end
	end
end

function slot0.playIconAnim(slot0, slot1, slot2)
	slot6 = false

	if AchievementModel.instance:achievementHasNew(slot2) then
		if not slot1:isPlaingAnimClip(AchievementMainIcon.AnimClip.New) and not slot1:isPlaingAnimClip(AchievementMainIcon.AnimClip.Loop) then
			slot1:playAnim(AchievementMainIcon.AnimClip.New)

			slot6 = true
		end
	else
		slot1:playAnim(AchievementMainIcon.AnimClip.Idle)
	end

	return slot6
end

function slot0.getOrCreateAchievementIcon(slot0, slot1, slot2, slot3)
	slot0._iconItems = slot0._iconItems or {}

	if not slot0._iconItems[slot3] then
		slot4 = AchievementMainIcon.New()

		slot4:init(slot0:getResInst(AchievementEnum.MainIconPath, slot0._goherogroupcontainer, "icon" .. tostring(slot3)))
		slot4:setClickCall(slot0.onClickAchievementIcon, slot0, slot2)

		slot0._iconItems[slot3] = slot4
	end

	slot0:setGroupAchievementPosAndScale(slot4.viewGO, slot1, slot3)

	return slot4
end

function slot0.onClickAchievementIcon(slot0, slot1)
	if AchievementConfig.instance:getAchievementsByGroupId(slot0.viewParam.groupId) and slot2[slot1] then
		slot4 = {}

		for slot8, slot9 in ipairs(slot2) do
			table.insert(slot4, slot9.id)
		end

		ViewMgr.instance:openView(ViewName.AchievementLevelView, {
			achievementId = slot3.id,
			achievementIds = slot4
		})
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
		slot0:cleanAchievementNewFlag(slot3.id)
	end
end

function slot0.setGroupAchievementPosAndScale(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6, slot7 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(slot2, slot3, AchievementEnum.GroupParamType.List)

	if slot1 then
		recthelper.setAnchor(slot1.transform, slot4 or 0, slot5 or 0)
		transformhelper.setLocalScale(slot1.transform, slot6 or 1, slot7 or 1, 1)
	end
end

function slot0.disposeAchievementMainIcon(slot0)
	if slot0._iconItems then
		for slot4, slot5 in pairs(slot0._iconItems) do
			if slot5.dispose then
				slot5:dispose()
			end
		end
	end
end

function slot0.cleanGroupNewFlag(slot0)
	slot2 = {}

	if AchievementConfig.instance:getAchievementsByGroupId(slot0.viewParam.groupId) then
		for slot6, slot7 in ipairs(slot1) do
			if AchievementModel.instance:getAchievementTaskCoList(slot7.id) then
				for slot12, slot13 in ipairs(slot8) do
					if AchievementModel.instance:getById(slot13.id) and slot14.isNew then
						table.insert(slot2, slot13.id)
					end
				end
			end
		end
	end

	if #slot2 > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(slot2)
	end
end

function slot0.cleanAchievementNewFlag(slot0, slot1)
	slot3 = {}

	if AchievementConfig.instance:getTasksByAchievementId(slot1) then
		for slot7, slot8 in ipairs(slot2) do
			if AchievementModel.instance:getById(slot8.id) and slot9.isNew then
				table.insert(slot3, slot8.id)
			end
		end
	end

	if #slot3 > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(slot3)
	end
end

function slot0.onClose(slot0)
	slot0:cleanGroupNewFlag()
end

function slot0._btnviewOnClick(slot0)
	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Group, slot0.viewParam and slot0.viewParam.groupId)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclose2OnClick(slot0)
	slot0:closeThis()
end

return slot0
