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
	arg_1_0._gopermanentReddot = gohelper.findChild(arg_1_0.viewGO, "permanentEpisode/#btn_permanent/#go_permanentReddot")
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
	arg_1_0._goachievement = gohelper.findChild(arg_1_0.viewGO, "achievement")
	arg_1_0._goachievementIcon = gohelper.findChild(arg_1_0.viewGO, "achievement/go_icon")
	arg_1_0._btnachievement = gohelper.findChildButton(arg_1_0.viewGO, "achievement/#btn_Click")

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
	arg_2_0._btnachievement:AddClickListener(arg_2_0._btnonachievementClick, arg_2_0)
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
	arg_3_0._btnachievement:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.onDailyReresh, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, arg_3_0.onLocalKeyChange, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshRewardTaskInfo, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_3_0.refreshPermanentInfo, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStore, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_3_0.refreshStore, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshTowerState, arg_3_0)
end

function var_0_0._btnonachievementClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.AchievementNamePlatePanelView, {
		taskCo = arg_4_0._maxTaskAchievementCo
	})
end

function var_0_0._btnlimitTimeOnClick(arg_5_0)
	if not TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		return
	end

	if not TowerController.instance:isTimeLimitTowerOpen() then
		local var_5_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, var_5_0)

		return
	end

	TowerController.instance:openTowerTimeLimitLevelView()
end

function var_0_0._btntaskOnClick(arg_6_0)
	TowerController.instance:openTowerTaskView()
end

function var_0_0._btnstoreOnClick(arg_7_0)
	TowerController.instance:openTowerStoreView()
end

function var_0_0._btnbossOnClick(arg_8_0)
	if not TowerController.instance:isBossTowerOpen() then
		local var_8_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, var_8_0)

		return
	end

	if not TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSelectView)
end

function var_0_0._btnpermanentOnClick(arg_9_0)
	TowerController.instance:openTowerPermanentView()
end

function var_0_0._btnheroTrialOnClick(arg_10_0)
	TowerController.instance:openTowerHeroTrialView()
	arg_10_0:saveHeroTrialNew()
	gohelper.setActive(arg_10_0._goheroTrialNew, false)
end

function var_0_0._btnmopupOnClick(arg_11_0)
	TowerController.instance:openTowerMopUpView()
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.bossItemTab = arg_12_0:getUserDataTb_()

	arg_12_0:_initLevelItems()
	gohelper.setActive(arg_12_0._goheroTrialNewEffect, false)
end

function var_0_0._initLevelItems(arg_13_0)
	arg_13_0.levelItemList = {}

	for iter_13_0 = 1, 3 do
		local var_13_0 = {
			go = gohelper.findChild(arg_13_0._goachievementIcon, "level" .. iter_13_0)
		}

		var_13_0.unlock = gohelper.findChild(var_13_0.go, "#go_UnLocked")
		var_13_0.lock = gohelper.findChild(var_13_0.go, "#go_Locked")
		var_13_0.gounlockbg = gohelper.findChild(var_13_0.unlock, "#simage_bg")
		var_13_0.simageunlocktitle = gohelper.findChildSingleImage(var_13_0.unlock, "#simage_title")
		var_13_0.txtunlocklevel = gohelper.findChildText(var_13_0.unlock, "#txt_level")
		var_13_0.simagelockbg = gohelper.findChildSingleImage(var_13_0.lock, "#simage_bg")
		var_13_0.simagelocktitle = gohelper.findChildSingleImage(var_13_0.lock, "#simage_title")
		var_13_0.txtlocklevel = gohelper.findChildText(var_13_0.lock, "#txt_level")

		gohelper.setActive(var_13_0.go, false)
		table.insert(arg_13_0.levelItemList, var_13_0)
	end
end

function var_0_0.onDailyReresh(arg_14_0)
	arg_14_0:refreshUI()
end

function var_0_0.onLocalKeyChange(arg_15_0)
	arg_15_0:refreshBossNewTag()
	arg_15_0:refreshLimitedActTaskNew()
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0:checkJump()
end

function var_0_0.onOpen(arg_17_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_leimi_theft_open)
	TowerModel.instance:cleanTrialData()
	arg_17_0:checkJump()
	arg_17_0:refreshUI()
	arg_17_0:initReddot()
	TaskDispatcher.runDelay(arg_17_0.checkShowEffect, arg_17_0, 0.6)
end

function var_0_0.checkShowEffect(arg_18_0)
	local var_18_0 = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 0) == 0

	gohelper.setActive(arg_18_0._goheroTrialNewEffect, var_18_0)
end

function var_0_0.initReddot(arg_19_0)
	RedDotController.instance:addRedDot(arg_19_0._gomopUpReddot, RedDotEnum.DotNode.TowerMopUp)
	RedDotController.instance:addRedDot(arg_19_0._gotaskReddot, RedDotEnum.DotNode.TowerTask)
	RedDotController.instance:addRedDot(arg_19_0._gopermanentReddot, RedDotEnum.DotNode.TowerDeepTask)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function var_0_0.refreshUI(arg_20_0)
	arg_20_0:refreshPermanentInfo()
	arg_20_0:initTaskInfo()
	arg_20_0:refreshRewardTaskInfo()
	arg_20_0:refreshBossInfo()
	arg_20_0:refreshBossNewTag()
	arg_20_0:refreshEntranceUI()
	arg_20_0:refreshTowerState()
	arg_20_0:refreshStore()
	arg_20_0:refreshHeroTrialNew()
	arg_20_0:refreshLimitedActTaskNew()
	arg_20_0:refreshNamePlate()
	TaskDispatcher.cancelTask(arg_20_0.refreshTowerState, arg_20_0)
	TaskDispatcher.runRepeat(arg_20_0.refreshTowerState, arg_20_0, 1)
end

function var_0_0.refreshNamePlate(arg_21_0)
	local var_21_0 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.Tower)
	local var_21_1 = var_21_0 and var_21_0.achievementJumpId
	local var_21_2 = JumpConfig.instance:getJumpConfig(var_21_1)
	local var_21_3 = var_21_2 and var_21_2.param

	arg_21_0._maxTaskAchievementCo = nil

	if not string.nilorempty(var_21_3) then
		local var_21_4 = string.splitToNumber(var_21_3, "#")
		local var_21_5 = var_21_4 and var_21_4[3]
		local var_21_6 = AchievementConfig.instance:getAchievement(var_21_5)

		if not string.nilorempty(var_21_5) then
			arg_21_0._maxTaskAchievementCo = AchievementController.instance:getMaxLevelFinishTask(var_21_5)

			local var_21_7 = AchievementModel.instance:getById(arg_21_0._maxTaskAchievementCo.id)
			local var_21_8 = var_21_7 and var_21_7.hasFinished
			local var_21_9 = arg_21_0.levelItemList[arg_21_0._maxTaskAchievementCo.level]

			gohelper.setActive(var_21_9.go, true)
			gohelper.setActive(var_21_9.unlock, var_21_8)
			gohelper.setActive(var_21_9.lock, not var_21_8)

			local var_21_10
			local var_21_11
			local var_21_12

			if arg_21_0._maxTaskAchievementCo.image and not string.nilorempty(arg_21_0._maxTaskAchievementCo.image) then
				local var_21_13 = string.split(arg_21_0._maxTaskAchievementCo.image, "#")

				var_21_10 = var_21_13[1]
				var_21_11 = var_21_13[2]
				var_21_12 = var_21_13[3]
			end

			if var_21_8 then
				local function var_21_14()
					local var_22_0 = var_21_9._bgLoader:getInstGO()
				end

				var_21_9._bgLoader = PrefabInstantiate.Create(var_21_9.gounlockbg)

				var_21_9._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(var_21_10), var_21_14, arg_21_0)
				var_21_9.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_21_11))
			else
				var_21_9.simagelockbg:LoadImage(ResUrl.getAchievementIcon(var_21_12))
				var_21_9.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(var_21_11))
			end

			local var_21_15 = arg_21_0._maxTaskAchievementCo.listenerType
			local var_21_16 = AchievementUtils.getAchievementProgressBySourceType(var_21_6.rule)
			local var_21_17

			if var_21_15 and var_21_15 == "TowerPassLayer" then
				if arg_21_0._maxTaskAchievementCo.listenerParam and not string.nilorempty(arg_21_0._maxTaskAchievementCo.listenerParam) then
					local var_21_18 = string.split(arg_21_0._maxTaskAchievementCo.listenerParam, "#")

					var_21_17 = var_21_18 and var_21_18[3]
					var_21_17 = var_21_17 * 10
				end
			else
				var_21_17 = arg_21_0._maxTaskAchievementCo and arg_21_0._maxTaskAchievementCo.maxProgress
			end

			if var_21_8 then
				var_21_9.txtunlocklevel.text = var_21_17 < var_21_16 and var_21_16 or var_21_17
				var_21_9.txtlocklevel.text = var_21_17 < var_21_16 and var_21_16 or var_21_17
			else
				var_21_9.txtunlocklevel.text = var_21_17 < var_21_16 and var_21_17 or var_21_16
				var_21_9.txtlocklevel.text = var_21_17 < var_21_16 and var_21_17 or var_21_16
			end
		end
	end
end

function var_0_0.checkJump(arg_23_0)
	if not arg_23_0.viewParam then
		return
	end

	local var_23_0 = TowerModel.instance:getRecordFightParam()
	local var_23_1 = arg_23_0.viewParam.jumpId

	if var_23_1 == TowerEnum.JumpId.TowerPermanent then
		if tabletool.len(var_23_0) > 0 and (var_23_0.towerType == TowerEnum.TowerType.Normal or not var_23_0.towerType) then
			TowerPermanentModel.instance:setLastPassLayer(var_23_0.layerId)
			TowerController.instance:openTowerPermanentView(var_23_0)
		else
			arg_23_0:_btnpermanentOnClick()
		end
	elseif var_23_1 == TowerEnum.JumpId.TowerBoss then
		if not arg_23_0.viewParam.towerId then
			ViewMgr.instance:openView(ViewName.TowerBossSelectView)
		else
			TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, arg_23_0.viewParam.towerId, {
				passLayerId = arg_23_0.viewParam.passLayerId
			})
		end
	elseif var_23_1 == TowerEnum.JumpId.TowerLimited then
		arg_23_0:_btnlimitTimeOnClick()
	elseif var_23_1 == TowerEnum.JumpId.TowerBossTeach then
		local var_23_2 = TowerBossTeachModel.instance:getLastFightTeachId()

		TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, arg_23_0.viewParam.towerId, {
			isTeach = true,
			lastFightTeachId = var_23_2
		})
		TowerBossTeachModel.instance:setLastFightTeachId(0)
	end

	if arg_23_0.viewParam.jumpId then
		arg_23_0.viewParam.jumpId = nil
	end
end

function var_0_0.refreshEntranceUI(arg_24_0)
	local var_24_0 = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local var_24_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TaskRewardOpen)
	local var_24_2 = TowerTaskModel.instance.limitTimeTaskList
	local var_24_3 = TowerTaskModel.instance.bossTaskList
	local var_24_4 = tabletool.len(var_24_2) + tabletool.len(var_24_3)
	local var_24_5 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	gohelper.setActive(arg_24_0._goticket, var_24_0 >= tonumber(var_24_5))
end

function var_0_0.initTaskInfo(arg_25_0)
	local var_25_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(var_25_0)
	TowerDeepTaskModel.instance:setTaskInfoList()
end

function var_0_0.refreshPermanentInfo(arg_26_0)
	local var_26_0 = TowerModel.instance:getMopUpTimes()
	local var_26_1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	arg_26_0._txtticketNum.text = string.format("<color=#EA9465>%s</color>/%s", var_26_0, var_26_1)

	local var_26_2 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_26_0._imageticket, var_26_2 .. "_1", true)

	arg_26_0.curPassLayer = TowerPermanentModel.instance.curPassLayer

	local var_26_3 = TowerConfig.instance:getPermanentEpisodeCo(arg_26_0.curPassLayer)
	local var_26_4 = TowerConfig.instance:getPermanentEpisodeCo(arg_26_0.curPassLayer + 1)
	local var_26_5 = TowerPermanentModel.instance:getCurPassEpisodeId()

	if var_26_5 == 0 then
		arg_26_0._txtaltitudeNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_defaultlayer"), {
			0
		})
	else
		local var_26_6 = TowerPermanentDeepModel.instance:getCurMaxDeepHigh()
		local var_26_7 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)
		local var_26_8 = TowerPermanentDeepModel.instance.isOpenEndless

		if var_26_7 < var_26_6 or var_26_8 then
			arg_26_0._txtaltitudeNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towermain_deeplayer"), var_26_6)
		else
			local var_26_9 = DungeonConfig.instance:getEpisodeCO(var_26_5)

			arg_26_0._txtaltitudeNum.text = var_26_9.name
		end
	end

	local var_26_10 = TowerPermanentModel.instance:getStageCount()
	local var_26_11 = var_26_3 and var_26_3.stageId or 1
	local var_26_12 = var_26_4 and var_26_4.stageId or var_26_11 + 1
	local var_26_13 = {}

	for iter_26_0 = 1, var_26_10 do
		local var_26_14 = {
			curstageId = var_26_11 == var_26_12 and var_26_11 or var_26_12
		}

		table.insert(var_26_13, var_26_14)
	end

	gohelper.CreateObjList(arg_26_0, arg_26_0.progressItemShow, var_26_13, arg_26_0._goprogressContent, arg_26_0._goprogressItem)
end

function var_0_0.progressItemShow(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = gohelper.findChild(arg_27_1, "go_normal")
	local var_27_1 = gohelper.findChild(arg_27_1, "go_finish")
	local var_27_2 = arg_27_2.curstageId

	gohelper.setActive(var_27_0, var_27_2 <= arg_27_3)
	gohelper.setActive(var_27_1, arg_27_3 < var_27_2)
end

function var_0_0.refreshRewardTaskInfo(arg_28_0)
	return
end

function var_0_0.refreshBossInfo(arg_29_0)
	local var_29_0 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)
	local var_29_1 = {}

	if #var_29_0 > 0 then
		table.sort(var_29_0, TowerAssistBossModel.sortBossList)

		for iter_29_0 = 1, 3 do
			if var_29_0[iter_29_0] then
				table.insert(var_29_1, var_29_0[iter_29_0])
			end
		end
	end

	arg_29_0.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(arg_29_0, arg_29_0.bossItemShow, var_29_1, arg_29_0._gobossContent, arg_29_0._gobossItem)

	local var_29_2 = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(arg_29_0._gobossContent, var_29_2)
	gohelper.setActive(arg_29_0._gobossLockTips, not var_29_2)
end

function var_0_0.refreshBossNewTag(arg_30_0)
	local var_30_0 = TowerModel.instance:hasNewBossOpen()

	gohelper.setActive(arg_30_0._gobossHasNew, var_30_0)
end

function var_0_0.bossItemShow(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0.bossItemTab[arg_31_3]

	if not var_31_0 then
		var_31_0 = {}
		arg_31_0.bossItemTab[arg_31_3] = var_31_0
	end

	var_31_0.go = arg_31_1
	var_31_0.simageEnemy = gohelper.findChildSingleImage(var_31_0.go, "Mask/image_bossIcon")
	var_31_0.goSelected = gohelper.findChild(var_31_0.go, "#go_Selected")

	local var_31_1 = TowerConfig.instance:getBossTowerConfig(arg_31_2.id).bossId
	local var_31_2 = TowerConfig.instance:getAssistBossConfig(var_31_1)
	local var_31_3 = FightConfig.instance:getSkinCO(var_31_2.skinId)

	var_31_0.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(var_31_3 and var_31_3.headIcon))

	local var_31_4 = arg_31_0.bossEpisodeMo:isPassAllUnlockLayers(arg_31_2.id)

	gohelper.setActive(var_31_0.goSelected, not var_31_4)
end

function var_0_0.refreshTowerState(arg_32_0)
	local var_32_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_32_1 = TowerController.instance:isTimeLimitTowerOpen()
	local var_32_2 = TowerEnum.LockKey
	local var_32_3 = 0

	if var_32_0 then
		var_32_2 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, var_32_0.id, var_32_0, TowerEnum.LockKey)
		var_32_3 = var_32_0.nextTime / 1000 - ServerTime.now()

		local var_32_4, var_32_5 = TimeUtil.secondToRoughTime2(var_32_3)

		arg_32_0._txtlimitTimeUpdateTime.text = var_32_3 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			var_32_4,
			var_32_5
		}) or ""
	end

	local var_32_6 = not var_32_2 or var_32_2 == TowerEnum.LockKey

	gohelper.setActive(arg_32_0._golimitTimeHasNew, var_32_6 and var_32_1 and var_32_0)
	gohelper.setActive(arg_32_0._golimitTimeUpdateTime, not var_32_6 and var_32_1 and var_32_0 and var_32_3 > 0)

	local var_32_7 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

	if not var_32_0 then
		local var_32_8 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited)

		if var_32_8 then
			local var_32_9 = var_32_8.nextTime / 1000 - ServerTime.now()
			local var_32_10, var_32_11 = TimeUtil.secondToRoughTime2(var_32_9)

			arg_32_0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_32_10,
				var_32_11
			})
		else
			arg_32_0._txtlimitTimeLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not var_32_1 then
		arg_32_0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			var_32_7 * 10
		})
	end

	gohelper.setActive(arg_32_0._golimitTimeLockTips, not var_32_0 or not var_32_1)

	local var_32_12 = TowerModel.instance:hasNewBossOpen()
	local var_32_13 = TowerController.instance:isBossTowerOpen()
	local var_32_14 = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)
	local var_32_15 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
	local var_32_16 = -1

	for iter_32_0, iter_32_1 in ipairs(var_32_15) do
		local var_32_17 = iter_32_1.nextTime / 1000 - ServerTime.now()

		if var_32_17 < var_32_16 or var_32_16 <= 0 then
			var_32_16 = var_32_17
		end
	end

	local var_32_18, var_32_19 = TimeUtil.secondToRoughTime2(var_32_16)

	arg_32_0._txtbossUpdateTime.text = var_32_16 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		var_32_18,
		var_32_19
	}) or ""

	gohelper.setActive(arg_32_0._gobossHasNew, var_32_12 and var_32_13 and var_32_14)
	gohelper.setActive(arg_32_0._gobossUpdateTime, not var_32_12 and var_32_13 and var_32_14 and var_32_16 > 0)
	gohelper.setActive(arg_32_0._gobossContent, var_32_13)

	local var_32_20 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	if not var_32_14 then
		local var_32_21 = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss)

		if var_32_21 then
			local var_32_22 = var_32_21.nextTime / 1000 - ServerTime.now()
			local var_32_23, var_32_24 = TimeUtil.secondToRoughTime2(var_32_22)

			arg_32_0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				var_32_23,
				var_32_24
			})
		else
			arg_32_0._txtbossLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not var_32_13 then
		arg_32_0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			var_32_20 * 10
		})
	end

	gohelper.setActive(arg_32_0._gobossLockTips, not var_32_14 or not var_32_13)
	arg_32_0:refreshStoreTime()
end

function var_0_0.refreshStore(arg_33_0)
	local var_33_0 = TowerController.instance:isTowerStoreOpen()

	gohelper.setActive(arg_33_0._gostore, var_33_0)

	local var_33_1 = TowerStoreModel.instance:getCurrencyIcon()

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_33_0._imagecoin, var_33_1)

	local var_33_2 = TowerStoreModel.instance:getCurrencyCount()

	arg_33_0._txtcoinNum.text = var_33_2

	arg_33_0:refreshStoreTime()
end

function var_0_0.refreshStoreTime(arg_34_0)
	local var_34_0 = TowerStoreModel.instance:isUpdateStoreEmpty()

	gohelper.setActive(arg_34_0._gostoreTime, not var_34_0)

	if var_34_0 then
		return
	end

	local var_34_1 = TowerStoreModel.instance:getUpdateStoreRemainTime()

	arg_34_0._txtstoreTime.text = var_34_1
end

function var_0_0.saveHeroTrialNew(arg_35_0)
	local var_35_0 = TowerModel.instance:getTrialHeroSeason()

	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, var_35_0)
end

function var_0_0.refreshHeroTrialNew(arg_36_0)
	local var_36_0 = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, 0)
	local var_36_1 = TowerModel.instance:getTrialHeroSeason()

	gohelper.setActive(arg_36_0._goheroTrial, var_36_1 > 0)
	gohelper.setActive(arg_36_0._goheroTrialNew, var_36_0 ~= var_36_1 and var_36_1 > 0)
end

function var_0_0.refreshLimitedActTaskNew(arg_37_0)
	local var_37_0 = TowerTaskModel.instance.actTaskList
	local var_37_1 = TowerEnum.LocalPrefsKey.ReddotNewLimitedActTask
	local var_37_2 = TowerController.instance:getPlayerPrefs(var_37_1, 0)
	local var_37_3 = #var_37_0 > 0 and var_37_0[1].config.activityId or 0
	local var_37_4 = var_37_2 ~= var_37_3 and var_37_3 > 0

	gohelper.setActive(arg_37_0._gotaskNew, var_37_4)
	gohelper.setActive(arg_37_0._gotaskReddot, not var_37_4)
end

function var_0_0.onClose(arg_38_0)
	TowerTaskModel.instance:cleanData()
	TaskDispatcher.cancelTask(arg_38_0.refreshTowerState, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0.checkShowEffect, arg_38_0)
	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 1)
end

function var_0_0.onDestroyView(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.bossItemTab) do
		iter_39_1.simageEnemy:UnLoadImage()
	end
end

return var_0_0
