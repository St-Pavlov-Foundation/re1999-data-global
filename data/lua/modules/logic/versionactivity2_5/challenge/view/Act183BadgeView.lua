module("modules.logic.versionactivity2_5.challenge.view.Act183BadgeView", package.seeall)

slot0 = class("Act183BadgeView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._txtbadgecount = gohelper.findChildText(slot0.viewGO, "root/left/#txt_badgecount")
	slot0._scrolldaily = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#scroll_daily")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "root/right/#scroll_daily/Viewport/Content/#go_heroitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._actInfo = Act183Model.instance:getActInfo()
	slot0._activityId = Act183Model.instance:getActivityId()
	slot0._curBadgeNum = Act183Model.instance:getBadgeNum()
	slot0._maxBadgeNum = Act183Helper.getMaxBadgeNum()
	slot0._badgeCos = Act183Config.instance:getActivityBadgeCos(slot0._activityId)
	slot0._heroItemTab = slot0:getUserDataTb_()
	slot0._heroMoList = slot0:getUserDataTb_()
	slot0._needPlayAnimHeroItems = slot0:getUserDataTb_()
	slot0._leftAnim = gohelper.findChildComponent(slot0.viewGO, "root/left", gohelper.Type_Animator)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenBadgeView)
	slot0:refreshPreBadge()
	slot0:refreshSupportHeros()
	slot0:saveHasReadUnlockSupportHeroIds()
end

function slot0.onOpenFinish(slot0)
	slot0:playHeroItemAnim()
	slot0:refreshCurBadge()
end

function slot0.refreshPreBadge(slot0)
	slot0._lastSaveBadgeNum = Act183Helper.getLastTotalBadgeNumInLocal(slot0._activityId)
	slot0._txtbadgecount.text = string.format("<size=64>%s</size>/%s", slot0._lastSaveBadgeNum, slot0._maxBadgeNum)
end

function slot0.refreshCurBadge(slot0)
	slot0._leftAnim:Play(slot0._lastSaveBadgeNum ~= slot0._curBadgeNum and "refresh" or "idle", 0, 0)

	slot0._txtbadgecount.text = string.format("<size=64>%s</size>/%s", slot0._curBadgeNum, slot0._maxBadgeNum)

	Act183Helper.saveLastTotalBadgeNumInLocal(slot0._activityId, slot0._curBadgeNum)
end

function slot0.refreshSupportHeros(slot0)
	if not slot0._badgeCos then
		return
	end

	slot0._hasReadUnlockHeroIdMap = Act183Helper.listToMap(Act183Helper.getHasReadUnlockSupportHeroIdsInLocal(slot0._activityId))
	slot0._unlockSupportHeroIndex = 0

	for slot5, slot6 in ipairs(slot0._badgeCos) do
		if slot6.unlockSupport and slot7 ~= 0 then
			slot0:refreshSingleHeroItem(slot6, slot7)
		end
	end
end

function slot0._getOrCreateHeroItem(slot0, slot1)
	if not slot0._heroItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goheroitem, "heroitem_" .. slot1)
		slot2.golock = gohelper.findChild(slot2.viewGO, "go_lock")
		slot2.txtcost = gohelper.findChildText(slot2.viewGO, "go_lock/txt_cost")
		slot2.goPos = gohelper.findChild(slot2.viewGO, "go_pos")
		slot2.icon = IconMgr.instance:getCommonHeroItem(slot2.goPos)
		slot2.animator = gohelper.onceAddComponent(slot2.golock, gohelper.Type_Animator)
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._onClickHeroItem, slot0, slot1)

		slot2.heroMo = HeroMo.New()
		slot0._heroItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onClickHeroItem(slot0, slot1)
	if not slot0._heroItemTab[slot1] then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot0._heroItemTab) do
		table.insert(slot3, slot8.heroMo)
	end

	CharacterController.instance:openCharacterView(slot2.heroMo, slot3)
end

function slot0.refreshSingleHeroItem(slot0, slot1, slot2)
	if lua_hero_trial.configDict[slot2][0] then
		slot0._unlockSupportHeroIndex = slot0._unlockSupportHeroIndex + 1
		slot4 = slot0:_getOrCreateHeroItem(slot0._unlockSupportHeroIndex)

		slot4.heroMo:initFromTrial(slot2)
		slot4.icon:onUpdateMO(slot4.heroMo)

		slot4.txtcost.text = slot1.num

		gohelper.setActive(slot4.viewGO, true)

		slot5 = slot0._curBadgeNum < slot1.num

		gohelper.setActive(slot4.golock, slot5 or not slot5 and slot0._hasReadUnlockHeroIdMap[slot2] == nil)

		if slot5 or slot6 then
			slot0._needPlayAnimHeroItems[slot4] = slot6 and "unlock" or "open"
		end
	else
		logError(string.format("缺少支援角色配置 : badgeNum = %s, supportHeroId = %s", slot1.num, slot1.unlockSupport))
	end
end

function slot0.playHeroItemAnim(slot0)
	if slot0._needPlayAnimHeroItems then
		for slot4, slot5 in pairs(slot0._needPlayAnimHeroItems) do
			slot4.animator:Play(slot5, 0, 0)
		end
	end
end

function slot0.releaseAllHeroItems(slot0)
	if slot0._heroItemTab then
		for slot4, slot5 in pairs(slot0._heroItemTab) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.saveHasReadUnlockSupportHeroIds(slot0)
	Act183Helper.saveHasReadUnlockSupportHeroIdsInLocal(slot0._activityId, slot0._actInfo:getUnlockSupportHeroIds())
	Act183Controller.instance:dispatchEvent(Act183Event.RefreshMedalReddot)
end

function slot0.onClose(slot0)
	slot0:releaseAllHeroItems()
end

function slot0.onDestroyView(slot0)
end

return slot0
