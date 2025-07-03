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
	arg_1_0._gostore = gohelper.findChild(arg_1_0.viewGO, "store")
	arg_1_0._gostoreTime = gohelper.findChild(arg_1_0.viewGO, "store/time")
	arg_1_0._txtstoreTime = gohelper.findChildText(arg_1_0.viewGO, "store/time/#txt_storeTime")
	arg_1_0._txtstoreName = gohelper.findChildText(arg_1_0.viewGO, "store/#txt_storeName")
	arg_1_0._txtcoinNum = gohelper.findChildText(arg_1_0.viewGO, "store/#txt_coinNum")
	arg_1_0._imagecoin = gohelper.findChildImage(arg_1_0.viewGO, "store/#txt_coinNum/#image_coin")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "store/#btn_store")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlimitTime:AddClickListener(arg_2_0._btnlimitTimeOnClick, arg_2_0)
	arg_2_0._btnboss:AddClickListener(arg_2_0._btnbossOnClick, arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_2_0.onLocalKeyChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.refreshTaskInfo, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshStore, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_2_0.refreshStore, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.dailyRequestData, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlimitTime:RemoveClickListener()
	arg_3_0._btnboss:RemoveClickListener()
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_3_0.onLocalKeyChange, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0, LuaEventSystem.Low)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshTaskInfo, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStore, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_3_0.refreshStore, arg_3_0)
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

function var_0_0._btnstoreOnClick(arg_7_0)
	TowerController.instance:openTowerStoreView()
end

function var_0_0.onLocalKeyChange(arg_8_0)
	arg_8_0:refreshBossNewTag()
end

function var_0_0._onCloseView(arg_9_0, arg_9_1)
	if arg_9_1 == "TowerMainView" then
		arg_9_0:refreshTowerState()
	end
end

function var_0_0.dailyRequestData(arg_10_0)
	TowerRpc.instance:sendGetTowerInfoRequest(arg_10_0.towerTaskDataRequest, arg_10_0)
end

function var_0_0.towerTaskDataRequest(arg_11_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, arg_11_0.dailyRefresh, arg_11_0)
end

function var_0_0.dailyRefresh(arg_12_0)
	arg_12_0:refreshUI()
	TowerController.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0.rewardItemTab = arg_13_0:getUserDataTb_()
	arg_13_0.bossItemTab = arg_13_0:getUserDataTb_()
	arg_13_0._animView = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_13_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(var_13_0)
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._animView:Play(UIAnimationName.Open, 0, 0)

	arg_15_0.actId = ActivityEnum.Activity.Tower
	arg_15_0.actConfig = ActivityConfig.instance:getActivityCo(arg_15_0.actId)

	arg_15_0:refreshUI()
	RedDotController.instance:addRedDot(arg_15_0._goreddot, RedDotEnum.DotNode.TowerMainEntry)
	RedDotController.instance:addRedDot(arg_15_0._goupdateReddot, RedDotEnum.DotNode.TowerNewUpdate)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function var_0_0.refreshUI(arg_16_0)
	arg_16_0:refreshReward()

	arg_16_0.isTowerOpen = TowerController.instance:isOpen()

	gohelper.setActive(arg_16_0._btnStart.gameObject, arg_16_0.isTowerOpen)
	gohelper.setActive(arg_16_0._btnLock.gameObject, not arg_16_0.isTowerOpen)

	if arg_16_0.isTowerOpen then
		arg_16_0:refreshEntranceUI()
		arg_16_0:refreshBossInfo()
		arg_16_0:refreshBossNewTag()
		arg_16_0:refreshTowerState()
		arg_16_0:refreshTaskInfo()
		arg_16_0:refreshStore()
		TaskDispatcher.cancelTask(arg_16_0.refreshTowerState, arg_16_0)
		TaskDispatcher.runRepeat(arg_16_0.refreshTowerState, arg_16_0, 1)
	else
		gohelper.setActive(arg_16_0._gobossEpisode, false)
		gohelper.setActive(arg_16_0._gotimeLimitEpisode, false)

		local var_16_0, var_16_1, var_16_2 = ActivityHelper.getActivityStatusAndToast(arg_16_0.actId)

		if var_16_0 ~= ActivityEnum.ActivityStatus.Normal then
			local var_16_3 = ToastConfig.instance:getToastCO(var_16_1).tips
			local var_16_4 = GameUtil.getSubPlaceholderLuaLang(var_16_3, var_16_2)

			arg_16_0._txtlockTip.text = var_16_4
		end
	end
end

function var_0_0.refreshEntranceUI(arg_17_0)
	local var_17_0 = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(arg_17_0._gobossEpisode, var_17_0)

	local var_17_1 = TowerController.instance:isTimeLimitTowerOpen()

	gohelper.setActive(arg_17_0._gotimeLimitEpisode, var_17_1)
end

function var_0_0.refreshTaskInfo(arg_18_0)
	local var_18_0 = TowerTaskModel.instance:getCurTaskList(TowerEnum.TowerType.Limited)

	arg_18_0._gotimeLimitTaskInfo = gohelper.findChild(arg_18_0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo")
	arg_18_0._txttimeLimitNum = gohelper.findChildText(arg_18_0.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo/#txt_timeLimitNum")

	if not var_18_0 or #var_18_0 == 0 then
		gohelper.setActive(arg_18_0._gotimeLimitTaskInfo, false)
	else
		gohelper.setActive(arg_18_0._gotimeLimitTaskInfo, true)

		local var_18_1 = TowerTaskModel.instance:getTaskItemRewardCount(var_18_0)

		arg_18_0._txttimeLimitNum.text = string.format("%s/%s", var_18_1, #var_18_0)
	end

	local var_18_2 = TowerTaskModel.instance.bossTaskList

	if not var_18_2 or #var_18_2 == 0 then
		gohelper.setActive(arg_18_0._gobossTaskInfo, false)
	else
		gohelper.setActive(arg_18_0._gobossTaskInfo, true)

		local var_18_3 = {}

		for iter_18_0, iter_18_1 in pairs(var_18_2) do
			for iter_18_2 = 1, #iter_18_1 do
				table.insert(var_18_3, iter_18_1[iter_18_2])
			end
		end

		local var_18_4 = TowerTaskModel.instance:getTaskItemRewardCount(var_18_3)

		arg_18_0._txtbossNum.text = string.format("%s/%s", var_18_4, #var_18_3)
	end
end

function var_0_0.refreshBossInfo(arg_19_0)
	local var_19_0 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)
	local var_19_1 = {}

	if #var_19_0 > 0 then
		table.sort(var_19_0, TowerAssistBossModel.sortBossList)

		for iter_19_0 = 1, 3 do
			if var_19_0[iter_19_0] then
				table.insert(var_19_1, var_19_0[iter_19_0])
			end
		end
	end

	arg_19_0.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(arg_19_0, arg_19_0.bossItemShow, var_19_1, arg_19_0._gobossContent, arg_19_0._gobossItem)
end

function var_0_0.refreshBossNewTag(arg_20_0)
	local var_20_0 = TowerModel.instance:hasNewBossOpen()

	gohelper.setActive(arg_20_0._gobossHasNew, var_20_0)
end

function var_0_0.bossItemShow(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0.bossItemTab[arg_21_3]

	if not var_21_0 then
		var_21_0 = {}
		arg_21_0.bossItemTab[arg_21_3] = var_21_0
	end

	var_21_0.go = arg_21_1
	var_21_0.simageEnemy = gohelper.findChildSingleImage(var_21_0.go, "Mask/image_bossIcon")
	var_21_0.goSelected = gohelper.findChild(var_21_0.go, "#go_Selected")

	local var_21_1 = TowerConfig.instance:getBossTowerConfig(arg_21_2.id).bossId
	local var_21_2 = TowerConfig.instance:getAssistBossConfig(var_21_1)
	local var_21_3 = FightConfig.instance:getSkinCO(var_21_2.skinId)

	var_21_0.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(var_21_3.headIcon))

	local var_21_4 = arg_21_0.bossEpisodeMo:isPassAllUnlockLayers(arg_21_2.id)

	gohelper.setActive(var_21_0.goSelected, not var_21_4)
end

function var_0_0.refreshReward(arg_22_0)
	local var_22_0 = arg_22_0.actConfig.activityBonus
	local var_22_1 = GameUtil.splitString2(var_22_0, true)

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		local var_22_2 = arg_22_0.rewardItemTab[iter_22_0]

		if not var_22_2 then
			var_22_2 = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_22_0._gorewards)
			}
			arg_22_0.rewardItemTab[iter_22_0] = var_22_2
		end

		var_22_2.itemIcon:setMOValue(iter_22_1[1], iter_22_1[2], iter_22_1[3] or 0)
		var_22_2.itemIcon:isShowCount(false)
		var_22_2.itemIcon:setHideLvAndBreakFlag(true)
		var_22_2.itemIcon:hideEquipLvAndBreak(true)
	end

	for iter_22_2 = #var_22_1 + 1, #arg_22_0.rewardItemTab do
		local var_22_3 = arg_22_0.rewardItemTab[iter_22_2]

		if var_22_3 then
			gohelper.setActive(var_22_3.itemIcon.gameObject, false)
		end
	end
end

function var_0_0.refreshTowerState(arg_23_0)
	local var_23_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if var_23_0 then
		local var_23_1 = var_23_0.nextTime / 1000 - ServerTime.now()
		local var_23_2, var_23_3 = TimeUtil.secondToRoughTime2(var_23_1)

		arg_23_0._txtlimitTimeUpdateTime.text = var_23_1 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			var_23_2,
			var_23_3
		}) or ""

		local var_23_4 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, var_23_0.id, var_23_0, TowerEnum.LockKey)
		local var_23_5 = not var_23_4 or var_23_4 == TowerEnum.LockKey

		gohelper.setActive(arg_23_0._golimitTimeHasNew, var_23_5)
		gohelper.setActive(arg_23_0._golimitTimeUpdateTime, not var_23_5 and var_23_1 > 0)
	else
		local var_23_6 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited)

		if var_23_6 then
			local var_23_7 = var_23_6.nextTime / 1000 - ServerTime.now()
			local var_23_8, var_23_9 = TimeUtil.secondToRoughTime2(var_23_7)

			arg_23_0._txtlimitTimeUpdateTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_23_8,
				var_23_9
			})
		else
			arg_23_0._txtlimitTimeUpdateTime.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(arg_23_0._golimitTimeHasNew, false)
		gohelper.setActive(arg_23_0._golimitTimeUpdateTime, true)
	end

	local var_23_10 = TowerModel.instance:hasNewBossOpen()

	if TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		local var_23_11 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
		local var_23_12 = -1

		for iter_23_0, iter_23_1 in ipairs(var_23_11) do
			local var_23_13 = iter_23_1.nextTime / 1000 - ServerTime.now()

			if var_23_13 < var_23_12 or var_23_12 <= 0 then
				var_23_12 = var_23_13
			end
		end

		local var_23_14, var_23_15 = TimeUtil.secondToRoughTime2(var_23_12)

		arg_23_0._txtbossUpdateTime.text = var_23_12 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			var_23_14,
			var_23_15
		}) or luaLang("towermain_entrancelock")

		gohelper.setActive(arg_23_0._gobossHasNew, var_23_10)
		gohelper.setActive(arg_23_0._gobossUpdateTime, not var_23_10 and var_23_12 > 0)
	else
		local var_23_16 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss)

		if var_23_16 then
			local var_23_17 = var_23_16.nextTime / 1000 - ServerTime.now()
			local var_23_18, var_23_19 = TimeUtil.secondToRoughTime2(var_23_17)

			arg_23_0._txtbossUpdateTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_23_18,
				var_23_19
			})
		else
			arg_23_0._txtbossUpdateTime.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(arg_23_0._gobossHasNew, false)
		gohelper.setActive(arg_23_0._gobossUpdateTime, true)
	end

	arg_23_0:refreshStoreTime()
end

function var_0_0.refreshStore(arg_24_0)
	local var_24_0 = TowerController.instance:isTowerStoreOpen()

	gohelper.setActive(arg_24_0._gostore, var_24_0)

	local var_24_1 = TowerStoreModel.instance:getCurrencyIcon()

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_24_0._imagecoin, var_24_1)

	local var_24_2 = TowerStoreModel.instance:getCurrencyCount()

	arg_24_0._txtcoinNum.text = var_24_2

	arg_24_0:refreshStoreTime()
end

function var_0_0.refreshStoreTime(arg_25_0)
	local var_25_0 = TowerStoreModel.instance:isUpdateStoreEmpty()

	gohelper.setActive(arg_25_0._gostoreTime, not var_25_0)

	if var_25_0 then
		return
	end

	local var_25_1 = TowerStoreModel.instance:getUpdateStoreRemainTime()

	arg_25_0._txtstoreTime.text = var_25_1
end

function var_0_0.onClose(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.refreshTowerState, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

return var_0_0
