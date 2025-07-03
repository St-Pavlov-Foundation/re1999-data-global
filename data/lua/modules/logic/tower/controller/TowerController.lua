module("modules.logic.tower.controller.TowerController", package.seeall)

local var_0_0 = class("TowerController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.jumpFlow = nil
end

function var_0_0.reInit(arg_2_0)
	if arg_2_0.jumpFlow then
		arg_2_0.jumpFlow:onDestroyInternal()
	end

	arg_2_0.jumpFlow = nil
end

function var_0_0.addConstEvents(arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0.onUpdateTaskList, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_3_0.onSetTaskList, arg_3_0)
	arg_3_0:registerCallback(TowerEvent.DailyReresh, arg_3_0.dailyReddotRefresh, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0.jumpView(arg_4_0, arg_4_1)
	if not ViewMgr.instance:isOpen(ViewName.TowerMainView) then
		arg_4_0.jumpFlow = FlowSequence.New()

		local var_4_0 = TowerEnterWork.New()

		arg_4_0.jumpFlow:addWork(var_4_0)
		arg_4_0.jumpFlow:addWork(FunctionWork.New(arg_4_0.realJumpTowerView, arg_4_0, arg_4_1))
		arg_4_0.jumpFlow:registerDoneListener(arg_4_0.flowDone, arg_4_0)
		arg_4_0.jumpFlow:start()
	else
		arg_4_0:realJumpTowerView(arg_4_1)
	end
end

function var_0_0.realJumpTowerView(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.towerType
	local var_5_1 = arg_5_1.towerId

	if var_5_0 == TowerEnum.TowerType.Boss then
		arg_5_0:openBossTowerEpisodeView(var_5_0, var_5_1)
	elseif var_5_0 == TowerEnum.TowerType.Limited then
		arg_5_0:openTowerTimeLimitLevelView()
	elseif var_5_0 == TowerEnum.TowerType.Normal then
		arg_5_0:openTowerPermanentView()
	end

	if arg_5_0.jumpFlow then
		arg_5_0.jumpFlow:onDone(true)
	end
end

function var_0_0.flowDone(arg_6_0, arg_6_1)
	arg_6_0.jumpFlow = nil
end

function var_0_0.openMainView(arg_7_0, arg_7_1)
	arg_7_0._mainviewParam = arg_7_1

	TowerRpc.instance:sendGetTowerInfoRequest(arg_7_0._openMainView, arg_7_0)
end

function var_0_0._openMainView(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= 0 then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_1 == 0 then
			StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function(arg_10_0, arg_10_1, arg_10_2)
				if arg_10_1 == 0 then
					ViewMgr.instance:openView(ViewName.TowerMainView, arg_8_0._mainviewParam)
				end
			end)
		end
	end)
end

function var_0_0.openBossTowerEpisodeView(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_1 or not arg_11_2 then
		return
	end

	local var_11_0 = TowerModel.instance:getEpisodeMoByTowerType(arg_11_1)
	local var_11_1 = TowerModel.instance:getTowerInfoById(arg_11_1, arg_11_2)

	if not TowerModel.instance:getTowerOpenInfo(arg_11_1, arg_11_2) then
		return
	end

	local var_11_2 = var_11_1 and var_11_1.passLayerId or 0
	local var_11_3 = var_11_0:getNextEpisodeLayer(arg_11_2, var_11_2) or var_11_2
	local var_11_4 = var_11_0:getEpisodeConfig(arg_11_2, var_11_3)

	if var_11_4 then
		local var_11_5 = arg_11_3 or {}

		var_11_5.episodeConfig = var_11_4

		if var_11_4.openRound > 0 then
			if var_11_1:isSpLayerOpen(var_11_4.layerId) then
				ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, var_11_5)
			else
				var_11_5.episodeConfig = var_11_0:getEpisodeConfig(arg_11_2, var_11_2)

				if var_11_5.episodeConfig.openRound > 0 then
					ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, var_11_5)
				else
					ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, var_11_5)
				end
			end
		else
			ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, var_11_5)
		end

		TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Boss)
	end
end

function var_0_0.openAssistBossView(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	ViewMgr.instance:openView(ViewName.TowerAssistBossView, {
		bossId = arg_12_1,
		isFromHeroGroup = arg_12_2,
		towerType = arg_12_3,
		towerId = arg_12_4
	})
end

function var_0_0.enterFight(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	arg_13_0.enterFightParam = arg_13_1

	local var_13_0 = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit

	if arg_13_1.towerType == TowerEnum.TowerType.Boss then
		var_13_0 = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	end

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(var_13_0, arg_13_0._enterFight, arg_13_0)
end

function var_0_0._enterFight(arg_14_0)
	local var_14_0 = arg_14_0.enterFightParam

	if not var_14_0 then
		return
	end

	local var_14_1 = var_14_0.episodeId

	TowerModel.instance:setRecordFightParam(var_14_0.towerType, var_14_0.towerId, var_14_0.layerId, var_14_0.difficulty, var_14_1)

	local var_14_2 = var_14_0.speed or 1
	local var_14_3 = DungeonConfig.instance:getEpisodeCO(var_14_1)

	DungeonFightController.instance:enterFight(var_14_3.chapterId, var_14_1, var_14_2)
end

function var_0_0.startFight(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_1 then
		return
	end

	DungeonModel.instance:SetSendChapterEpisodeId(arg_15_1.chapterId, arg_15_1.episodeId)
	TowerRpc.instance:sendStartTowerBattleRequest(arg_15_1, arg_15_2, arg_15_3)
end

function var_0_0.restartStage(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = FightModel.instance:getFightParam()

	var_16_0.fightParam = var_16_1
	var_16_0.chapterId = var_16_1.chapterId
	var_16_0.episodeId = var_16_1.episodeId
	var_16_0.useRecord = var_16_1.isReplay
	var_16_0.multiplication = var_16_1.multiplication
	var_16_0.isRestart = true

	arg_16_0:startFight(var_16_0)
end

function var_0_0.openTowerMopUpView(arg_17_0, arg_17_1)
	ViewMgr.instance:openView(ViewName.TowerMopUpView, arg_17_1)
end

function var_0_0.openTowerPermanentView(arg_18_0, arg_18_1)
	TowerPermanentModel.instance:onInit()
	TowerPermanentModel.instance:InitData()

	if arg_18_1 and tabletool.len(arg_18_1) > 0 then
		local var_18_0 = TowerConfig.instance:getPermanentEpisodeCo(arg_18_1.layerId)
		local var_18_1 = var_18_0.stageId
		local var_18_2 = var_18_0.index

		TowerPermanentModel.instance:setCurSelectLayer(var_18_2, var_18_1)
		TowerPermanentModel.instance:setCurSelectStage(var_18_1)
	end

	TowerPermanentModel.instance:initStageUnFoldState()
	ViewMgr.instance:openView(ViewName.TowerPermanentView, arg_18_1)
	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Normal)
end

function var_0_0.openTowerStoreView(arg_19_0)
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function()
		local var_20_0 = {}

		ViewMgr.instance:openView(ViewName.TowerStoreView, var_20_0)
	end, arg_19_0)
end

function var_0_0.openTowerHeroTrialView(arg_21_0, arg_21_1)
	ViewMgr.instance:openView(ViewName.TowerHeroTrialView, arg_21_1)
end

function var_0_0.openTowerBossTeachView(arg_22_0, arg_22_1)
	ViewMgr.instance:openView(ViewName.TowerBossTeachView, arg_22_1)
end

function var_0_0.openTowerTaskView(arg_23_0, arg_23_1)
	local var_23_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if not var_23_0 or not var_23_0.towerId then
		local var_23_1 = 1
	end

	local var_23_2 = arg_23_1 or {}

	var_23_2.towerType = arg_23_1 and arg_23_1.towerType
	var_23_2.towerId = arg_23_1 and arg_23_1.towerId

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function()
		ViewMgr.instance:openView(ViewName.TowerTaskView, var_23_2)
	end)
end

function var_0_0.selectDefaultTowerTask(arg_25_0)
	local var_25_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_25_1 = var_25_0 and var_25_0.towerId or 1

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(TowerEnum.TowerType.Limited, var_25_1)
end

function var_0_0.onUpdateTaskList(arg_26_0, arg_26_1)
	if TowerTaskModel.instance:updateTaskInfo(arg_26_1.taskInfo) then
		TowerTaskModel.instance:refreshList()
	end

	arg_26_0:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function var_0_0.onSetTaskList(arg_27_0)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.TowerTask
	})

	local var_27_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(var_27_0)

	local var_27_1 = TowerTaskModel.instance.curSelectTowerType

	TowerTaskModel.instance:refreshList(var_27_1)
	arg_27_0:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function var_0_0.openTowerTimeLimitLevelView(arg_28_0, arg_28_1)
	ViewMgr.instance:openView(ViewName.TowerTimeLimitLevelView, arg_28_1)
	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Limited)
end

function var_0_0.getRecommendList(arg_29_0, arg_29_1)
	local var_29_0 = {}
	local var_29_1 = lua_battle.configDict[arg_29_1]

	if var_29_1 and not string.nilorempty(var_29_1.monsterGroupIds) then
		local var_29_2 = string.splitToNumber(var_29_1.monsterGroupIds, "#")

		for iter_29_0, iter_29_1 in ipairs(var_29_2) do
			local var_29_3 = string.splitToNumber(lua_monster_group.configDict[iter_29_1].monster, "#")

			for iter_29_2, iter_29_3 in ipairs(var_29_3) do
				local var_29_4 = lua_monster.configDict[iter_29_3].career

				if not tabletool.indexOf(var_29_0, var_29_4) then
					table.insert(var_29_0, var_29_4)
				end
			end
		end

		var_29_0 = FightHelper.getAttributeCounter(var_29_2, false)
	end

	return var_29_0
end

function var_0_0.setPlayerPrefs(arg_30_0, arg_30_1, arg_30_2)
	if string.nilorempty(arg_30_1) or not arg_30_2 then
		return
	end

	if type(arg_30_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(arg_30_1, arg_30_2)
	else
		GameUtil.playerPrefsSetStringByUserId(arg_30_1, arg_30_2)
	end

	arg_30_0:dispatchEvent(TowerEvent.LocalKeyChange)
end

function var_0_0.getPlayerPrefs(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_2 or ""

	if string.nilorempty(arg_31_1) then
		return var_31_0
	end

	if type(var_31_0) == "number" then
		var_31_0 = GameUtil.playerPrefsGetNumberByUserId(arg_31_1, var_31_0)
	else
		var_31_0 = GameUtil.playerPrefsGetStringByUserId(arg_31_1, var_31_0)
	end

	return var_31_0
end

function var_0_0.isOpen(arg_32_0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower)
end

function var_0_0.isBossTowerOpen(arg_33_0)
	local var_33_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)
	local var_33_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)

	return (var_33_1 and var_33_1.passLayerId or 0) >= tonumber(var_33_0)
end

function var_0_0.isTimeLimitTowerOpen(arg_34_0)
	local var_34_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)
	local var_34_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)

	return (var_34_1 and var_34_1.passLayerId or 0) >= tonumber(var_34_0)
end

function var_0_0.isTowerStoreOpen(arg_35_0)
	local var_35_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.StoreOpen)
	local var_35_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)

	return (var_35_1 and var_35_1.passLayerId or 0) >= tonumber(var_35_0)
end

function var_0_0.checkMopUpReddotShow(arg_36_0)
	local var_36_0 = TowerPermanentModel.instance:checkCanShowMopUpReddot() and 1 or 0
	local var_36_1 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerMopUp,
			value = var_36_0
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_36_1, true)
end

function var_0_0.checkReddotHasNewUpdateTower(arg_37_0)
	local var_37_0 = arg_37_0:isTimeLimitTowerOpen()
	local var_37_1 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_37_2 = TowerEnum.LockKey

	if var_37_1 then
		var_37_2 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, var_37_1.id, var_37_1, TowerEnum.LockKey)
	end

	local var_37_3 = var_37_0 and var_37_1 and (not var_37_2 or var_37_2 == TowerEnum.LockKey)
	local var_37_4 = arg_37_0:isBossTowerOpen()
	local var_37_5 = false
	local var_37_6 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	for iter_37_0, iter_37_1 in ipairs(var_37_6) do
		local var_37_7 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, iter_37_1.towerId, iter_37_1, TowerEnum.LockKey)
		local var_37_8 = TowerEnum.UnlockKey

		if var_37_7 == TowerEnum.LockKey and var_37_8 == TowerEnum.UnlockKey then
			var_37_5 = true

			break
		end
	end

	return var_37_3 or var_37_5 and var_37_4
end

function var_0_0.checkNewUpdateTowerRddotShow(arg_38_0)
	local var_38_0 = arg_38_0:checkReddotHasNewUpdateTower() and 1 or 0
	local var_38_1 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerNewUpdate,
			value = var_38_0
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_38_1, true)
end

function var_0_0.dailyReddotRefresh(arg_39_0)
	arg_39_0:checkMopUpReddotShow()
	arg_39_0:checkNewUpdateTowerRddotShow()
end

function var_0_0._onDailyRefresh(arg_40_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TowerRpc.instance:sendGetTowerInfoRequest(arg_40_0.towerTaskDataRequest, arg_40_0)
	end
end

function var_0_0.towerTaskDataRequest(arg_41_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, arg_41_0.dailyRefresh, arg_41_0)
end

function var_0_0.dailyRefresh(arg_42_0)
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore)
	var_0_0.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function var_0_0.saveNewUpdateTowerReddot(arg_43_0)
	local var_43_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if var_43_0 then
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, var_43_0.id, var_43_0, TowerEnum.UnlockKey)
	end

	local var_43_1 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, iter_43_1.towerId, iter_43_1, TowerEnum.UnlockKey)
	end
end

function var_0_0.checkTowerIsEnd(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = TowerModel.instance:getTowerOpenInfo(arg_44_1, arg_44_2)

	if not var_44_0 or var_44_0.status ~= TowerEnum.TowerStatus.Open then
		local var_44_1 = arg_44_1 == TowerEnum.TowerType.Boss and MessageBoxIdDefine.TowerEnd or MessageBoxIdDefine.TimeLimitTowerEnd

		MessageBoxController.instance:showSystemMsgBox(var_44_1, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)
	end
end

function var_0_0.yesCallback()
	NavigateButtonsView.homeClick()
	var_0_0.instance:openMainView()
end

var_0_0.instance = var_0_0.New()

return var_0_0
