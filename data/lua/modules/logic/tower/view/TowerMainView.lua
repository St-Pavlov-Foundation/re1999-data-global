module("modules.logic.tower.view.TowerMainView", package.seeall)

local var_0_0 = class("TowerMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "centerTitle/#txt_title")
	arg_1_0._txttitleEn = gohelper.findChildText(arg_1_0.viewGO, "centerTitle/#txt_titleEn")
	arg_1_0._goupdateTime = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode/#go_updateTime")
	arg_1_0._golimitTimeUpdateTime = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeUpdateTime")
	arg_1_0._txtlimitTimeUpdateTime = gohelper.findChildText(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeUpdateTime/#txt_limitTimeUpdateTime")
	arg_1_0._golimitTimeHasNew = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeHasNew")
	arg_1_0._btnlimitTime = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "limitTimeEpisode/#btn_limitTime")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "task/#btn_task")
	arg_1_0._gotaskReddot = gohelper.findChild(arg_1_0.viewGO, "task/#go_taskReddot")
	arg_1_0._gotaskNew = gohelper.findChild(arg_1_0.viewGO, "task/#go_taskNew")
	arg_1_0._gobossUpdateTime = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossUpdateTime")
	arg_1_0._txtbossUpdateTime = gohelper.findChildText(arg_1_0.viewGO, "bossEpisode/#go_bossUpdateTime/#txt_bossUpdateTime")
	arg_1_0._gobossHasNew = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossHasNew")
	arg_1_0._btnboss = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bossEpisode/#btn_boss")
	arg_1_0._gobossContent = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossContent")
	arg_1_0._gobossItem = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossContent/#go_bossItem")
	arg_1_0._gobossLockTips = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_locktips")
	arg_1_0._txtaltitudeNum = gohelper.findChildText(arg_1_0.viewGO, "permanentEpisode/progress/#txt_altitudeNum")
	arg_1_0._goprogressContent = gohelper.findChild(arg_1_0.viewGO, "permanentEpisode/progress/#go_progressContent")
	arg_1_0._goprogressItem = gohelper.findChild(arg_1_0.viewGO, "permanentEpisode/progress/#go_progressContent/#go_progressItem")
	arg_1_0._btnpermanent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "permanentEpisode/#btn_permanent")
	arg_1_0._goticket = gohelper.findChild(arg_1_0.viewGO, "permanentEpisode/ticket")
	arg_1_0._imageticket = gohelper.findChildImage(arg_1_0.viewGO, "permanentEpisode/ticket/#image_ticket")
	arg_1_0._txtticketNum = gohelper.findChildText(arg_1_0.viewGO, "permanentEpisode/ticket/#txt_ticketNum")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._golimitTimeLockTips = gohelper.findChild(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeLockTips")
	arg_1_0._txtlimitTimeLockTips = gohelper.findChildText(arg_1_0.viewGO, "limitTimeEpisode/#go_limitTimeLockTips/#txt_limitTimeLockTips")
	arg_1_0._gobossLockTips = gohelper.findChild(arg_1_0.viewGO, "bossEpisode/#go_bossLockTips")
	arg_1_0._txtbossLockTips = gohelper.findChildText(arg_1_0.viewGO, "bossEpisode/#go_bossLockTips/#txt_bossLockTips")
	arg_1_0._gomopUpReddot = gohelper.findChild(arg_1_0.viewGO, "permanentEpisode/ticket/#go_mopupReddot")
	arg_1_0._btnmopUp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "permanentEpisode/ticket/#btn_mopup")
	arg_1_0._gostore = gohelper.findChild(arg_1_0.viewGO, "store")
	arg_1_0._gostoreTime = gohelper.findChild(arg_1_0.viewGO, "store/time")
	arg_1_0._txtstoreTime = gohelper.findChildText(arg_1_0.viewGO, "store/time/#txt_storeTime")
	arg_1_0._txtstoreName = gohelper.findChildText(arg_1_0.viewGO, "store/#txt_storeName")
	arg_1_0._txtcoinNum = gohelper.findChildText(arg_1_0.viewGO, "store/#txt_coinNum")
	arg_1_0._imagecoin = gohelper.findChildImage(arg_1_0.viewGO, "store/#txt_coinNum/#image_coin")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "store/#btn_store")
	arg_1_0._goheroTrial = gohelper.findChild(arg_1_0.viewGO, "heroTrial")
	arg_1_0._btnheroTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "heroTrial/#btn_heroTrial")
	arg_1_0._goheroTrialNew = gohelper.findChild(arg_1_0.viewGO, "heroTrial/#go_heroTrialNew")
	arg_1_0._goheroTrialNewEffect = gohelper.findChild(arg_1_0.viewGO, "heroTrial/#saoguang")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlimitTime:AddClickListener(arg_2_0._btnlimitTimeOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnboss:AddClickListener(arg_2_0._btnbossOnClick, arg_2_0)
	arg_2_0._btnpermanent:AddClickListener(arg_2_0._btnpermanentOnClick, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
	arg_2_0._btnheroTrial:AddClickListener(arg_2_0._btnheroTrialOnClick, arg_2_0)
	arg_2_0._btnmopUp:AddClickListener(arg_2_0._btnmopupOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.onDailyReresh, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_2_0.onLocalKeyChange, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.refreshRewardTaskInfo, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_2_0.refreshPermanentInfo, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshStore, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_2_0.refreshStore, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlimitTime:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnboss:RemoveClickListener()
	arg_3_0._btnpermanent:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnheroTrial:RemoveClickListener()
	arg_3_0._btnmopUp:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.onDailyReresh, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_3_0.onLocalKeyChange, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshRewardTaskInfo, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_3_0.refreshPermanentInfo, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStore, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_3_0.refreshStore, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshTowerState, arg_3_0)
end

function var_0_0._btnlimitTimeOnClick(arg_4_0)
	if not TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		return
	end

	if not TowerController.instance:isTimeLimitTowerOpen() then
		local var_4_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, var_4_0)

		return
	end

	TowerController.instance:openTowerTimeLimitLevelView()
end

function var_0_0._btntaskOnClick(arg_5_0)
	TowerController.instance:openTowerTaskView()
end

function var_0_0._btnstoreOnClick(arg_6_0)
	TowerController.instance:openTowerStoreView()
end

function var_0_0._btnbossOnClick(arg_7_0)
	if not TowerController.instance:isBossTowerOpen() then
		local var_7_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, var_7_0)

		return
	end

	if not TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSelectView)
end

function var_0_0._btnpermanentOnClick(arg_8_0)
	TowerController.instance:openTowerPermanentView()
end

function var_0_0._btnheroTrialOnClick(arg_9_0)
	TowerController.instance:openTowerHeroTrialView()
	arg_9_0:saveHeroTrialNew()
	gohelper.setActive(arg_9_0._goheroTrialNew, false)
end

function var_0_0._btnmopupOnClick(arg_10_0)
	TowerController.instance:openTowerMopUpView()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.bossItemTab = arg_11_0:getUserDataTb_()

	gohelper.setActive(arg_11_0._goheroTrialNewEffect, false)
end

function var_0_0.onDailyReresh(arg_12_0)
	arg_12_0:refreshUI()
end

function var_0_0.onLocalKeyChange(arg_13_0)
	arg_13_0:refreshBossNewTag()
	arg_13_0:refreshLimitedActTaskNew()
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0:checkJump()
end

function var_0_0.onOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_leimi_theft_open)
	TowerModel.instance:cleanTrialData()
	arg_15_0:checkJump()
	arg_15_0:refreshUI()
	arg_15_0:initReddot()
	TaskDispatcher.runDelay(arg_15_0.checkShowEffect, arg_15_0, 0.6)
end

function var_0_0.checkShowEffect(arg_16_0)
	local var_16_0 = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 0) == 0

	gohelper.setActive(arg_16_0._goheroTrialNewEffect, var_16_0)
end

function var_0_0.initReddot(arg_17_0)
	RedDotController.instance:addRedDot(arg_17_0._gomopUpReddot, RedDotEnum.DotNode.TowerMopUp)
	RedDotController.instance:addRedDot(arg_17_0._gotaskReddot, RedDotEnum.DotNode.TowerTask)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function var_0_0.refreshUI(arg_18_0)
	arg_18_0:refreshPermanentInfo()
	arg_18_0:initTaskInfo()
	arg_18_0:refreshRewardTaskInfo()
	arg_18_0:refreshBossInfo()
	arg_18_0:refreshBossNewTag()
	arg_18_0:refreshEntranceUI()
	arg_18_0:refreshTowerState()
	arg_18_0:refreshStore()
	arg_18_0:refreshHeroTrialNew()
	arg_18_0:refreshLimitedActTaskNew()
	TaskDispatcher.cancelTask(arg_18_0.refreshTowerState, arg_18_0)
	TaskDispatcher.runRepeat(arg_18_0.refreshTowerState, arg_18_0, 1)
end

function var_0_0.checkJump(arg_19_0)
	if not arg_19_0.viewParam then
		return
	end

	local var_19_0 = TowerModel.instance:getRecordFightParam()
	local var_19_1 = arg_19_0.viewParam.jumpId

	if var_19_1 == TowerEnum.JumpId.TowerPermanent then
		if tabletool.len(var_19_0) > 0 and var_19_0.towerType == TowerEnum.TowerType.Normal then
			TowerPermanentModel.instance:setLastPassLayer(var_19_0.layerId)
			TowerController.instance:openTowerPermanentView(var_19_0)
		else
			arg_19_0:_btnpermanentOnClick()
		end
	elseif var_19_1 == TowerEnum.JumpId.TowerBoss then
		if not arg_19_0.viewParam.towerId then
			ViewMgr.instance:openView(ViewName.TowerBossSelectView)
		else
			TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, arg_19_0.viewParam.towerId, {
				passLayerId = arg_19_0.viewParam.passLayerId
			})
		end
	elseif var_19_1 == TowerEnum.JumpId.TowerLimited then
		arg_19_0:_btnlimitTimeOnClick()
	elseif var_19_1 == TowerEnum.JumpId.TowerBossTeach then
		local var_19_2 = TowerBossTeachModel.instance:getLastFightTeachId()

		TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, arg_19_0.viewParam.towerId, {
			isTeach = true,
			lastFightTeachId = var_19_2
		})
		TowerBossTeachModel.instance:setLastFightTeachId(0)
	end

	if arg_19_0.viewParam.jumpId then
		arg_19_0.viewParam.jumpId = nil
	end
end

function var_0_0.refreshEntranceUI(arg_20_0)
	local var_20_0 = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local var_20_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TaskRewardOpen)
	local var_20_2 = TowerTaskModel.instance.limitTimeTaskList
	local var_20_3 = TowerTaskModel.instance.bossTaskList
	local var_20_4 = tabletool.len(var_20_2) + tabletool.len(var_20_3)
	local var_20_5 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	gohelper.setActive(arg_20_0._goticket, var_20_0 >= tonumber(var_20_5))
end

function var_0_0.initTaskInfo(arg_21_0)
	local var_21_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(var_21_0)
end

function var_0_0.refreshPermanentInfo(arg_22_0)
	local var_22_0 = TowerModel.instance:getMopUpTimes()
	local var_22_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	arg_22_0._txtticketNum.text = string.format("<color=#EA9465>%s</color>/%s", var_22_0, var_22_1)

	local var_22_2 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_22_0._imageticket, var_22_2 .. "_1", true)

	arg_22_0.curPassLayer = TowerPermanentModel.instance.curPassLayer

	local var_22_3 = TowerConfig.instance:getPermanentEpisodeCo(arg_22_0.curPassLayer)
	local var_22_4 = TowerConfig.instance:getPermanentEpisodeCo(arg_22_0.curPassLayer + 1)
	local var_22_5 = TowerPermanentModel.instance:getCurPassEpisodeId()

	if var_22_5 == 0 then
		arg_22_0._txtaltitudeNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_defaultlayer"), {
			0
		})
	else
		local var_22_6 = DungeonConfig.instance:getEpisodeCO(var_22_5)

		arg_22_0._txtaltitudeNum.text = var_22_6.name
	end

	local var_22_7 = TowerPermanentModel.instance:getStageCount()
	local var_22_8 = var_22_3 and var_22_3.stageId or 1
	local var_22_9 = var_22_4 and var_22_4.stageId or var_22_8 + 1
	local var_22_10 = {}

	for iter_22_0 = 1, var_22_7 do
		local var_22_11 = {
			curstageId = var_22_8 == var_22_9 and var_22_8 or var_22_9
		}

		table.insert(var_22_10, var_22_11)
	end

	gohelper.CreateObjList(arg_22_0, arg_22_0.progressItemShow, var_22_10, arg_22_0._goprogressContent, arg_22_0._goprogressItem)
end

function var_0_0.progressItemShow(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = gohelper.findChild(arg_23_1, "go_normal")
	local var_23_1 = gohelper.findChild(arg_23_1, "go_finish")
	local var_23_2 = arg_23_2.curstageId

	gohelper.setActive(var_23_0, var_23_2 <= arg_23_3)
	gohelper.setActive(var_23_1, arg_23_3 < var_23_2)
end

function var_0_0.refreshRewardTaskInfo(arg_24_0)
	return
end

function var_0_0.refreshBossInfo(arg_25_0)
	local var_25_0 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)
	local var_25_1 = {}

	if #var_25_0 > 0 then
		table.sort(var_25_0, TowerAssistBossModel.sortBossList)

		for iter_25_0 = 1, 3 do
			if var_25_0[iter_25_0] then
				table.insert(var_25_1, var_25_0[iter_25_0])
			end
		end
	end

	arg_25_0.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(arg_25_0, arg_25_0.bossItemShow, var_25_1, arg_25_0._gobossContent, arg_25_0._gobossItem)

	local var_25_2 = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(arg_25_0._gobossContent, var_25_2)
	gohelper.setActive(arg_25_0._gobossLockTips, not var_25_2)
end

function var_0_0.refreshBossNewTag(arg_26_0)
	local var_26_0 = TowerModel.instance:hasNewBossOpen()

	gohelper.setActive(arg_26_0._gobossHasNew, var_26_0)
end

function var_0_0.bossItemShow(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0.bossItemTab[arg_27_3]

	if not var_27_0 then
		var_27_0 = {}
		arg_27_0.bossItemTab[arg_27_3] = var_27_0
	end

	var_27_0.go = arg_27_1
	var_27_0.simageEnemy = gohelper.findChildSingleImage(var_27_0.go, "Mask/image_bossIcon")
	var_27_0.goSelected = gohelper.findChild(var_27_0.go, "#go_Selected")

	local var_27_1 = TowerConfig.instance:getBossTowerConfig(arg_27_2.id).bossId
	local var_27_2 = TowerConfig.instance:getAssistBossConfig(var_27_1)
	local var_27_3 = FightConfig.instance:getSkinCO(var_27_2.skinId)

	var_27_0.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(var_27_3 and var_27_3.headIcon))

	local var_27_4 = arg_27_0.bossEpisodeMo:isPassAllUnlockLayers(arg_27_2.id)

	gohelper.setActive(var_27_0.goSelected, not var_27_4)
end

function var_0_0.refreshTowerState(arg_28_0)
	local var_28_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_28_1 = TowerController.instance:isTimeLimitTowerOpen()
	local var_28_2 = TowerEnum.LockKey
	local var_28_3 = 0

	if var_28_0 then
		var_28_2 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, var_28_0.id, var_28_0, TowerEnum.LockKey)
		var_28_3 = var_28_0.nextTime / 1000 - ServerTime.now()

		local var_28_4, var_28_5 = TimeUtil.secondToRoughTime2(var_28_3)

		arg_28_0._txtlimitTimeUpdateTime.text = var_28_3 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			var_28_4,
			var_28_5
		}) or ""
	end

	local var_28_6 = not var_28_2 or var_28_2 == TowerEnum.LockKey

	gohelper.setActive(arg_28_0._golimitTimeHasNew, var_28_6 and var_28_1 and var_28_0)
	gohelper.setActive(arg_28_0._golimitTimeUpdateTime, not var_28_6 and var_28_1 and var_28_0 and var_28_3 > 0)

	local var_28_7 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

	if not var_28_0 then
		local var_28_8 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited)

		if var_28_8 then
			local var_28_9 = var_28_8.nextTime / 1000 - ServerTime.now()
			local var_28_10, var_28_11 = TimeUtil.secondToRoughTime2(var_28_9)

			arg_28_0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_28_10,
				var_28_11
			})
		else
			arg_28_0._txtlimitTimeLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not var_28_1 then
		arg_28_0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			var_28_7 * 10
		})
	end

	gohelper.setActive(arg_28_0._golimitTimeLockTips, not var_28_0 or not var_28_1)

	local var_28_12 = TowerModel.instance:hasNewBossOpen()
	local var_28_13 = TowerController.instance:isBossTowerOpen()
	local var_28_14 = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)
	local var_28_15 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
	local var_28_16 = -1

	for iter_28_0, iter_28_1 in ipairs(var_28_15) do
		local var_28_17 = iter_28_1.nextTime / 1000 - ServerTime.now()

		if var_28_17 < var_28_16 or var_28_16 <= 0 then
			var_28_16 = var_28_17
		end
	end

	local var_28_18, var_28_19 = TimeUtil.secondToRoughTime2(var_28_16)

	arg_28_0._txtbossUpdateTime.text = var_28_16 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		var_28_18,
		var_28_19
	}) or ""

	gohelper.setActive(arg_28_0._gobossHasNew, var_28_12 and var_28_13 and var_28_14)
	gohelper.setActive(arg_28_0._gobossUpdateTime, not var_28_12 and var_28_13 and var_28_14 and var_28_16 > 0)
	gohelper.setActive(arg_28_0._gobossContent, var_28_13)

	local var_28_20 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	if not var_28_14 then
		local var_28_21 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss)

		if var_28_21 then
			local var_28_22 = var_28_21.nextTime / 1000 - ServerTime.now()
			local var_28_23, var_28_24 = TimeUtil.secondToRoughTime2(var_28_22)

			arg_28_0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_28_23,
				var_28_24
			})
		else
			arg_28_0._txtbossLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not var_28_13 then
		arg_28_0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			var_28_20 * 10
		})
	end

	gohelper.setActive(arg_28_0._gobossLockTips, not var_28_14 or not var_28_13)
	arg_28_0:refreshStoreTime()
end

function var_0_0.refreshStore(arg_29_0)
	local var_29_0 = TowerController.instance:isTowerStoreOpen()

	gohelper.setActive(arg_29_0._gostore, var_29_0)

	local var_29_1 = TowerStoreModel.instance:getCurrencyIcon()

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_29_0._imagecoin, var_29_1)

	local var_29_2 = TowerStoreModel.instance:getCurrencyCount()

	arg_29_0._txtcoinNum.text = var_29_2

	arg_29_0:refreshStoreTime()
end

function var_0_0.refreshStoreTime(arg_30_0)
	local var_30_0 = TowerStoreModel.instance:isUpdateStoreEmpty()

	gohelper.setActive(arg_30_0._gostoreTime, not var_30_0)

	if var_30_0 then
		return
	end

	local var_30_1 = TowerStoreModel.instance:getUpdateStoreRemainTime()

	arg_30_0._txtstoreTime.text = var_30_1
end

function var_0_0.saveHeroTrialNew(arg_31_0)
	local var_31_0 = TowerModel.instance:getTrialHeroSeason()

	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, var_31_0)
end

function var_0_0.refreshHeroTrialNew(arg_32_0)
	local var_32_0 = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, 0)
	local var_32_1 = TowerModel.instance:getTrialHeroSeason()

	gohelper.setActive(arg_32_0._goheroTrial, var_32_1 > 0)
	gohelper.setActive(arg_32_0._goheroTrialNew, var_32_0 ~= var_32_1 and var_32_1 > 0)
end

function var_0_0.refreshLimitedActTaskNew(arg_33_0)
	local var_33_0 = TowerTaskModel.instance.actTaskList
	local var_33_1 = TowerEnum.LocalPrefsKey.ReddotNewLimitedActTask
	local var_33_2 = TowerController.instance:getPlayerPrefs(var_33_1, 0)
	local var_33_3 = #var_33_0 > 0 and var_33_0[1].config.activityId or 0
	local var_33_4 = var_33_2 ~= var_33_3 and var_33_3 > 0

	gohelper.setActive(arg_33_0._gotaskNew, var_33_4)
	gohelper.setActive(arg_33_0._gotaskReddot, not var_33_4)
end

function var_0_0.onClose(arg_34_0)
	TowerTaskModel.instance:cleanData()
	TaskDispatcher.cancelTask(arg_34_0.refreshTowerState, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0.checkShowEffect, arg_34_0)
	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 1)
end

function var_0_0.onDestroyView(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.bossItemTab) do
		iter_35_1.simageEnemy:UnLoadImage()
	end
end

return var_0_0
