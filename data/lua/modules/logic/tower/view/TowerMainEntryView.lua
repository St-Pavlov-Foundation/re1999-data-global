module("modules.logic.tower.view.TowerMainEntryView", package.seeall)

slot0 = class("TowerMainEntryView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Title")
	slot0._gotimeLimitEpisode = gohelper.findChild(slot0.viewGO, "limitTimeEpisode")
	slot0._gotimeLimitTaskInfo = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo")
	slot0._txttimeLimitNum = gohelper.findChildText(slot0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo/#txt_timeLimitNum")
	slot0._golimitTimeTips = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeTips")
	slot0._golimitTimeHasNew = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeHasNew")
	slot0._golimitTimeUpdateTime = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeUpdateTime")
	slot0._txtlimitTimeUpdateTime = gohelper.findChildText(slot0.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeUpdateTime/#txt_limitTimeUpdateTime")
	slot0._btnlimitTime = gohelper.findChildButtonWithAudio(slot0.viewGO, "limitTimeEpisode/#btn_limitTime")
	slot0._gobossEpisode = gohelper.findChild(slot0.viewGO, "bossEpisode")
	slot0._gobossTaskInfo = gohelper.findChild(slot0.viewGO, "bossEpisode/layout/#go_bossTaskInfo")
	slot0._txtbossNum = gohelper.findChildText(slot0.viewGO, "bossEpisode/layout/#go_bossTaskInfo/#txt_bossNum")
	slot0._gobossTips = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossTips")
	slot0._gobossHasNew = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossTips/#go_bossHasNew")
	slot0._gobossUpdateTime = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossTips/#go_bossUpdateTime")
	slot0._txtbossUpdateTime = gohelper.findChildText(slot0.viewGO, "bossEpisode/#go_bossTips/#go_bossUpdateTime/#txt_bossUpdateTime")
	slot0._gobossContent = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossContent")
	slot0._gobossItem = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossContent/#go_bossItem")
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossContent/#go_bossItem/#go_Selected")
	slot0._btnboss = gohelper.findChildButtonWithAudio(slot0.viewGO, "bossEpisode/#btn_boss")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Reward/scroll_reward/Viewport/#go_rewards")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Start")
	slot0._btnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Lock")
	slot0._txtlockTip = gohelper.findChildText(slot0.viewGO, "#btn_Lock/#txt_lockTip")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_Start/#go_reddot")
	slot0._goupdateReddot = gohelper.findChild(slot0.viewGO, "black/#go_updateReddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlimitTime:AddClickListener(slot0._btnlimitTimeOnClick, slot0)
	slot0._btnboss:AddClickListener(slot0._btnbossOnClick, slot0)
	slot0._btnStart:AddClickListener(slot0._btnStartOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshTaskInfo, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRequestData, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlimitTime:RemoveClickListener()
	slot0._btnboss:RemoveClickListener()
	slot0._btnStart:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshTaskInfo, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRequestData, slot0)
	TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
end

function slot0._btnlimitTimeOnClick(slot0)
	if not TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		return
	end

	TowerController.instance:openTowerTimeLimitLevelView()
end

function slot0._btnbossOnClick(slot0)
	if not TowerController.instance:isBossTowerOpen() then
		GameFacade.showToast(ToastEnum.TowerBossLockTips, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen))

		return
	end

	if not TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSelectView)
end

function slot0._btnStartOnClick(slot0)
	TowerController.instance:openMainView()
end

function slot0.onLocalKeyChange(slot0)
	slot0:refreshBossNewTag()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == "TowerMainView" then
		slot0:refreshTowerState()
	end
end

function slot0.dailyRequestData(slot0)
	TowerRpc.instance:sendGetTowerInfoRequest(slot0.towerTaskDataRequest, slot0)
end

function slot0.towerTaskDataRequest(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, slot0.dailyRefresh, slot0)
end

function slot0.dailyRefresh(slot0)
	slot0:refreshUI()
	TowerController.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function slot0._editableInitView(slot0)
	slot0.rewardItemTab = slot0:getUserDataTb_()
	slot0.bossItemTab = slot0:getUserDataTb_()
	slot0._animView = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	TowerTaskModel.instance:setTaskInfoList(TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._animView:Play(UIAnimationName.Open, 0, 0)

	slot0.actId = ActivityEnum.Activity.Tower
	slot0.actConfig = ActivityConfig.instance:getActivityCo(slot0.actId)

	slot0:refreshUI()
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.TowerMainEntry)
	RedDotController.instance:addRedDot(slot0._goupdateReddot, RedDotEnum.DotNode.TowerNewUpdate)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function slot0.refreshUI(slot0)
	slot0:refreshReward()

	slot0.isTowerOpen = TowerController.instance:isOpen()

	gohelper.setActive(slot0._btnStart.gameObject, slot0.isTowerOpen)
	gohelper.setActive(slot0._btnLock.gameObject, not slot0.isTowerOpen)

	if slot0.isTowerOpen then
		slot0:refreshEntranceUI()
		slot0:refreshBossInfo()
		slot0:refreshBossNewTag()
		slot0:refreshTowerState()
		slot0:refreshTaskInfo()
		TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
		TaskDispatcher.runRepeat(slot0.refreshTowerState, slot0, 1)
	else
		gohelper.setActive(slot0._gobossEpisode, false)
		gohelper.setActive(slot0._gotimeLimitEpisode, false)

		slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

		if slot1 ~= ActivityEnum.ActivityStatus.Normal then
			slot0._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(ToastConfig.instance:getToastCO(slot2).tips, slot3)
		end
	end
end

function slot0.refreshEntranceUI(slot0)
	gohelper.setActive(slot0._gobossEpisode, TowerController.instance:isBossTowerOpen())
	gohelper.setActive(slot0._gotimeLimitEpisode, TowerController.instance:isTimeLimitTowerOpen())
end

function slot0.refreshTaskInfo(slot0)
	slot0._gotimeLimitTaskInfo = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo")
	slot0._txttimeLimitNum = gohelper.findChildText(slot0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo/#txt_timeLimitNum")

	if not TowerTaskModel.instance:getCurTaskList(TowerEnum.TowerType.Limited) or #slot1 == 0 then
		gohelper.setActive(slot0._gotimeLimitTaskInfo, false)
	else
		gohelper.setActive(slot0._gotimeLimitTaskInfo, true)

		slot0._txttimeLimitNum.text = string.format("%s/%s", TowerTaskModel.instance:getTaskItemRewardCount(slot1), #slot1)
	end

	if not TowerTaskModel.instance:getCurTaskList(TowerEnum.TowerType.Boss) or #slot2 == 0 then
		gohelper.setActive(slot0._gobossTaskInfo, false)
	else
		gohelper.setActive(slot0._gobossTaskInfo, true)

		slot0._txtbossNum.text = string.format("%s/%s", TowerTaskModel.instance:getTaskItemRewardCount(slot2), #slot2)
	end
end

function slot0.refreshBossInfo(slot0)
	slot0.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(slot0, slot0.bossItemShow, TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open), slot0._gobossContent, slot0._gobossItem)
end

function slot0.refreshBossNewTag(slot0)
	gohelper.setActive(slot0._gobossHasNew, TowerModel.instance:hasNewBossOpen())
end

function slot0.bossItemShow(slot0, slot1, slot2, slot3)
	if not slot0.bossItemTab[slot3] then
		slot0.bossItemTab[slot3] = {}
	end

	slot4.go = slot1
	slot4.simageEnemy = gohelper.findChildSingleImage(slot4.go, "Mask/image_bossIcon")
	slot4.goSelected = gohelper.findChild(slot4.go, "#go_Selected")

	slot4.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(TowerConfig.instance:getAssistBossConfig(TowerConfig.instance:getBossTowerConfig(slot2.id).bossId).skinId).headIcon))
	gohelper.setActive(slot4.goSelected, not slot0.bossEpisodeMo:isPassAllUnlockLayers(slot2.id))
end

function slot0.refreshReward(slot0)
	for slot6, slot7 in ipairs(GameUtil.splitString2(slot0.actConfig.activityBonus, true)) do
		if not slot0.rewardItemTab[slot6] then
			slot0.rewardItemTab[slot6] = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0._gorewards)
			}
		end

		slot8.itemIcon:setMOValue(slot7[1], slot7[2], slot7[3] or 0)
		slot8.itemIcon:isShowCount(false)
		slot8.itemIcon:setHideLvAndBreakFlag(true)
		slot8.itemIcon:hideEquipLvAndBreak(true)
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemTab do
		if slot0.rewardItemTab[slot6] then
			gohelper.setActive(slot7.itemIcon.gameObject, false)
		end
	end
end

function slot0.refreshTowerState(slot0)
	if TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		slot2 = slot1.nextTime / 1000 - ServerTime.now()
		slot3, slot4 = TimeUtil.secondToRoughTime2(slot2)
		slot0._txtlimitTimeUpdateTime.text = slot2 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			slot3,
			slot4
		}) or ""
		slot6 = not TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, slot1.id, slot1, TowerEnum.LockKey) or slot5 == TowerEnum.LockKey

		gohelper.setActive(slot0._golimitTimeHasNew, slot6)
		gohelper.setActive(slot0._golimitTimeUpdateTime, not slot6 and slot2 > 0)
	else
		if TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited) then
			slot4, slot5 = TimeUtil.secondToRoughTime2(slot2.nextTime / 1000 - ServerTime.now())
			slot0._txtlimitTimeUpdateTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				slot4,
				slot5
			})
		else
			slot0._txtlimitTimeUpdateTime.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(slot0._golimitTimeHasNew, false)
		gohelper.setActive(slot0._golimitTimeUpdateTime, true)
	end

	slot2 = TowerModel.instance:hasNewBossOpen()

	if TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		slot5 = -1

		for slot9, slot10 in ipairs(TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)) do
			if slot5 > slot10.nextTime / 1000 - ServerTime.now() or slot5 <= 0 then
				slot5 = slot11
			end
		end

		slot6, slot7 = TimeUtil.secondToRoughTime2(slot5)
		slot0._txtbossUpdateTime.text = slot5 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			slot6,
			slot7
		}) or luaLang("towermain_entrancelock")

		gohelper.setActive(slot0._gobossHasNew, slot2)
		gohelper.setActive(slot0._gobossUpdateTime, not slot2 and slot5 > 0)
	else
		if TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss) then
			slot6, slot7 = TimeUtil.secondToRoughTime2(slot4.nextTime / 1000 - ServerTime.now())
			slot0._txtbossUpdateTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				slot6,
				slot7
			})
		else
			slot0._txtbossUpdateTime.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(slot0._gobossHasNew, false)
		gohelper.setActive(slot0._gobossUpdateTime, true)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
