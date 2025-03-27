module("modules.logic.tower.controller.TowerController", package.seeall)

slot0 = class("TowerController", BaseController)

function slot0.onInit(slot0)
	slot0.jumpFlow = nil
end

function slot0.reInit(slot0)
	if slot0.jumpFlow then
		slot0.jumpFlow:onDestroyInternal()
	end

	slot0.jumpFlow = nil
end

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0.onUpdateTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0.onSetTaskList, slot0)
	slot0:registerCallback(TowerEvent.DailyReresh, slot0.dailyReddotRefresh, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.jumpView(slot0, slot1)
	if not ViewMgr.instance:isOpen(ViewName.TowerMainView) then
		slot0.jumpFlow = FlowSequence.New()

		slot0.jumpFlow:addWork(TowerEnterWork.New())
		slot0.jumpFlow:addWork(FunctionWork.New(slot0.realJumpTowerView, slot0, slot1))
		slot0.jumpFlow:registerDoneListener(slot0.flowDone, slot0)
		slot0.jumpFlow:start()
	else
		slot0:realJumpTowerView(slot1)
	end
end

function slot0.realJumpTowerView(slot0, slot1)
	if slot1.towerType == TowerEnum.TowerType.Boss then
		slot0:openBossTowerEpisodeView(slot2, slot1.towerId)
	elseif slot2 == TowerEnum.TowerType.Limited then
		slot0:openTowerTimeLimitLevelView()
	end

	if slot0.jumpFlow then
		slot0.jumpFlow:onDone(true)
	end
end

function slot0.flowDone(slot0, slot1)
	slot0.jumpFlow = nil
end

function slot0.openMainView(slot0, slot1)
	slot0._mainviewParam = slot1

	TowerRpc.instance:sendGetTowerInfoRequest(slot0._openMainView, slot0)
end

function slot0._openMainView(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function (slot0, slot1, slot2)
		if slot1 == 0 then
			ViewMgr.instance:openView(ViewName.TowerMainView, uv0._mainviewParam)
		end
	end)
end

function slot0.openBossTowerEpisodeView(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 then
		return
	end

	slot4 = TowerModel.instance:getEpisodeMoByTowerType(slot1)
	slot5 = TowerModel.instance:getTowerInfoById(slot1, slot2)

	if not TowerModel.instance:getTowerOpenInfo(slot1, slot2) then
		return
	end

	slot7 = slot5 and slot5.passLayerId or 0

	if slot4:getEpisodeConfig(slot2, slot4:getNextEpisodeLayer(slot2, slot7) or slot7) then
		(slot3 or {}).episodeConfig = slot9

		if slot9.openRound > 0 then
			if slot5:isSpLayerOpen(slot9.layerId) then
				ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, slot10)
			else
				slot10.episodeConfig = slot4:getEpisodeConfig(slot2, slot7)

				ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, slot10)
			end
		else
			ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, slot10)
		end
	end
end

function slot0.openAssistBossView(slot0, slot1, slot2, slot3, slot4)
	ViewMgr.instance:openView(ViewName.TowerAssistBossView, {
		bossId = slot1,
		isFromHeroGroup = slot2,
		towerType = slot3,
		towerId = slot4
	})
end

function slot0.enterFight(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.enterFightParam = slot1
	slot2 = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit

	if slot1.towerType == TowerEnum.TowerType.Boss then
		slot2 = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	end

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(slot2, slot0._enterFight, slot0)
end

function slot0._enterFight(slot0)
	if not slot0.enterFightParam then
		return
	end

	TowerModel.instance:setRecordFightParam(slot1.towerType, slot1.towerId, slot1.layerId, slot1.difficulty, slot1.episodeId)
	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2, slot1.speed or 1)
end

function slot0.startFight(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	DungeonModel.instance:SetSendChapterEpisodeId(slot1.chapterId, slot1.episodeId)
	TowerRpc.instance:sendStartTowerBattleRequest(slot1, slot2, slot3)
end

function slot0.restartStage(slot0)
	slot2 = FightModel.instance:getFightParam()

	slot0:startFight({
		fightParam = slot2,
		chapterId = slot2.chapterId,
		episodeId = slot2.episodeId,
		useRecord = slot2.isReplay,
		multiplication = slot2.multiplication
	})
end

function slot0.openTowerMopUpView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.TowerMopUpView, slot1)
end

function slot0.openTowerPermanentView(slot0, slot1)
	TowerPermanentModel.instance:onInit()
	TowerPermanentModel.instance:InitData()

	if slot1 and tabletool.len(slot1) > 0 then
		slot2 = TowerConfig.instance:getPermanentEpisodeCo(slot1.layerId)
		slot3 = slot2.stageId

		TowerPermanentModel.instance:setCurSelectLayer(slot2.index, slot3)
		TowerPermanentModel.instance:setCurSelectStage(slot3)
	end

	TowerPermanentModel.instance:initStageUnFoldState()
	ViewMgr.instance:openView(ViewName.TowerPermanentView, slot1)
end

function slot0.openTowerTaskView(slot0, slot1)
	slot4 = {
		towerType = slot1 and slot1.towerType or TowerEnum.TowerType.Limited,
		towerId = slot1 and slot1.towerId or (TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() and slot2.towerId or 1)
	}

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function ()
		TowerTaskModel.instance:setCurSelectTowerTypeAndId(uv0.towerType, uv0.towerId)
		ViewMgr.instance:openView(ViewName.TowerTaskView, uv1)
	end)
end

function slot0.selectDefaultTowerTask(slot0)
	TowerTaskModel.instance:setCurSelectTowerTypeAndId(TowerEnum.TowerType.Limited, TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() and slot1.towerId or 1)
end

function slot0.onUpdateTaskList(slot0, slot1)
	if TowerTaskModel.instance:updateTaskInfo(slot1.taskInfo) then
		TowerTaskModel.instance:refreshList()
	end

	slot0:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function slot0.onSetTaskList(slot0)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.TowerTask
	})
	TowerTaskModel.instance:setTaskInfoList(TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {})
	TowerTaskModel.instance:refreshList(TowerTaskModel.instance.curSelectTowerType)
	slot0:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function slot0.openTowerTimeLimitLevelView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.TowerTimeLimitLevelView, slot1)
end

function slot0.getRecommendList(slot0, slot1)
	slot2 = {}

	if lua_battle.configDict[slot1] and not string.nilorempty(slot3.monsterGroupIds) then
		for slot8, slot9 in ipairs(string.splitToNumber(slot3.monsterGroupIds, "#")) do
			for slot14, slot15 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot9].monster, "#")) do
				if not tabletool.indexOf(slot2, lua_monster.configDict[slot15].career) then
					table.insert(slot2, slot16)
				end
			end
		end

		slot2 = FightHelper.getAttributeCounter(slot4, false)
	end

	return slot2
end

function slot0.setPlayerPrefs(slot0, slot1, slot2)
	if string.nilorempty(slot1) or not slot2 then
		return
	end

	if type(slot2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(slot1, slot2)
	else
		GameUtil.playerPrefsSetStringByUserId(slot1, slot2)
	end

	slot0:dispatchEvent(TowerEvent.LocalKeyChange)
end

function slot0.getPlayerPrefs(slot0, slot1, slot2)
	slot3 = slot2 or ""

	if string.nilorempty(slot1) then
		return slot3
	end

	return (not (type(slot3) == "number") or GameUtil.playerPrefsGetNumberByUserId(slot1, slot3)) and GameUtil.playerPrefsGetStringByUserId(slot1, slot3)
end

function slot0.isOpen(slot0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower)
end

function slot0.isBossTowerOpen(slot0)
	return tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)) <= (TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0) and slot2.passLayerId or 0)
end

function slot0.isTimeLimitTowerOpen(slot0)
	return tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)) <= (TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0) and slot2.passLayerId or 0)
end

function slot0.checkMopUpReddotShow(slot0)
	RedDotRpc.instance:clientAddRedDotGroupList({
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerMopUp,
			value = TowerPermanentModel.instance:checkCanShowMopUpReddot() and 1 or 0
		}
	}, true)
end

function slot0.checkReddotHasNewUpdateTower(slot0)
	slot1 = slot0:isTimeLimitTowerOpen()
	slot3 = TowerEnum.LockKey

	if TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		slot3 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, slot2.id, slot2, TowerEnum.LockKey)
	end

	slot4 = slot1 and slot2 and (not slot3 or slot3 == TowerEnum.LockKey)
	slot5 = slot0:isBossTowerOpen()
	slot6 = false

	for slot11, slot12 in ipairs(TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)) do
		if TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, slot12.towerId, slot12, TowerEnum.LockKey) == TowerEnum.LockKey and TowerEnum.UnlockKey == TowerEnum.UnlockKey then
			slot6 = true

			break
		end
	end

	return slot4 or slot6 and slot5
end

function slot0.checkNewUpdateTowerRddotShow(slot0)
	RedDotRpc.instance:clientAddRedDotGroupList({
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerNewUpdate,
			value = slot0:checkReddotHasNewUpdateTower() and 1 or 0
		}
	}, true)
end

function slot0.dailyReddotRefresh(slot0)
	slot0:checkMopUpReddotShow()
	slot0:checkNewUpdateTowerRddotShow()
end

function slot0._onDailyRefresh(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TowerRpc.instance:sendGetTowerInfoRequest(slot0.towerTaskDataRequest, slot0)
	end
end

function slot0.towerTaskDataRequest(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, slot0.dailyRefresh, slot0)
end

function slot0.dailyRefresh(slot0)
	uv0.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function slot0.saveNewUpdateTowerReddot(slot0)
	if TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, slot1.id, slot1, TowerEnum.UnlockKey)
	end

	for slot6, slot7 in ipairs(TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, slot7.towerId, slot7, TowerEnum.UnlockKey)
	end
end

function slot0.checkTowerIsEnd(slot0, slot1, slot2)
	if not TowerModel.instance:getTowerOpenInfo(slot1, slot2) or slot3.status ~= TowerEnum.TowerStatus.Open then
		MessageBoxController.instance:showSystemMsgBox(slot1 == TowerEnum.TowerType.Boss and MessageBoxIdDefine.TowerEnd or MessageBoxIdDefine.TimeLimitTowerEnd, MsgBoxEnum.BoxType.Yes, uv0.yesCallback)
	end
end

function slot0.yesCallback()
	NavigateButtonsView.homeClick()
	uv0.instance:openMainView()
end

slot0.instance = slot0.New()

return slot0
