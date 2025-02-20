module("modules.logic.playercard.view.comp.PlayerCardAchievement", package.seeall)

slot0 = class("PlayerCardAchievement", BasePlayerCardComp)

function slot0.onInitView(slot0)
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0.txtDec = gohelper.findChildTextMesh(slot0.viewGO, "#txt_dec")
	slot0.goAchievement = gohelper.findChild(slot0.viewGO, "#go_achievement")
	slot0.goSingle = gohelper.findChild(slot0.goAchievement, "#go_singlecontainer")
	slot0.goSingleItem = gohelper.findChild(slot0.goAchievement, "#go_singlecontainer/horizontal/#go_singleitem")
	slot0.goSingleSelectedEffect = gohelper.findChild(slot0.goAchievement, "#go_singlecontainer/selected_eff")
	slot0.goGroup = gohelper.findChild(slot0.goAchievement, "#go_group")
	slot0.groupSimageBg = gohelper.findChildSingleImage(slot0.goAchievement, "#go_group/#image_bg")
	slot0.goGroupContainer = gohelper.findChild(slot0.goAchievement, "#go_group/#go_groupcontainer")
	slot0.goGroupSelectedEffect = gohelper.findChild(slot0.goAchievement, "#go_group/selected_eff")
	slot0.goEmpty = gohelper.findChild(slot0.goAchievement, "#go_showempty")
	slot0._singleAchieveTabs = {}
	slot0._iconItems = {}
end

function slot0.playSelelctEffect(slot0)
	gohelper.setActive(slot0.goGroupSelectedEffect, false)
	gohelper.setActive(slot0.goGroupSelectedEffect, true)
	gohelper.setActive(slot0.goSingleSelectedEffect, false)
	gohelper.setActive(slot0.goSingleSelectedEffect, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function slot0.addEventListeners(slot0)
	slot0.btnClick:AddClickListener(slot0.btnClickOnClick, slot0)
	slot0:addEventCb(AchievementController.instance, AchievementEvent.AchievementSaveSucc, slot0.onRefreshView, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnClick:RemoveClickListener()
	slot0:removeEventCb(AchievementController.instance, AchievementEvent.AchievementSaveSucc, slot0.onRefreshView, slot0)
end

function slot0.btnClickOnClick(slot0)
	if slot0:isPlayerSelf() and slot0.compType == PlayerCardEnum.CompType.Normal then
		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
			ViewMgr.instance:openView(ViewName.AchievementSelectView)
		else
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
		end
	end
end

function slot0.onRefreshView(slot0)
	if slot0.cardInfo.achievementCount == -1 then
		slot0.txtDec.text = PlayerCardEnum.EmptyString2
	else
		slot0.txtDec.text = tostring(slot1.achievementCount)
	end

	slot0:_refreshAchievements()
end

function slot0._refreshAchievements(slot0)
	slot3, slot4 = PlayerViewAchievementModel.instance:getShowAchievements(slot0:getPlayerInfo().showAchievement)
	slot5 = not slot4 or tabletool.len(slot4) <= 0

	gohelper.setActive(slot0.goEmpty, slot5)
	gohelper.setActive(slot0.goGroup, slot3 and not slot5)
	gohelper.setActive(slot0.goSingle, not slot3 and not slot5)

	if slot0.notIsFirst and slot0.showStr ~= slot2 then
		slot0:playSelelctEffect()
	end

	slot0.showStr = slot2
	slot0.notIsFirst = true

	if slot5 then
		return
	end

	if not slot3 then
		slot0:_refreshSingle(slot4)
	else
		for slot9, slot10 in pairs(slot4) do
			slot0:_refreshGroup(slot9, slot10)

			break
		end
	end
end

function slot0._refreshSingle(slot0, slot1)
	slot2 = 1

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot0:_getOrCreateSingleItem(slot2)

		gohelper.setActive(slot8.viewGo, true)
		gohelper.setActive(slot8.goempty, false)
		gohelper.setActive(slot8.gohas, true)

		if AchievementConfig.instance:getTask(slot7) then
			slot8.simageicon:LoadImage(ResUrl.getAchievementIcon("badgeicon/" .. slot9.icon))
		end

		slot2 = slot2 + 1
	end

	for slot6 = slot2, AchievementEnum.ShowMaxSingleCount do
		slot7 = slot0:_getOrCreateSingleItem(slot6)

		gohelper.setActive(slot7.viewGo, true)
		gohelper.setActive(slot7.goempty, true)
		gohelper.setActive(slot7.gohas, false)
	end
end

function slot0._getOrCreateSingleItem(slot0, slot1)
	if not slot0._singleAchieveTabs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGo = gohelper.cloneInPlace(slot0.goSingleItem, "singleitem_" .. slot1)
		slot2.goempty = gohelper.findChild(slot2.viewGo, "go_empty")
		slot2.gohas = gohelper.findChild(slot2.viewGo, "go_has")
		slot2.simageicon = gohelper.findChildSingleImage(slot2.viewGo, "go_has/simage_icon")

		table.insert(slot0._singleAchieveTabs, slot1, slot2)
	end

	return slot0._singleAchieveTabs[slot1]
end

function slot0._refreshGroup(slot0, slot1, slot2)
	if AchievementConfig.instance:getGroup(slot1) then
		slot0.groupSimageBg:LoadImage(AchievementConfig.instance:getGroupBgUrl(slot1, AchievementEnum.GroupParamType.List, AchievementModel.instance:isAchievementTaskFinished(slot3.unLockAchievement)))
		slot0:refreshSingleInGroup(slot1, slot2)
	end
end

function slot0.refreshSingleInGroup(slot0, slot1, slot2)
	slot3 = AchievementConfig.instance:getAchievementsByGroupId(slot1)
	slot5 = {}
	slot11 = #slot0._iconItems

	for slot11 = 1, math.max(slot11, AchievementConfig.instance:getGroupParamIdTab(slot1, AchievementEnum.GroupParamType.List) and #slot6 or 0) do
		slot12 = slot0:_getOrCreateGroupItem(slot11)
		slot13 = slot3 and slot3[slot6[slot11]]

		slot0:_setGroupAchievementPosAndScale(slot12.viewGO, slot1, slot11)
		gohelper.setActive(slot12.viewGO, slot13 ~= nil)

		if slot13 then
			slot14 = slot13.id

			if slot0:getExistTaskCo(slot0:buildAchievementAndTaskMap(slot2), slot13) then
				slot12:setData(slot15)
				slot12:setIconVisible(true)
				slot12:setBgVisible(false)
				slot12:setNameTxtVisible(false)
			else
				gohelper.setActive(slot12.viewGO, false)
			end
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

function slot0._setGroupAchievementPosAndScale(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6, slot7 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(slot2, slot3, AchievementEnum.GroupParamType.List)

	if slot1 then
		recthelper.setAnchor(slot1.transform, slot4 or 0, slot5 or 0)
		transformhelper.setLocalScale(slot1.transform, slot6 or 1, slot7 or 1, 1)
	end
end

function slot0.getExistTaskCo(slot0, slot1, slot2)
	return slot1[slot2.id]
end

function slot0._getOrCreateGroupItem(slot0, slot1)
	if not slot0._iconItems[slot1] then
		slot2 = AchievementMainIcon.New()

		slot2:init(gohelper.clone(slot0.itemRes, slot0.goGroupContainer, tostring(slot1)))

		slot0._iconItems[slot1] = slot2
	end

	return slot0._iconItems[slot1]
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

	if slot0._iconItems then
		for slot4, slot5 in pairs(slot0._iconItems) do
			slot5:dispose()
		end

		slot0._iconItems = nil
	end
end

function slot0.onDestroy(slot0)
	slot0:_tryDisposeSingleItems()
	slot0.groupSimageBg:UnLoadImage()
end

return slot0
