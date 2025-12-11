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
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_3_0._trySendTowerDeepRPC, arg_3_0)
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
		TaskEnum.TaskType.Tower,
		TaskEnum.TaskType.TowerPermanentDeep
	}, function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_1 == 0 then
			StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function(arg_10_0, arg_10_1, arg_10_2)
				if arg_10_1 == 0 then
					if TowerPermanentDeepModel.instance:checkDeepLayerUnlock() then
						TowerDeepRpc.instance:sendTowerDeepGetInfoRequest(function(arg_11_0, arg_11_1, arg_11_2)
							if arg_11_1 == 0 then
								ViewMgr.instance:openView(ViewName.TowerMainView, arg_8_0._mainviewParam)
							end
						end)
					else
						ViewMgr.instance:openView(ViewName.TowerMainView, arg_8_0._mainviewParam)
					end
				end
			end)
		end
	end)
end

function var_0_0.openBossTowerEpisodeView(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_1 or not arg_12_2 then
		return
	end

	local var_12_0 = TowerModel.instance:getEpisodeMoByTowerType(arg_12_1)
	local var_12_1 = TowerModel.instance:getTowerInfoById(arg_12_1, arg_12_2)

	if not TowerModel.instance:getTowerOpenInfo(arg_12_1, arg_12_2) then
		return
	end

	local var_12_2 = var_12_1 and var_12_1.passLayerId or 0
	local var_12_3 = var_12_0:getNextEpisodeLayer(arg_12_2, var_12_2) or var_12_2
	local var_12_4 = var_12_0:getEpisodeConfig(arg_12_2, var_12_3)

	if var_12_4 then
		local var_12_5 = arg_12_3 or {}

		var_12_5.episodeConfig = var_12_4

		if var_12_4.openRound > 0 then
			if var_12_1:isSpLayerOpen(var_12_4.layerId) then
				ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, var_12_5)
			else
				var_12_5.episodeConfig = var_12_0:getEpisodeConfig(arg_12_2, var_12_2)

				if var_12_5.episodeConfig.openRound > 0 then
					ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, var_12_5)
				else
					ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, var_12_5)
				end
			end
		else
			ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, var_12_5)
		end

		TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Boss)
	end
end

function var_0_0.openAssistBossView(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = {
		bossId = arg_13_1,
		isFromHeroGroup = arg_13_2,
		towerType = arg_13_3,
		towerId = arg_13_4
	}

	if arg_13_5 then
		var_13_0.otherParam = arg_13_5
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossView, var_13_0)
end

function var_0_0.enterFight(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_0.enterFightParam = arg_14_1

	local var_14_0 = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit

	if arg_14_1.towerType == TowerEnum.TowerType.Boss then
		var_14_0 = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	end

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(var_14_0, arg_14_0._enterFight, arg_14_0)
end

function var_0_0._enterFight(arg_15_0)
	local var_15_0 = arg_15_0.enterFightParam

	if not var_15_0 then
		return
	end

	local var_15_1 = var_15_0.episodeId

	TowerModel.instance:setRecordFightParam(var_15_0.towerType, var_15_0.towerId, var_15_0.layerId, var_15_0.difficulty, var_15_1)

	local var_15_2 = var_15_0.speed or 1
	local var_15_3 = DungeonConfig.instance:getEpisodeCO(var_15_1)

	DungeonFightController.instance:enterFight(var_15_3.chapterId, var_15_1, var_15_2)
end

function var_0_0.startFight(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_1 then
		return
	end

	DungeonModel.instance:SetSendChapterEpisodeId(arg_16_1.chapterId, arg_16_1.episodeId)
	TowerRpc.instance:sendStartTowerBattleRequest(arg_16_1, arg_16_2, arg_16_3)
end

function var_0_0.restartStage(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = FightModel.instance:getFightParam()

	var_17_0.fightParam = var_17_1
	var_17_0.chapterId = var_17_1.chapterId
	var_17_0.episodeId = var_17_1.episodeId
	var_17_0.useRecord = var_17_1.isReplay
	var_17_0.multiplication = var_17_1.multiplication
	var_17_0.isRestart = true

	arg_17_0:startFight(var_17_0)
end

function var_0_0.openTowerMopUpView(arg_18_0, arg_18_1)
	ViewMgr.instance:openView(ViewName.TowerMopUpView, arg_18_1)
end

function var_0_0.openTowerPermanentView(arg_19_0, arg_19_1)
	TowerPermanentModel.instance:onInit()
	TowerPermanentModel.instance:InitData()

	local var_19_0 = false

	if arg_19_1 and tabletool.len(arg_19_1) > 0 then
		local var_19_1 = TowerPermanentDeepModel.instance:checkIsDeepEpisode(arg_19_1.episodeId)

		TowerPermanentDeepModel.instance:setInDeepLayerState(var_19_1)
		TowerPermanentDeepModel.instance:setIsSelectDeepCategory(var_19_1)

		var_19_0 = var_19_1

		if not var_19_0 then
			local var_19_2 = TowerConfig.instance:getPermanentEpisodeCo(arg_19_1.layerId)
			local var_19_3 = var_19_2.stageId
			local var_19_4 = var_19_2.index

			TowerPermanentModel.instance:setCurSelectLayer(var_19_4, var_19_3)
			TowerPermanentModel.instance:setCurSelectStage(var_19_3)
		end
	else
		local var_19_5 = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()
		local var_19_6 = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish()
		local var_19_7 = var_19_5 and var_19_6

		var_19_0 = var_19_7

		TowerPermanentDeepModel.instance:setInDeepLayerState(var_19_7)
		TowerPermanentDeepModel.instance:setIsSelectDeepCategory(var_19_7)
	end

	TowerPermanentModel.instance:initStageUnFoldState()

	if var_19_0 then
		TowerDeepRpc.instance:sendTowerDeepGetInfoRequest(function()
			ViewMgr.instance:openView(ViewName.TowerPermanentView, arg_19_1)
		end, arg_19_0)
	else
		ViewMgr.instance:openView(ViewName.TowerPermanentView, arg_19_1)
	end

	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Normal)
end

function var_0_0.openTowerStoreView(arg_21_0)
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function()
		local var_22_0 = {}

		ViewMgr.instance:openView(ViewName.TowerStoreView, var_22_0)
	end, arg_21_0)
end

function var_0_0.openTowerHeroTrialView(arg_23_0, arg_23_1)
	ViewMgr.instance:openView(ViewName.TowerHeroTrialView, arg_23_1)
end

function var_0_0.openTowerBossTeachView(arg_24_0, arg_24_1)
	ViewMgr.instance:openView(ViewName.TowerBossTeachView, arg_24_1)
end

function var_0_0.openTowerTaskView(arg_25_0, arg_25_1)
	local var_25_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if not var_25_0 or not var_25_0.towerId then
		local var_25_1 = 1
	end

	local var_25_2 = arg_25_1 or {}

	var_25_2.towerType = arg_25_1 and arg_25_1.towerType
	var_25_2.towerId = arg_25_1 and arg_25_1.towerId

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function()
		ViewMgr.instance:openView(ViewName.TowerTaskView, var_25_2)
	end)
end

function var_0_0.selectDefaultTowerTask(arg_27_0)
	local var_27_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_27_1 = var_27_0 and var_27_0.towerId or 1

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(TowerEnum.TowerType.Limited, var_27_1)
end

function var_0_0.onUpdateTaskList(arg_28_0, arg_28_1)
	if TowerTaskModel.instance:updateTaskInfo(arg_28_1.taskInfo) then
		TowerTaskModel.instance:refreshList()
	end

	if TowerDeepTaskModel.instance:updateTaskInfo(arg_28_1.taskInfo) then
		TowerDeepTaskModel.instance:refreshList()
	end

	arg_28_0:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function var_0_0.onSetTaskList(arg_29_0)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.TowerTask
	})

	local var_29_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(var_29_0)
	TowerDeepTaskModel.instance:setTaskInfoList()

	local var_29_1 = TowerTaskModel.instance.curSelectTowerType

	TowerTaskModel.instance:refreshList(var_29_1)
	TowerDeepTaskModel.instance:refreshList()
	arg_29_0:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function var_0_0.openTowerTimeLimitLevelView(arg_30_0, arg_30_1)
	ViewMgr.instance:openView(ViewName.TowerTimeLimitLevelView, arg_30_1)
	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Limited)
end

function var_0_0.getRecommendList(arg_31_0, arg_31_1)
	local var_31_0 = {}
	local var_31_1 = lua_battle.configDict[arg_31_1]

	if var_31_1 and not string.nilorempty(var_31_1.monsterGroupIds) then
		local var_31_2 = string.splitToNumber(var_31_1.monsterGroupIds, "#")

		for iter_31_0, iter_31_1 in ipairs(var_31_2) do
			local var_31_3 = string.splitToNumber(lua_monster_group.configDict[iter_31_1].monster, "#")

			for iter_31_2, iter_31_3 in ipairs(var_31_3) do
				local var_31_4 = lua_monster.configDict[iter_31_3].career

				if not tabletool.indexOf(var_31_0, var_31_4) then
					table.insert(var_31_0, var_31_4)
				end
			end
		end

		var_31_0 = FightHelper.getAttributeCounter(var_31_2, false)
	end

	return var_31_0
end

function var_0_0.setPlayerPrefs(arg_32_0, arg_32_1, arg_32_2)
	if string.nilorempty(arg_32_1) or not arg_32_2 then
		return
	end

	if type(arg_32_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(arg_32_1, arg_32_2)
	else
		GameUtil.playerPrefsSetStringByUserId(arg_32_1, arg_32_2)
	end

	arg_32_0:dispatchEvent(TowerEvent.LocalKeyChange)
end

function var_0_0.getPlayerPrefs(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2 or ""

	if string.nilorempty(arg_33_1) then
		return var_33_0
	end

	if type(var_33_0) == "number" then
		var_33_0 = GameUtil.playerPrefsGetNumberByUserId(arg_33_1, var_33_0)
	else
		var_33_0 = GameUtil.playerPrefsGetStringByUserId(arg_33_1, var_33_0)
	end

	return var_33_0
end

function var_0_0.isOpen(arg_34_0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower)
end

function var_0_0.isBossTowerOpen(arg_35_0)
	local var_35_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)
	local var_35_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)

	return (var_35_1 and var_35_1.passLayerId or 0) >= tonumber(var_35_0)
end

function var_0_0.isTimeLimitTowerOpen(arg_36_0)
	local var_36_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)
	local var_36_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)

	return (var_36_1 and var_36_1.passLayerId or 0) >= tonumber(var_36_0)
end

function var_0_0.isTowerStoreOpen(arg_37_0)
	local var_37_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.StoreOpen)
	local var_37_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)

	return (var_37_1 and var_37_1.passLayerId or 0) >= tonumber(var_37_0)
end

function var_0_0.checkMopUpReddotShow(arg_38_0)
	local var_38_0 = TowerPermanentModel.instance:checkCanShowMopUpReddot() and 1 or 0
	local var_38_1 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerMopUp,
			value = var_38_0
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_38_1, true)
end

function var_0_0.checkReddotHasNewUpdateTower(arg_39_0)
	local var_39_0 = arg_39_0:isTimeLimitTowerOpen()
	local var_39_1 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_39_2 = TowerEnum.LockKey

	if var_39_1 then
		var_39_2 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, var_39_1.id, var_39_1, TowerEnum.LockKey)
	end

	local var_39_3 = var_39_0 and var_39_1 and (not var_39_2 or var_39_2 == TowerEnum.LockKey)
	local var_39_4 = arg_39_0:isBossTowerOpen()
	local var_39_5 = false
	local var_39_6 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	for iter_39_0, iter_39_1 in ipairs(var_39_6) do
		local var_39_7 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, iter_39_1.towerId, iter_39_1, TowerEnum.LockKey)
		local var_39_8 = TowerEnum.UnlockKey

		if var_39_7 == TowerEnum.LockKey and var_39_8 == TowerEnum.UnlockKey then
			var_39_5 = true

			break
		end
	end

	return var_39_3 or var_39_5 and var_39_4
end

function var_0_0.checkNewUpdateTowerRddotShow(arg_40_0)
	local var_40_0 = arg_40_0:checkReddotHasNewUpdateTower() and 1 or 0
	local var_40_1 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerNewUpdate,
			value = var_40_0
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_40_1, true)
end

function var_0_0.dailyReddotRefresh(arg_41_0)
	arg_41_0:checkMopUpReddotShow()
	arg_41_0:checkNewUpdateTowerRddotShow()
end

function var_0_0._onDailyRefresh(arg_42_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TowerRpc.instance:sendGetTowerInfoRequest(arg_42_0.towerTaskDataRequest, arg_42_0)
	end
end

function var_0_0.towerTaskDataRequest(arg_43_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, arg_43_0.dailyRefresh, arg_43_0)
end

function var_0_0.dailyRefresh(arg_44_0)
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore)
	var_0_0.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function var_0_0.saveNewUpdateTowerReddot(arg_45_0)
	local var_45_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if var_45_0 then
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, var_45_0.id, var_45_0, TowerEnum.UnlockKey)
	end

	local var_45_1 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, iter_45_1.towerId, iter_45_1, TowerEnum.UnlockKey)
	end
end

function var_0_0.checkTowerIsEnd(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = TowerModel.instance:getTowerOpenInfo(arg_46_1, arg_46_2)

	if not var_46_0 or var_46_0.status ~= TowerEnum.TowerStatus.Open then
		local var_46_1 = arg_46_1 == TowerEnum.TowerType.Boss and MessageBoxIdDefine.TowerEnd or MessageBoxIdDefine.TimeLimitTowerEnd

		MessageBoxController.instance:showSystemMsgBox(var_46_1, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)
	end
end

function var_0_0.yesCallback()
	NavigateButtonsView.homeClick()
	var_0_0.instance:openMainView()
end

function var_0_0.openTowerDeepTeamSaveView(arg_48_0, arg_48_1)
	ViewMgr.instance:openView(ViewName.TowerDeepTeamSaveView, arg_48_1)
end

function var_0_0.openTowerDeepTaskView(arg_49_0, arg_49_1)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerPermanentDeep
	}, function()
		ViewMgr.instance:openView(ViewName.TowerDeepTaskView, arg_49_1)
	end)
end

function var_0_0.endFightEnterTowerDeepHeroGroup(arg_51_0, arg_51_1)
	local var_51_0 = DungeonConfig.instance:getEpisodeBattleId(arg_51_1.id)

	HeroGroupModel.instance:setParam(var_51_0, arg_51_1.id)

	local var_51_1 = GameSceneMgr.instance:getPreSceneType()
	local var_51_2 = GameSceneMgr.instance:getPreSceneId()
	local var_51_3 = GameSceneMgr.instance:getPreLevelId()

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	GameSceneMgr.instance:setPrevScene(var_51_1, var_51_2, var_51_3)
	TowerPermanentDeepModel.instance:setIsFightFailNotEndState(true)
	TowerPermanentDeepModel.instance:setInDeepLayerState(true)
	DungeonFightController.instance:enterFight(arg_51_1.chapterId, arg_51_1.id, DungeonModel.instance.curSelectTicketId)
end

function var_0_0._trySendTowerDeepRPC(arg_52_0)
	if TowerPermanentDeepModel.instance:checkDeepLayerUnlock() then
		TowerDeepRpc.instance:sendTowerDeepGetInfoRequest()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
