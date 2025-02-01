module("modules.logic.player.view.PlayerViewAchievement", package.seeall)

slot0 = class("PlayerViewAchievement", BaseView)

function slot0.onInitView(slot0)
	slot0._goachievement = gohelper.findChild(slot0.viewGO, "go_achievement")
	slot0._goshow = gohelper.findChild(slot0.viewGO, "go_achievement/#go_show")
	slot0._btneditachievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_achievement/#go_show/#btn_editachievement")
	slot0._gosinglecontainer = gohelper.findChild(slot0.viewGO, "go_achievement/#go_show/#go_singlecontainer")
	slot0._gogroupcontainer = gohelper.findChild(slot0.viewGO, "go_achievement/#go_show/#go_groupcontainer")
	slot0._gosingleitem = gohelper.findChild(slot0.viewGO, "go_achievement/#go_show/#go_singlecontainer/horizontal/#go_singleitem")
	slot0._goshowempty = gohelper.findChild(slot0.viewGO, "go_achievement/#go_show/#go_showempty")
	slot0._simagegroupbg = gohelper.findChildSingleImage(slot0.viewGO, "go_achievement/#go_show/#go_groupcontainer/#simage_groupbg")
	slot0._gogrouparea = gohelper.findChild(slot0.viewGO, "go_achievement/#go_show/#go_groupcontainer/#go_grouparea")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "go_achievement/#go_show/#go_groupcontainer/#txt_Title")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btneditachievement:AddClickListener(slot0._btneditachievementOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btneditachievement:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_tryDisposeSingleItems()
	slot0:_tryDisposeGroupItems()
	slot0._simagegroupbg:UnLoadImage()
end

function slot0.onOpen(slot0)
	slot0._playerSelf = slot0.viewParam.playerSelf
	slot0._info = slot0.viewParam.playerInfo
	slot0._singleAchieveTabs = {}

	slot0:addEventCb(AchievementController.instance, AchievementEvent.AchievementSaveSucc, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(AchievementController.instance, AchievementEvent.AchievementSaveSucc, slot0.refreshUI, slot0)
end

function slot0.refreshUI(slot0)
	slot0:_refreshAchievements()
end

function slot0._getOrCreateSingleItem(slot0, slot1)
	if not slot0._singleAchieveTabs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGo = gohelper.cloneInPlace(slot0._gosingleitem, "singleitem_" .. slot1)
		slot2.goempty = gohelper.findChild(slot2.viewGo, "go_empty")
		slot2.gohas = gohelper.findChild(slot2.viewGo, "go_has")
		slot2.simageicon = gohelper.findChildSingleImage(slot2.viewGo, "go_has/simage_icon")

		table.insert(slot0._singleAchieveTabs, slot1, slot2)
	end

	return slot0._singleAchieveTabs[slot1]
end

function slot0._refreshAchievements(slot0)
	slot2, slot3 = PlayerViewAchievementModel.instance:getShowAchievements(slot0._playerSelf and PlayerModel.instance:getShowAchievement() or slot0._info.showAchievement)
	slot4 = not slot3 or tabletool.len(slot3) <= 0

	gohelper.setActive(slot0._goshowempty, slot4)
	gohelper.setActive(slot0._gogroupcontainer, slot2 and not slot4)
	gohelper.setActive(slot0._gosinglecontainer, not slot2 and not slot4)

	if slot4 then
		return
	end

	if not slot2 then
		slot5 = 1

		for slot9, slot10 in ipairs(slot3) do
			slot11 = slot0:_getOrCreateSingleItem(slot5)

			gohelper.setActive(slot11.viewGo, true)
			gohelper.setActive(slot11.goempty, false)
			gohelper.setActive(slot11.gohas, true)

			if AchievementConfig.instance:getTask(slot10) then
				slot11.simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. slot12.icon))
			end

			slot5 = slot5 + 1
		end

		for slot9 = slot5, AchievementEnum.ShowMaxSingleCount do
			slot10 = slot0:_getOrCreateSingleItem(slot9)

			gohelper.setActive(slot10.viewGo, true)
			gohelper.setActive(slot10.goempty, true)
			gohelper.setActive(slot10.gohas, false)
		end
	else
		for slot8, slot9 in pairs(slot3) do
			slot0:_refreshGroupAchievements(slot8, slot9)
		end
	end
end

function slot0._refreshGroupAchievements(slot0, slot1, slot2)
	if AchievementConfig.instance:getGroup(slot1) then
		slot0:_refreshGroupTitle(slot3)
		slot0:_refreshGroupBg(slot3, slot2)
		slot0:_buildAchievementIconInGroup(slot1, slot2)
	end
end

function slot0._refreshGroupBg(slot0, slot1, slot2)
	slot3 = false

	if slot1 and slot1.unLockAchievement ~= 0 and slot2 then
		slot3 = tabletool.indexOf(slot2, slot1.unLockAchievement) ~= nil
	end

	slot0._simagegroupbg:LoadImage(AchievementConfig.instance:getGroupBgUrl(slot1.id, AchievementEnum.GroupParamType.Player, slot3))
end

function slot0._refreshGroupTitle(slot0, slot1)
	if slot1 then
		slot0._txtTitle.text = tostring(slot1.name)

		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtTitle, AchievementConfig.instance:getGroupTitleColorConfig(slot1.id, AchievementEnum.GroupParamType.Player))
	end
end

function slot0._buildAchievementIconInGroup(slot0, slot1, slot2)
	slot3 = AchievementConfig.instance:getAchievementsByGroupId(slot1)
	slot4 = slot0:buildAchievementAndTaskMap(slot2)
	slot5 = {}

	if AchievementConfig.instance:getGroupParamIdTab(slot1, AchievementEnum.GroupParamType.Player) then
		for slot10, slot11 in ipairs(slot6) do
			slot12 = slot0:getOrCreateSingleItemInGroup(slot10)

			slot0:_setGroupAchievementPosAndScale(slot12.viewGO, slot1, slot10)

			slot5[slot12] = true
			slot13 = slot3 and slot3[slot11]

			gohelper.setActive(slot12.viewGO, slot13 ~= nil)

			if slot13 then
				slot12:setSelectIconVisible(false)
				slot12:setNameTxtVisible(false)

				if slot0:getExistTaskCo(slot4, slot13) then
					slot12:setData(slot14)
					slot12:setIconVisible(true)
					slot12:setBgVisible(false)
				else
					gohelper.setActive(slot12.viewGO, false)
				end
			end
		end
	end

	for slot10, slot11 in pairs(slot0._groupItems) do
		if not slot5[slot11] then
			gohelper.setActive(slot11.viewGO, false)
		end
	end
end

function slot0.buildAchievementAndTaskMap(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if not slot2[AchievementConfig.instance:getTask(slot7).achievementId] then
				slot2[slot9] = slot8
			end
		end
	end

	return slot2
end

function slot0.getExistTaskCo(slot0, slot1, slot2)
	return slot1[slot2.id]
end

function slot0.getOrCreateSingleItemInGroup(slot0, slot1)
	slot0._groupItems = slot0._groupItems or slot0:getUserDataTb_()

	if not slot0._groupItems[slot1] then
		slot2 = AchievementMainIcon.New()

		slot2:init(slot0:getResInst(AchievementEnum.MainIconPath, slot0._gogrouparea, "#go_icon" .. slot1))

		slot0._groupItems[slot1] = slot2
	end

	return slot2
end

function slot0._setGroupAchievementPosAndScale(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6, slot7 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(slot2, slot3, AchievementEnum.GroupParamType.Player)

	if slot1 then
		recthelper.setAnchor(slot1.transform, slot4 or 0, slot5 or 0)
		transformhelper.setLocalScale(slot1.transform, slot6 or 1, slot7 or 1, 1)
	end
end

function slot0._btneditachievementOnClick(slot0)
	if slot0._playerSelf then
		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
			ViewMgr.instance:openView(ViewName.AchievementSelectView)
		else
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
		end
	end
end

function slot0._tryDisposeSingleItems(slot0)
	if slot0._singleAchieveTabs then
		for slot4, slot5 in pairs(slot0._singleAchieveTabs) do
			if slot5.simageicon then
				slot5.simageicon:UnLoadImage()
			end
		end

		slot0._singleAchieveTabs = nil
	end
end

function slot0._tryDisposeGroupItems(slot0)
	if slot0._groupItems then
		for slot4, slot5 in pairs(slot0._groupItems) do
			slot5:dispose()
		end

		slot0._groupItems = nil
	end
end

return slot0
