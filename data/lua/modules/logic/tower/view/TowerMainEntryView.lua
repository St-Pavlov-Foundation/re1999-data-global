module("modules.logic.tower.view.TowerMainEntryView", package.seeall)

local var_0_0 = class("TowerMainEntryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Title")
	arg_1_0._gotimeLimitEpisode = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode")
	arg_1_0._gotimeLimitTaskInfo = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo")
	arg_1_0._txttimeLimitNum = gohelper.findChildText(arg_1_0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo/#txt_timeLimitNum")
	arg_1_0._golimitTimeTips = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeTips")
	arg_1_0._golimitTimeHasNew = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeHasNew")
	arg_1_0._golimitTimeUpdateTime = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeUpdateTime")
	arg_1_0._txtlimitTimeUpdateTime = gohelper.findChildText(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeUpdateTime/#txt_limitTimeUpdateTime")
	arg_1_0._btnlimitTime = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "limitTimeEpisode/#btn_limitTime")
	arg_1_0._gobossEpisode = gohelper.findChild(arg_1_0.viewGO, "bossEpisode")
	arg_1_0._gobossTaskInfo = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/layout/#go_bossTaskInfo")
	arg_1_0._txtbossNum = gohelper.findChildText(arg_1_0.viewGO, "bossEpisode/layout/#go_bossTaskInfo/#txt_bossNum")
	arg_1_0._gobossTips = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossTips")
	arg_1_0._gobossHasNew = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossTips/#go_bossHasNew")
	arg_1_0._gobossUpdateTime = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossTips/#go_bossUpdateTime")
	arg_1_0._txtbossUpdateTime = gohelper.findChildText(arg_1_0.viewGO, "bossEpisode/#go_bossTips/#go_bossUpdateTime/#txt_bossUpdateTime")
	arg_1_0._gobossContent = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossContent")
	arg_1_0._gobossItem = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossContent/#go_bossItem")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossContent/#go_bossItem/#go_Selected")
	arg_1_0._btnboss = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bossEpisode/#btn_boss")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Reward/scroll_reward/Viewport/#go_rewards")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Start")
	arg_1_0._btnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Lock")
	arg_1_0._txtlockTip = gohelper.findChildText(arg_1_0.viewGO, "#btn_Lock/#txt_lockTip")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Start/#go_reddot")
	arg_1_0._goupdateReddot = gohelper.findChild(arg_1_0.viewGO, "black/#go_updateReddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlimitTime:AddClickListener(arg_2_0._btnlimitTimeOnClick, arg_2_0)
	arg_2_0._btnboss:AddClickListener(arg_2_0._btnbossOnClick, arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_2_0.onLocalKeyChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.refreshTaskInfo, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.dailyRequestData, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlimitTime:RemoveClickListener()
	arg_3_0._btnboss:RemoveClickListener()
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_3_0.onLocalKeyChange, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0, LuaEventSystem.Low)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshTaskInfo, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.dailyRequestData, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshTowerState, arg_3_0)
end

function var_0_0._btnlimitTimeOnClick(arg_4_0)
	if not TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		return
	end

	TowerController.instance:openTowerTimeLimitLevelView()
end

function var_0_0._btnbossOnClick(arg_5_0)
	if not TowerController.instance:isBossTowerOpen() then
		local var_5_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, var_5_0)

		return
	end

	if not TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSelectView)
end

function var_0_0._btnStartOnClick(arg_6_0)
	TowerController.instance:openMainView()
end

function var_0_0.onLocalKeyChange(arg_7_0)
	arg_7_0:refreshBossNewTag()
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == "TowerMainView" then
		arg_8_0:refreshTowerState()
	end
end

function var_0_0.dailyRequestData(arg_9_0)
	TowerRpc.instance:sendGetTowerInfoRequest(arg_9_0.towerTaskDataRequest, arg_9_0)
end

function var_0_0.towerTaskDataRequest(arg_10_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, arg_10_0.dailyRefresh, arg_10_0)
end

function var_0_0.dailyRefresh(arg_11_0)
	arg_11_0:refreshUI()
	TowerController.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.rewardItemTab = arg_12_0:getUserDataTb_()
	arg_12_0.bossItemTab = arg_12_0:getUserDataTb_()
	arg_12_0._animView = arg_12_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_12_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(var_12_0)
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0._animView:Play(UIAnimationName.Open, 0, 0)

	arg_14_0.actId = ActivityEnum.Activity.Tower
	arg_14_0.actConfig = ActivityConfig.instance:getActivityCo(arg_14_0.actId)

	arg_14_0:refreshUI()
	RedDotController.instance:addRedDot(arg_14_0._goreddot, RedDotEnum.DotNode.TowerMainEntry)
	RedDotController.instance:addRedDot(arg_14_0._goupdateReddot, RedDotEnum.DotNode.TowerNewUpdate)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:refreshReward()

	arg_15_0.isTowerOpen = TowerController.instance:isOpen()

	gohelper.setActive(arg_15_0._btnStart.gameObject, arg_15_0.isTowerOpen)
	gohelper.setActive(arg_15_0._btnLock.gameObject, not arg_15_0.isTowerOpen)

	if arg_15_0.isTowerOpen then
		arg_15_0:refreshEntranceUI()
		arg_15_0:refreshBossInfo()
		arg_15_0:refreshBossNewTag()
		arg_15_0:refreshTowerState()
		arg_15_0:refreshTaskInfo()
		TaskDispatcher.cancelTask(arg_15_0.refreshTowerState, arg_15_0)
		TaskDispatcher.runRepeat(arg_15_0.refreshTowerState, arg_15_0, 1)
	else
		gohelper.setActive(arg_15_0._gobossEpisode, false)
		gohelper.setActive(arg_15_0._gotimeLimitEpisode, false)

		local var_15_0, var_15_1, var_15_2 = ActivityHelper.getActivityStatusAndToast(arg_15_0.actId)

		if var_15_0 ~= ActivityEnum.ActivityStatus.Normal then
			local var_15_3 = ToastConfig.instance:getToastCO(var_15_1).tips
			local var_15_4 = GameUtil.getSubPlaceholderLuaLang(var_15_3, var_15_2)

			arg_15_0._txtlockTip.text = var_15_4
		end
	end
end

function var_0_0.refreshEntranceUI(arg_16_0)
	local var_16_0 = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(arg_16_0._gobossEpisode, var_16_0)

	local var_16_1 = TowerController.instance:isTimeLimitTowerOpen()

	gohelper.setActive(arg_16_0._gotimeLimitEpisode, var_16_1)
end

function var_0_0.refreshTaskInfo(arg_17_0)
	local var_17_0 = TowerTaskModel.instance:getCurTaskList(TowerEnum.TowerType.Limited)

	arg_17_0._gotimeLimitTaskInfo = gohelper.findChild(arg_17_0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo")
	arg_17_0._txttimeLimitNum = gohelper.findChildText(arg_17_0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo/#txt_timeLimitNum")

	if not var_17_0 or #var_17_0 == 0 then
		gohelper.setActive(arg_17_0._gotimeLimitTaskInfo, false)
	else
		gohelper.setActive(arg_17_0._gotimeLimitTaskInfo, true)

		local var_17_1 = TowerTaskModel.instance:getTaskItemRewardCount(var_17_0)

		arg_17_0._txttimeLimitNum.text = string.format("%s/%s", var_17_1, #var_17_0)
	end

	local var_17_2 = TowerTaskModel.instance:getCurTaskList(TowerEnum.TowerType.Boss)

	if not var_17_2 or #var_17_2 == 0 then
		gohelper.setActive(arg_17_0._gobossTaskInfo, false)
	else
		gohelper.setActive(arg_17_0._gobossTaskInfo, true)

		local var_17_3 = TowerTaskModel.instance:getTaskItemRewardCount(var_17_2)

		arg_17_0._txtbossNum.text = string.format("%s/%s", var_17_3, #var_17_2)
	end
end

function var_0_0.refreshBossInfo(arg_18_0)
	local var_18_0 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	arg_18_0.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(arg_18_0, arg_18_0.bossItemShow, var_18_0, arg_18_0._gobossContent, arg_18_0._gobossItem)
end

function var_0_0.refreshBossNewTag(arg_19_0)
	local var_19_0 = TowerModel.instance:hasNewBossOpen()

	gohelper.setActive(arg_19_0._gobossHasNew, var_19_0)
end

function var_0_0.bossItemShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0.bossItemTab[arg_20_3]

	if not var_20_0 then
		var_20_0 = {}
		arg_20_0.bossItemTab[arg_20_3] = var_20_0
	end

	var_20_0.go = arg_20_1
	var_20_0.simageEnemy = gohelper.findChildSingleImage(var_20_0.go, "Mask/image_bossIcon")
	var_20_0.goSelected = gohelper.findChild(var_20_0.go, "#go_Selected")

	local var_20_1 = TowerConfig.instance:getBossTowerConfig(arg_20_2.id).bossId
	local var_20_2 = TowerConfig.instance:getAssistBossConfig(var_20_1)
	local var_20_3 = FightConfig.instance:getSkinCO(var_20_2.skinId)

	var_20_0.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(var_20_3.headIcon))

	local var_20_4 = arg_20_0.bossEpisodeMo:isPassAllUnlockLayers(arg_20_2.id)

	gohelper.setActive(var_20_0.goSelected, not var_20_4)
end

function var_0_0.refreshReward(arg_21_0)
	local var_21_0 = arg_21_0.actConfig.activityBonus
	local var_21_1 = GameUtil.splitString2(var_21_0, true)

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		local var_21_2 = arg_21_0.rewardItemTab[iter_21_0]

		if not var_21_2 then
			var_21_2 = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_21_0._gorewards)
			}
			arg_21_0.rewardItemTab[iter_21_0] = var_21_2
		end

		var_21_2.itemIcon:setMOValue(iter_21_1[1], iter_21_1[2], iter_21_1[3] or 0)
		var_21_2.itemIcon:isShowCount(false)
		var_21_2.itemIcon:setHideLvAndBreakFlag(true)
		var_21_2.itemIcon:hideEquipLvAndBreak(true)
	end

	for iter_21_2 = #var_21_1 + 1, #arg_21_0.rewardItemTab do
		local var_21_3 = arg_21_0.rewardItemTab[iter_21_2]

		if var_21_3 then
			gohelper.setActive(var_21_3.itemIcon.gameObject, false)
		end
	end
end

function var_0_0.refreshTowerState(arg_22_0)
	local var_22_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if var_22_0 then
		local var_22_1 = var_22_0.nextTime / 1000 - ServerTime.now()
		local var_22_2, var_22_3 = TimeUtil.secondToRoughTime2(var_22_1)

		arg_22_0._txtlimitTimeUpdateTime.text = var_22_1 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			var_22_2,
			var_22_3
		}) or ""

		local var_22_4 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, var_22_0.id, var_22_0, TowerEnum.LockKey)
		local var_22_5 = not var_22_4 or var_22_4 == TowerEnum.LockKey

		gohelper.setActive(arg_22_0._golimitTimeHasNew, var_22_5)
		gohelper.setActive(arg_22_0._golimitTimeUpdateTime, not var_22_5 and var_22_1 > 0)
	else
		local var_22_6 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited)

		if var_22_6 then
			local var_22_7 = var_22_6.nextTime / 1000 - ServerTime.now()
			local var_22_8, var_22_9 = TimeUtil.secondToRoughTime2(var_22_7)

			arg_22_0._txtlimitTimeUpdateTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_22_8,
				var_22_9
			})
		else
			arg_22_0._txtlimitTimeUpdateTime.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(arg_22_0._golimitTimeHasNew, false)
		gohelper.setActive(arg_22_0._golimitTimeUpdateTime, true)
	end

	local var_22_10 = TowerModel.instance:hasNewBossOpen()

	if TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		local var_22_11 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
		local var_22_12 = -1

		for iter_22_0, iter_22_1 in ipairs(var_22_11) do
			local var_22_13 = iter_22_1.nextTime / 1000 - ServerTime.now()

			if var_22_13 < var_22_12 or var_22_12 <= 0 then
				var_22_12 = var_22_13
			end
		end

		local var_22_14, var_22_15 = TimeUtil.secondToRoughTime2(var_22_12)

		arg_22_0._txtbossUpdateTime.text = var_22_12 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			var_22_14,
			var_22_15
		}) or luaLang("towermain_entrancelock")

		gohelper.setActive(arg_22_0._gobossHasNew, var_22_10)
		gohelper.setActive(arg_22_0._gobossUpdateTime, not var_22_10 and var_22_12 > 0)
	else
		local var_22_16 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss)

		if var_22_16 then
			local var_22_17 = var_22_16.nextTime / 1000 - ServerTime.now()
			local var_22_18, var_22_19 = TimeUtil.secondToRoughTime2(var_22_17)

			arg_22_0._txtbossUpdateTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_22_18,
				var_22_19
			})
		else
			arg_22_0._txtbossUpdateTime.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(arg_22_0._gobossHasNew, false)
		gohelper.setActive(arg_22_0._gobossUpdateTime, true)
	end
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.refreshTowerState, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
