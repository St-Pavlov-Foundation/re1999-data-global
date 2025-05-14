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
	arg_1_0._gobossHandbook = gohelper.findChild(arg_1_0.viewGO, "bossHandbook")
	arg_1_0._btnbossHandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bossHandbook/#btn_bossHandbook")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "reward")
	arg_1_0._imagerewardIcon = gohelper.findChildImage(arg_1_0.viewGO, "reward/#image_rewardIcon")
	arg_1_0._txttotalTaskNum = gohelper.findChildText(arg_1_0.viewGO, "reward/#txt_totalTaskNum")
	arg_1_0._txtcurTaskNum = gohelper.findChildText(arg_1_0.viewGO, "reward/#txt_totalTaskNum/#txt_curTaskNum")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "reward/#btn_reward")
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
	arg_1_0._gopermanentReddot = gohelper.findChild(arg_1_0.viewGO, "permanentEpisode/#go_permanenetReddot")
	arg_1_0._gotaskReddot = gohelper.findChild(arg_1_0.viewGO, "reward/#go_taskReddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlimitTime:AddClickListener(arg_2_0._btnlimitTimeOnClick, arg_2_0)
	arg_2_0._btnbossHandbook:AddClickListener(arg_2_0._btnbossHandbookOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnboss:AddClickListener(arg_2_0._btnbossOnClick, arg_2_0)
	arg_2_0._btnpermanent:AddClickListener(arg_2_0._btnpermanentOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.onDailyReresh, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_2_0.onLocalKeyChange, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.refreshRewardTaskInfo, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_2_0.refreshPermanentInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlimitTime:RemoveClickListener()
	arg_3_0._btnbossHandbook:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnboss:RemoveClickListener()
	arg_3_0._btnpermanent:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.onDailyReresh, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_3_0.onLocalKeyChange, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshRewardTaskInfo, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_3_0.refreshPermanentInfo, arg_3_0)
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

function var_0_0._btnbossHandbookOnClick(arg_5_0)
	TowerController.instance:openAssistBossView()
end

function var_0_0._btnrewardOnClick(arg_6_0)
	TowerController.instance:openTowerTaskView()
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

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.bossItemTab = arg_9_0:getUserDataTb_()
end

function var_0_0.onDailyReresh(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0.onLocalKeyChange(arg_11_0)
	arg_11_0:refreshBossNewTag()
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:checkJump()
end

function var_0_0.onOpen(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_leimi_theft_open)
	arg_13_0:checkJump()
	arg_13_0:refreshUI()
	arg_13_0:initReddot()
end

function var_0_0.initReddot(arg_14_0)
	RedDotController.instance:addRedDot(arg_14_0._gopermanentReddot, RedDotEnum.DotNode.PermanentTower)
	RedDotController.instance:addRedDot(arg_14_0._gotaskReddot, RedDotEnum.DotNode.TowerTask)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:refreshPermanentInfo()
	arg_15_0:initTaskInfo()
	arg_15_0:refreshRewardTaskInfo()
	arg_15_0:refreshBossInfo()
	arg_15_0:refreshBossNewTag()
	arg_15_0:refreshEntranceUI()
	arg_15_0:refreshTowerState()
	TaskDispatcher.cancelTask(arg_15_0.refreshTowerState, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0.refreshTowerState, arg_15_0, 1)
end

function var_0_0.checkJump(arg_16_0)
	if not arg_16_0.viewParam then
		return
	end

	local var_16_0 = TowerModel.instance:getRecordFightParam()
	local var_16_1 = arg_16_0.viewParam.jumpId

	if var_16_1 == TowerEnum.JumpId.TowerPermanent then
		if tabletool.len(var_16_0) > 0 and var_16_0.towerType == TowerEnum.TowerType.Normal then
			TowerPermanentModel.instance:setLastPassLayer(var_16_0.layerId)
			TowerController.instance:openTowerPermanentView(var_16_0)
		else
			arg_16_0:_btnpermanentOnClick()
		end
	elseif var_16_1 == TowerEnum.JumpId.TowerBoss then
		if not arg_16_0.viewParam.towerId then
			ViewMgr.instance:openView(ViewName.TowerBossSelectView)
		else
			TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, arg_16_0.viewParam.towerId, {
				passLayerId = arg_16_0.viewParam.passLayerId
			})
		end
	elseif var_16_1 == TowerEnum.JumpId.TowerLimited then
		arg_16_0:_btnlimitTimeOnClick()
	end

	if arg_16_0.viewParam.jumpId then
		arg_16_0.viewParam.jumpId = nil
	end
end

function var_0_0.refreshEntranceUI(arg_17_0)
	local var_17_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossHandbookOpen)
	local var_17_1 = TowerPermanentModel.instance:getCurPermanentPassLayer()

	gohelper.setActive(arg_17_0._gobossHandbook, var_17_1 >= tonumber(var_17_0))

	local var_17_2 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TaskRewardOpen)
	local var_17_3 = TowerTaskModel.instance.limitTimeTaskList
	local var_17_4 = TowerTaskModel.instance.bossTaskList
	local var_17_5 = tabletool.len(var_17_3) + tabletool.len(var_17_4)

	gohelper.setActive(arg_17_0._goreward, var_17_1 >= tonumber(var_17_2) and var_17_5 > 0)

	local var_17_6 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	gohelper.setActive(arg_17_0._goticket, var_17_1 >= tonumber(var_17_6))
end

function var_0_0.initTaskInfo(arg_18_0)
	local var_18_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(var_18_0)
end

function var_0_0.refreshPermanentInfo(arg_19_0)
	local var_19_0 = TowerModel.instance:getMopUpTimes()
	local var_19_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	arg_19_0._txtticketNum.text = string.format("<color=#EA9465>%s</color>/%s", var_19_0, var_19_1)

	local var_19_2 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_19_0._imageticket, var_19_2 .. "_1", true)

	arg_19_0.curPassLayer = TowerPermanentModel.instance.curPassLayer

	local var_19_3 = TowerConfig.instance:getPermanentEpisodeCo(arg_19_0.curPassLayer)
	local var_19_4 = TowerConfig.instance:getPermanentEpisodeCo(arg_19_0.curPassLayer + 1)
	local var_19_5 = TowerPermanentModel.instance:getCurPassEpisodeId()

	if var_19_5 == 0 then
		arg_19_0._txtaltitudeNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_defaultlayer"), {
			0
		})
	else
		local var_19_6 = DungeonConfig.instance:getEpisodeCO(var_19_5)

		arg_19_0._txtaltitudeNum.text = var_19_6.name
	end

	local var_19_7 = TowerPermanentModel.instance:getStageCount()
	local var_19_8 = var_19_3 and var_19_3.stageId or 1
	local var_19_9 = var_19_4 and var_19_4.stageId or var_19_8 + 1
	local var_19_10 = {}

	for iter_19_0 = 1, var_19_7 do
		local var_19_11 = {
			curstageId = var_19_8 == var_19_9 and var_19_8 or var_19_9
		}

		table.insert(var_19_10, var_19_11)
	end

	gohelper.CreateObjList(arg_19_0, arg_19_0.progressItemShow, var_19_10, arg_19_0._goprogressContent, arg_19_0._goprogressItem)
end

function var_0_0.progressItemShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = gohelper.findChild(arg_20_1, "go_normal")
	local var_20_1 = gohelper.findChild(arg_20_1, "go_finish")
	local var_20_2 = arg_20_2.curstageId

	gohelper.setActive(var_20_0, var_20_2 <= arg_20_3)
	gohelper.setActive(var_20_1, arg_20_3 < var_20_2)
end

function var_0_0.refreshRewardTaskInfo(arg_21_0)
	local var_21_0, var_21_1 = TowerTaskModel.instance:getTotalTaskRewardCount()

	arg_21_0._txttotalTaskNum.text = var_21_1
	arg_21_0._txtcurTaskNum.text = var_21_0
end

function var_0_0.refreshBossInfo(arg_22_0)
	local var_22_0 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	arg_22_0.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(arg_22_0, arg_22_0.bossItemShow, var_22_0, arg_22_0._gobossContent, arg_22_0._gobossItem)

	local var_22_1 = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(arg_22_0._gobossContent, var_22_1)
	gohelper.setActive(arg_22_0._gobossLockTips, not var_22_1)
end

function var_0_0.refreshBossNewTag(arg_23_0)
	local var_23_0 = TowerModel.instance:hasNewBossOpen()

	gohelper.setActive(arg_23_0._gobossHasNew, var_23_0)
end

function var_0_0.bossItemShow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0.bossItemTab[arg_24_3]

	if not var_24_0 then
		var_24_0 = {}
		arg_24_0.bossItemTab[arg_24_3] = var_24_0
	end

	var_24_0.go = arg_24_1
	var_24_0.simageEnemy = gohelper.findChildSingleImage(var_24_0.go, "Mask/image_bossIcon")
	var_24_0.goSelected = gohelper.findChild(var_24_0.go, "#go_Selected")

	local var_24_1 = TowerConfig.instance:getBossTowerConfig(arg_24_2.id).bossId
	local var_24_2 = TowerConfig.instance:getAssistBossConfig(var_24_1)
	local var_24_3 = FightConfig.instance:getSkinCO(var_24_2.skinId)

	var_24_0.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(var_24_3 and var_24_3.headIcon))

	local var_24_4 = arg_24_0.bossEpisodeMo:isPassAllUnlockLayers(arg_24_2.id)

	gohelper.setActive(var_24_0.goSelected, not var_24_4)
end

function var_0_0.refreshTowerState(arg_25_0)
	local var_25_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_25_1 = TowerController.instance:isTimeLimitTowerOpen()
	local var_25_2 = TowerEnum.LockKey
	local var_25_3 = 0

	if var_25_0 then
		var_25_2 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, var_25_0.id, var_25_0, TowerEnum.LockKey)
		var_25_3 = var_25_0.nextTime / 1000 - ServerTime.now()

		local var_25_4, var_25_5 = TimeUtil.secondToRoughTime2(var_25_3)

		arg_25_0._txtlimitTimeUpdateTime.text = var_25_3 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			var_25_4,
			var_25_5
		}) or ""
	end

	local var_25_6 = not var_25_2 or var_25_2 == TowerEnum.LockKey

	gohelper.setActive(arg_25_0._golimitTimeHasNew, var_25_6 and var_25_1 and var_25_0)
	gohelper.setActive(arg_25_0._golimitTimeUpdateTime, not var_25_6 and var_25_1 and var_25_0 and var_25_3 > 0)

	local var_25_7 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

	if not var_25_0 then
		local var_25_8 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited)

		if var_25_8 then
			local var_25_9 = var_25_8.nextTime / 1000 - ServerTime.now()
			local var_25_10, var_25_11 = TimeUtil.secondToRoughTime2(var_25_9)

			arg_25_0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_25_10,
				var_25_11
			})
		else
			arg_25_0._txtlimitTimeLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not var_25_1 then
		arg_25_0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			var_25_7 * 10
		})
	end

	gohelper.setActive(arg_25_0._golimitTimeLockTips, not var_25_0 or not var_25_1)

	local var_25_12 = TowerModel.instance:hasNewBossOpen()
	local var_25_13 = TowerController.instance:isBossTowerOpen()
	local var_25_14 = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)
	local var_25_15 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
	local var_25_16 = -1

	for iter_25_0, iter_25_1 in ipairs(var_25_15) do
		local var_25_17 = iter_25_1.nextTime / 1000 - ServerTime.now()

		if var_25_17 < var_25_16 or var_25_16 <= 0 then
			var_25_16 = var_25_17
		end
	end

	local var_25_18, var_25_19 = TimeUtil.secondToRoughTime2(var_25_16)

	arg_25_0._txtbossUpdateTime.text = var_25_16 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		var_25_18,
		var_25_19
	}) or ""

	gohelper.setActive(arg_25_0._gobossHasNew, var_25_12 and var_25_13 and var_25_14)
	gohelper.setActive(arg_25_0._gobossUpdateTime, not var_25_12 and var_25_13 and var_25_14 and var_25_16 > 0)
	gohelper.setActive(arg_25_0._gobossContent, var_25_13)

	local var_25_20 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	if not var_25_14 then
		local var_25_21 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss)

		if var_25_21 then
			local var_25_22 = var_25_21.nextTime / 1000 - ServerTime.now()
			local var_25_23, var_25_24 = TimeUtil.secondToRoughTime2(var_25_22)

			arg_25_0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_25_23,
				var_25_24
			})
		else
			arg_25_0._txtbossLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not var_25_13 then
		arg_25_0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			var_25_20 * 10
		})
	end

	gohelper.setActive(arg_25_0._gobossLockTips, not var_25_14 or not var_25_13)
end

function var_0_0.onClose(arg_26_0)
	TowerTaskModel.instance:cleanData()
	TaskDispatcher.cancelTask(arg_26_0.refreshTowerState, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.bossItemTab) do
		iter_27_1.simageEnemy:UnLoadImage()
	end
end

return var_0_0
