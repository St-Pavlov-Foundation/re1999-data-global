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
			ViewMgr.instance:openView(ViewName.TowerMainView, arg_8_0._mainviewParam)
		end
	end)
end

function var_0_0.openBossTowerEpisodeView(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 or not arg_10_2 then
		return
	end

	local var_10_0 = TowerModel.instance:getEpisodeMoByTowerType(arg_10_1)
	local var_10_1 = TowerModel.instance:getTowerInfoById(arg_10_1, arg_10_2)

	if not TowerModel.instance:getTowerOpenInfo(arg_10_1, arg_10_2) then
		return
	end

	local var_10_2 = var_10_1 and var_10_1.passLayerId or 0
	local var_10_3 = var_10_0:getNextEpisodeLayer(arg_10_2, var_10_2) or var_10_2
	local var_10_4 = var_10_0:getEpisodeConfig(arg_10_2, var_10_3)

	if var_10_4 then
		local var_10_5 = arg_10_3 or {}

		var_10_5.episodeConfig = var_10_4

		if var_10_4.openRound > 0 then
			if var_10_1:isSpLayerOpen(var_10_4.layerId) then
				ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, var_10_5)
			else
				var_10_5.episodeConfig = var_10_0:getEpisodeConfig(arg_10_2, var_10_2)

				if var_10_5.episodeConfig.openRound > 0 then
					ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, var_10_5)
				else
					ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, var_10_5)
				end
			end
		else
			ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, var_10_5)
		end
	end
end

function var_0_0.openAssistBossView(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	ViewMgr.instance:openView(ViewName.TowerAssistBossView, {
		bossId = arg_11_1,
		isFromHeroGroup = arg_11_2,
		towerType = arg_11_3,
		towerId = arg_11_4
	})
end

function var_0_0.enterFight(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	arg_12_0.enterFightParam = arg_12_1

	local var_12_0 = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit

	if arg_12_1.towerType == TowerEnum.TowerType.Boss then
		var_12_0 = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	end

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(var_12_0, arg_12_0._enterFight, arg_12_0)
end

function var_0_0._enterFight(arg_13_0)
	local var_13_0 = arg_13_0.enterFightParam

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0.episodeId

	TowerModel.instance:setRecordFightParam(var_13_0.towerType, var_13_0.towerId, var_13_0.layerId, var_13_0.difficulty, var_13_1)

	local var_13_2 = var_13_0.speed or 1
	local var_13_3 = DungeonConfig.instance:getEpisodeCO(var_13_1)

	DungeonFightController.instance:enterFight(var_13_3.chapterId, var_13_1, var_13_2)
end

function var_0_0.startFight(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_1 then
		return
	end

	DungeonModel.instance:SetSendChapterEpisodeId(arg_14_1.chapterId, arg_14_1.episodeId)
	TowerRpc.instance:sendStartTowerBattleRequest(arg_14_1, arg_14_2, arg_14_3)
end

function var_0_0.restartStage(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = FightModel.instance:getFightParam()

	var_15_0.fightParam = var_15_1
	var_15_0.chapterId = var_15_1.chapterId
	var_15_0.episodeId = var_15_1.episodeId
	var_15_0.useRecord = var_15_1.isReplay
	var_15_0.multiplication = var_15_1.multiplication

	arg_15_0:startFight(var_15_0)
end

function var_0_0.openTowerMopUpView(arg_16_0, arg_16_1)
	ViewMgr.instance:openView(ViewName.TowerMopUpView, arg_16_1)
end

function var_0_0.openTowerPermanentView(arg_17_0, arg_17_1)
	TowerPermanentModel.instance:onInit()
	TowerPermanentModel.instance:InitData()

	if arg_17_1 and tabletool.len(arg_17_1) > 0 then
		local var_17_0 = TowerConfig.instance:getPermanentEpisodeCo(arg_17_1.layerId)
		local var_17_1 = var_17_0.stageId
		local var_17_2 = var_17_0.index

		TowerPermanentModel.instance:setCurSelectLayer(var_17_2, var_17_1)
		TowerPermanentModel.instance:setCurSelectStage(var_17_1)
	end

	TowerPermanentModel.instance:initStageUnFoldState()
	ViewMgr.instance:openView(ViewName.TowerPermanentView, arg_17_1)
end

function var_0_0.openTowerTaskView(arg_18_0, arg_18_1)
	local var_18_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_18_1 = var_18_0 and var_18_0.towerId or 1
	local var_18_2 = {
		towerType = arg_18_1 and arg_18_1.towerType or TowerEnum.TowerType.Limited,
		towerId = arg_18_1 and arg_18_1.towerId or var_18_1
	}

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function()
		TowerTaskModel.instance:setCurSelectTowerTypeAndId(var_18_2.towerType, var_18_2.towerId)
		ViewMgr.instance:openView(ViewName.TowerTaskView, arg_18_1)
	end)
end

function var_0_0.selectDefaultTowerTask(arg_20_0)
	local var_20_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_20_1 = var_20_0 and var_20_0.towerId or 1

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(TowerEnum.TowerType.Limited, var_20_1)
end

function var_0_0.onUpdateTaskList(arg_21_0, arg_21_1)
	if TowerTaskModel.instance:updateTaskInfo(arg_21_1.taskInfo) then
		TowerTaskModel.instance:refreshList()
	end

	arg_21_0:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function var_0_0.onSetTaskList(arg_22_0)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.TowerTask
	})

	local var_22_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(var_22_0)

	local var_22_1 = TowerTaskModel.instance.curSelectTowerType

	TowerTaskModel.instance:refreshList(var_22_1)
	arg_22_0:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function var_0_0.openTowerTimeLimitLevelView(arg_23_0, arg_23_1)
	ViewMgr.instance:openView(ViewName.TowerTimeLimitLevelView, arg_23_1)
end

function var_0_0.getRecommendList(arg_24_0, arg_24_1)
	local var_24_0 = {}
	local var_24_1 = lua_battle.configDict[arg_24_1]

	if var_24_1 and not string.nilorempty(var_24_1.monsterGroupIds) then
		local var_24_2 = string.splitToNumber(var_24_1.monsterGroupIds, "#")

		for iter_24_0, iter_24_1 in ipairs(var_24_2) do
			local var_24_3 = string.splitToNumber(lua_monster_group.configDict[iter_24_1].monster, "#")

			for iter_24_2, iter_24_3 in ipairs(var_24_3) do
				local var_24_4 = lua_monster.configDict[iter_24_3].career

				if not tabletool.indexOf(var_24_0, var_24_4) then
					table.insert(var_24_0, var_24_4)
				end
			end
		end

		var_24_0 = FightHelper.getAttributeCounter(var_24_2, false)
	end

	return var_24_0
end

function var_0_0.setPlayerPrefs(arg_25_0, arg_25_1, arg_25_2)
	if string.nilorempty(arg_25_1) or not arg_25_2 then
		return
	end

	if type(arg_25_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(arg_25_1, arg_25_2)
	else
		GameUtil.playerPrefsSetStringByUserId(arg_25_1, arg_25_2)
	end

	arg_25_0:dispatchEvent(TowerEvent.LocalKeyChange)
end

function var_0_0.getPlayerPrefs(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2 or ""

	if string.nilorempty(arg_26_1) then
		return var_26_0
	end

	if type(var_26_0) == "number" then
		var_26_0 = GameUtil.playerPrefsGetNumberByUserId(arg_26_1, var_26_0)
	else
		var_26_0 = GameUtil.playerPrefsGetStringByUserId(arg_26_1, var_26_0)
	end

	return var_26_0
end

function var_0_0.isOpen(arg_27_0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower)
end

function var_0_0.isBossTowerOpen(arg_28_0)
	local var_28_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)
	local var_28_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)

	return (var_28_1 and var_28_1.passLayerId or 0) >= tonumber(var_28_0)
end

function var_0_0.isTimeLimitTowerOpen(arg_29_0)
	local var_29_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)
	local var_29_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)

	return (var_29_1 and var_29_1.passLayerId or 0) >= tonumber(var_29_0)
end

function var_0_0.checkMopUpReddotShow(arg_30_0)
	local var_30_0 = TowerPermanentModel.instance:checkCanShowMopUpReddot() and 1 or 0
	local var_30_1 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerMopUp,
			value = var_30_0
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_30_1, true)
end

function var_0_0.checkReddotHasNewUpdateTower(arg_31_0)
	local var_31_0 = arg_31_0:isTimeLimitTowerOpen()
	local var_31_1 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local var_31_2 = TowerEnum.LockKey

	if var_31_1 then
		var_31_2 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, var_31_1.id, var_31_1, TowerEnum.LockKey)
	end

	local var_31_3 = var_31_0 and var_31_1 and (not var_31_2 or var_31_2 == TowerEnum.LockKey)
	local var_31_4 = arg_31_0:isBossTowerOpen()
	local var_31_5 = false
	local var_31_6 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	for iter_31_0, iter_31_1 in ipairs(var_31_6) do
		local var_31_7 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, iter_31_1.towerId, iter_31_1, TowerEnum.LockKey)
		local var_31_8 = TowerEnum.UnlockKey

		if var_31_7 == TowerEnum.LockKey and var_31_8 == TowerEnum.UnlockKey then
			var_31_5 = true

			break
		end
	end

	return var_31_3 or var_31_5 and var_31_4
end

function var_0_0.checkNewUpdateTowerRddotShow(arg_32_0)
	local var_32_0 = arg_32_0:checkReddotHasNewUpdateTower() and 1 or 0
	local var_32_1 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerNewUpdate,
			value = var_32_0
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_32_1, true)
end

function var_0_0.dailyReddotRefresh(arg_33_0)
	arg_33_0:checkMopUpReddotShow()
	arg_33_0:checkNewUpdateTowerRddotShow()
end

function var_0_0._onDailyRefresh(arg_34_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TowerRpc.instance:sendGetTowerInfoRequest(arg_34_0.towerTaskDataRequest, arg_34_0)
	end
end

function var_0_0.towerTaskDataRequest(arg_35_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, arg_35_0.dailyRefresh, arg_35_0)
end

function var_0_0.dailyRefresh(arg_36_0)
	var_0_0.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function var_0_0.saveNewUpdateTowerReddot(arg_37_0)
	local var_37_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if var_37_0 then
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, var_37_0.id, var_37_0, TowerEnum.UnlockKey)
	end

	local var_37_1 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)

	for iter_37_0, iter_37_1 in ipairs(var_37_1) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, iter_37_1.towerId, iter_37_1, TowerEnum.UnlockKey)
	end
end

function var_0_0.checkTowerIsEnd(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = TowerModel.instance:getTowerOpenInfo(arg_38_1, arg_38_2)

	if not var_38_0 or var_38_0.status ~= TowerEnum.TowerStatus.Open then
		local var_38_1 = arg_38_1 == TowerEnum.TowerType.Boss and MessageBoxIdDefine.TowerEnd or MessageBoxIdDefine.TimeLimitTowerEnd

		MessageBoxController.instance:showSystemMsgBox(var_38_1, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)
	end
end

function var_0_0.yesCallback()
	NavigateButtonsView.homeClick()
	var_0_0.instance:openMainView()
end

var_0_0.instance = var_0_0.New()

return var_0_0
