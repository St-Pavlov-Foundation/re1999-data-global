module("modules.logic.fight.controller.FightController", package.seeall)

local var_0_0 = class("FightController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayEnterFightScene, arg_2_0)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightSystem.instance:dispose()
	end

	arg_2_0._guideContinueEvent = nil
end

function var_0_0.addConstEvents(arg_3_0)
	var_0_0.instance:registerCallback(FightEvent.RespBeginFight, arg_3_0._respBeginFight, arg_3_0)
	var_0_0.instance:registerCallback(FightEvent.PushEndFight, arg_3_0._pushEndFight, arg_3_0)
	var_0_0.instance:registerCallback(FightEvent.OnStartSequenceFinish, arg_3_0._onStartSequenceFinish, arg_3_0)
	var_0_0.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_3_0._onRoundSequenceFinish, arg_3_0)
	var_0_0.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_3_0.onClothSkillRoundSequenceFinish, arg_3_0)
	var_0_0.instance:registerCallback(FightEvent.OnEndSequenceFinish, arg_3_0._onEndSequenceFinish, arg_3_0)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, arg_3_0._onFightSceneStart, arg_3_0)

	arg_3_0._fightEventExtend = FightEventExtend.New()

	arg_3_0._fightEventExtend:addConstEvents()
end

function var_0_0.sendTestFight(arg_4_0, arg_4_1, arg_4_2)
	logNormal("Enter Test Fight, param = \n" .. cjson.encode(arg_4_1))
	FightModel.instance:setFightParam(arg_4_1)

	arg_4_2 = arg_4_2 or FightEnum.FightActType.Normal

	FightRpc.instance:sendTestFightRequest(arg_4_1, arg_4_1.monsterGroupIds, arg_4_2)
end

function var_0_0.sendTestFightId(arg_5_0, arg_5_1)
	logNormal("Enter Test FightId, param = \n" .. cjson.encode(arg_5_1))
	FightModel.instance:setFightParam(arg_5_1)

	arg_5_1.fightActType = arg_5_1.fightActType or FightEnum.FightActType.Normal

	FightRpc.instance:sendTestFightIdRequest(arg_5_1)
end

function var_0_0.enterFightScene(arg_6_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		if GameSceneMgr.instance:isLoading() then
			logNormal("正在进入战斗，无法重复进入战斗")
		else
			logNormal("已经在战斗中，无法重复进入战斗")
		end

		return
	end

	local var_6_0 = FightModel.instance:getFightParam()

	if var_6_0 and var_6_0.sceneId then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView2)
		GameSceneMgr.instance:showLoading(SceneType.Fight)
		TaskDispatcher.runDelay(arg_6_0._delayEnterFightScene, arg_6_0, 0.5)
	else
		logError("FightParam.sceneId not exist")
	end
end

function var_0_0._delayEnterFightScene(arg_7_0)
	local var_7_0 = FightModel.instance:getFightParam()

	if var_7_0 and var_7_0.sceneId then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterFbFight)
		PlayerModel.instance:getAndResetPlayerLevelUp()
		FightModel.instance:checkEnterUseFreeLimit()
		GameSceneMgr.instance:startScene(SceneType.Fight, var_7_0.sceneId, var_7_0.levelId)
	else
		GameSceneMgr.instance:hideLoading(SceneType.Fight)
		logError("FightParam.sceneId not exist")
	end
end

function var_0_0.exitFightScene(arg_8_0)
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Checkpointend)

	if DungeonJumpGameController.instance:checkIsJumpGameBattle() then
		DungeonJumpGameController.instance:returnToJumpGameView()

		return
	end

	if VersionActivity2_8DungeonBossBattleController.instance:checkIsBossBattle() then
		VersionActivity2_8DungeonBossBattleController.instance:enterBossView()

		return
	end

	if ToughBattleController.instance:checkIsToughBattle() then
		ToughBattleController.instance:enterToughBattle()

		return
	end

	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity()

		return
	end

	local var_8_0 = JumpModel.instance:getRecordFarmItem()

	if var_8_0 then
		if var_8_0.canBackSource and (var_8_0.special or var_8_0.openedViewNameList and #var_8_0.openedViewNameList > 0) then
			arg_8_0:handleJump()

			return
		end

		if var_8_0.checkFunc and var_8_0.checkFunc(var_8_0.checkFuncObj) then
			JumpModel.instance:clearRecordFarmItem()
		end
	end

	local var_8_1 = DungeonModel.instance.curSendEpisodeId
	local var_8_2 = DungeonConfig.instance:getEpisodeCO(var_8_1)

	if var_8_2 then
		if var_8_2.type == DungeonEnum.EpisodeType.Explore then
			ExploreController.instance:enterExploreScene()

			return
		end

		if var_8_2.type == DungeonEnum.EpisodeType.Survival then
			SurvivalMapHelper.instance:tryStartFlow("")

			SurvivalMapModel.instance.isFightEnter = true

			SurvivalController.instance:enterSurvivalMap()

			return
		end

		if var_8_2.type == DungeonEnum.EpisodeType.Shelter then
			SurvivalController.instance:enterShelterMap(true)

			return
		end

		if var_8_2.type == DungeonEnum.EpisodeType.Rouge then
			RougeMapController.instance:onExistFight()

			return
		end

		if var_8_2.chapterId == DungeonEnum.ChapterId.BossStory then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.VersionActivity2_8BossStoryLoadingView)
		end
	end

	local var_8_3 = FightResultModel.instance.episodeId
	local var_8_4 = DungeonConfig.instance:getEpisodeCO(var_8_3)
	local var_8_5 = arg_8_0:isReplayMode(var_8_3)
	local var_8_6 = GameSceneMgr.instance:getPreSceneType()
	local var_8_7 = GameSceneMgr.instance:getPreSceneId()
	local var_8_8 = GameSceneMgr.instance:getPreLevelId()

	if var_8_5 then
		GameSceneMgr.instance:closeScene(nil, nil, nil, true)
		GameSceneMgr.instance:setPrevScene(var_8_6, var_8_7, var_8_8)
		DungeonFightController.instance:enterFight(var_8_4.chapterId, var_8_3, DungeonModel.instance.curSelectTicketId)
	else
		GameSceneMgr.instance:startScene(var_8_6, var_8_7, var_8_8)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(var_8_3, true)
		end
	end
end

function var_0_0.isReplayMode(arg_9_0, arg_9_1)
	local var_9_0 = false
	local var_9_1 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if not string.nilorempty(var_9_1) then
		var_9_0 = cjson.decode(var_9_1)[tostring(arg_9_1)]
	end

	return var_9_0
end

function var_0_0.enterVersionActivityDungeon(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = DungeonModel.instance.curSendChapterId
	local var_10_1 = DungeonModel.instance.curSendEpisodeId
	local var_10_2 = arg_10_0:isReplayMode(var_10_1)
	local var_10_3 = DungeonConfig.instance:getEpisodeCO(var_10_1)

	if not arg_10_2 and var_10_2 then
		local var_10_4 = JumpModel.instance:getRecordFarmItem()

		if FightSuccView.checkRecordFarmItem(var_10_1, var_10_4) then
			if not (ItemModel.instance:getItemQuantity(var_10_4.type, var_10_4.id) >= var_10_4.quantity) then
				GameSceneMgr.instance:closeScene(nil, nil, nil, true)
				DungeonFightController.instance:enterFight(var_10_3.chapterId, var_10_1, DungeonModel.instance.curSelectTicketId)

				return
			end
		else
			GameSceneMgr.instance:closeScene(nil, nil, nil, true)
			DungeonFightController.instance:enterFight(var_10_3.chapterId, var_10_1, DungeonModel.instance.curSelectTicketId)

			return
		end
	end

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_10_1)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()

		if var_10_3.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)

			DungeonMapModel.instance.lastElementBattleId = var_10_1
			var_10_1 = DungeonConfig.instance:getElementFightEpisodeToNormalEpisodeId(var_10_3)

			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, var_10_1)
		elseif DungeonModel.instance.curSendEpisodePass then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, var_10_1)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(var_10_0, var_10_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					episodeId = var_10_1
				})
			end)
		end
	end)
end

function var_0_0.enterVersionActivityDogView(arg_13_0, arg_13_1, arg_13_2)
	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_13_1)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
		Activity109ChessController.instance:openGameAfterFight(arg_13_2)
	end)
end

function var_0_0.enterVersionActivity1_2YaXianView(arg_15_0, arg_15_1, arg_15_2)
	return
end

function var_0_0.handleJump(arg_16_0)
	local var_16_0 = JumpModel.instance:getRecordFarmItem()

	JumpModel.instance:clearRecordFarmItem()

	var_16_0.canBackSource = nil
	DungeonModel.instance.curSendEpisodeId = nil

	local var_16_1 = SceneType.Main

	if var_16_0.sceneType == SceneType.Main then
		var_16_1 = SceneType.Main

		MainController.instance:enterMainScene()
	elseif var_16_0.sceneType == SceneType.Room then
		var_16_1 = SceneType.Room

		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, true)
	elseif var_16_0.sceneType == SceneType.Fight then
		if not arg_16_0._fightViewDict then
			arg_16_0._fightViewDict = {
				[ViewName.HeroGroupFightView] = true,
				[ViewName.V1a2_HeroGroupFightView] = true,
				[ViewName.V1a3_HeroGroupFightView] = true,
				[ViewName.V1a5_HeroGroupFightView] = true,
				[ViewName.V1a6_HeroGroupFightView] = true,
				[ViewName.HeroGroupFightWeekwalkView] = true,
				[ViewName.HeroGroupFightWeekwalk_2View] = true,
				[ViewName.Season123HeroGroupFightView] = true,
				[ViewName.Season166HeroGroupFightView] = true,
				[ViewName.HeroGroupEditView] = true,
				[ViewName.VersionActivity_1_2_HeroGroupEditView] = true,
				[ViewName.Season123HeroGroupEditView] = true,
				[ViewName.Season166HeroGroupEditView] = true,
				[ViewName.RougeHeroGroupEditView] = true,
				[ViewName.SurvivalHeroGroupFightView] = true,
				[ViewName.ShelterHeroGroupFightView] = true,
				[ViewName.SurvivalHeroGroupEditView] = true,
				[ViewName.OdysseyHeroGroupView] = true,
				[ViewName.OdysseyHeroGroupEditView] = true
			}
		end

		if var_16_0.openedViewNameList then
			for iter_16_0 = #var_16_0.openedViewNameList, 1, -1 do
				local var_16_2 = var_16_0.openedViewNameList[iter_16_0]

				if arg_16_0._fightViewDict[var_16_2.viewName] then
					table.remove(var_16_0.openedViewNameList, iter_16_0)
				end
			end
		end

		var_16_1 = SceneType.Main

		MainController.instance:enterMainScene()
	else
		var_16_1 = SceneType.Main

		MainController.instance:enterMainScene()
		logWarn("not handle recordFarmItem.sceneType : " .. tostring(var_16_0.sceneType))
	end

	SceneHelper.instance:waitSceneDone(var_16_1, function()
		if var_16_0.jumpId then
			GameFacade.jump(var_16_0.jumpId)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_16_0.openedViewNameList[#var_16_0.openedViewNameList].viewName)

			if RoomController.instance:isRoomScene() then
				RoomController.instance:popUpSourceView(var_16_0.openedViewNameList)

				for iter_17_0, iter_17_1 in ipairs(var_16_0.openedViewNameList) do
					if iter_17_1.viewName ~= ViewName.RoomInitBuildingView and iter_17_1.viewName ~= ViewName.RoomFormulaView then
						ViewMgr.instance:openView(iter_17_1.viewName, iter_17_1.viewParam)
					end
				end
			else
				for iter_17_2, iter_17_3 in ipairs(var_16_0.openedViewNameList) do
					if iter_17_3.viewName == ViewName.RoomInitBuildingView or iter_17_3.viewName == ViewName.RoomFormulaView then
						RoomController.instance:popUpSourceView(var_16_0.openedViewNameList)
					elseif iter_17_3.viewName == ViewName.BackpackView then
						BackpackController.instance:enterItemBackpack()
					else
						ViewMgr.instance:openView(iter_17_3.viewName, iter_17_3.viewParam)
					end
				end
			end
		end
	end)
end

function var_0_0._respBeginFight(arg_18_0)
	arg_18_0:enterFightScene()
end

function var_0_0._pushEndFight(arg_19_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and not GameSceneMgr.instance:isLoading() then
		FightSystem.instance:endFight()
	end
end

function var_0_0._onFightSceneStart(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 == 1 then
		if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
			return
		end

		if FightModel.instance.needFightReconnect then
			FightSystem.instance:reconnectFight()
		else
			FightSystem.instance:startFight()
		end
	end
end

function var_0_0._onStartSequenceFinish(arg_21_0)
	arg_21_0:_recordFreeTicket()
	arg_21_0:beginWave()
end

function var_0_0.setCurStage(arg_22_0, arg_22_1)
	FightModel.instance:setCurStage(arg_22_1)
	logNormal("当前阶段：" .. FightModel.instance:getCurStageDesc())
	var_0_0.instance:dispatchEvent(FightEvent.OnStageChange, arg_22_1)
end

function var_0_0.beginWave(arg_23_0)
	var_0_0.instance:dispatchEvent(FightEvent.OnBeginWave)
end

function var_0_0._onRoundSequenceFinish(arg_24_0)
	if FightModel.instance:isFinish() then
		logNormal("回合结束，战斗结束")

		if FightDataHelper.fieldMgr:isDouQuQu() then
			return
		end

		FightRpc.instance:sendEndFightRequest(false)
	end
end

function var_0_0.onClothSkillRoundSequenceFinish(arg_25_0)
	if FightModel.instance:isFinish() then
		logNormal("回合结束，战斗结束")

		if FightDataHelper.fieldMgr:isDouQuQu() then
			return
		end

		FightRpc.instance:sendEndFightRequest(false)
	end
end

function var_0_0._onEndSequenceFinish(arg_26_0)
	return
end

function var_0_0.GuideFlowPauseAndContinue(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6, arg_27_7, arg_27_8)
	local var_27_0 = FightModel.instance:getGuideParam()

	var_0_0.instance:dispatchEvent(arg_27_2, var_27_0, arg_27_6, arg_27_7, arg_27_8)

	if var_27_0[arg_27_1] then
		var_27_0[arg_27_1] = false

		if arg_27_0._guideContinueEvent then
			logError("guiding event: " .. arg_27_0._guideContinueEvent .. ", try to replase with: " .. arg_27_3)
			var_0_0.instance:unregisterCallback(arg_27_0._guideContinueEvent, arg_27_0._continueCallback, arg_27_0)
		end

		arg_27_0._guideContinueEvent = arg_27_3
		arg_27_0._guideCallback = arg_27_4
		arg_27_0._guideCallbackObj = arg_27_5

		var_0_0.instance:registerCallback(arg_27_0._guideContinueEvent, arg_27_0._continueCallback, arg_27_0)

		return true
	else
		arg_27_4(arg_27_5)

		if arg_27_0._guideContinueEvent == arg_27_2 then
			var_0_0.instance:unregisterCallback(arg_27_0._guideContinueEvent, arg_27_0._continueCallback, arg_27_0)

			arg_27_0._guideContinueEvent = nil
			arg_27_0._guideCallback = nil
			arg_27_0._guideCallbackObj = nil
		end
	end

	return false
end

function var_0_0._continueCallback(arg_28_0)
	if arg_28_0._guideContinueEvent then
		var_0_0.instance:unregisterCallback(arg_28_0._guideContinueEvent, arg_28_0._continueCallback, arg_28_0)

		local var_28_0 = arg_28_0._guideCallback
		local var_28_1 = arg_28_0._guideCallbackObj

		arg_28_0._guideContinueEvent = nil
		arg_28_0._guideCallback = nil
		arg_28_0._guideCallbackObj = nil

		var_28_0(var_28_1)
	end
end

function var_0_0.setNewBieFightParamByEpisodeId(arg_29_0, arg_29_1)
	local var_29_0 = FightParam.New()

	var_29_0:setEpisodeId(arg_29_1)
	FightModel.instance:setFightParam(var_29_0)

	return var_29_0
end

function var_0_0.setFightParamByEpisodeAndBattle(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = FightParam.New()

	var_30_0:setEpisodeAndBattle(arg_30_1, arg_30_2)
	FightModel.instance:setFightParam(var_30_0)

	return var_30_0
end

function var_0_0.setFightParamByEpisodeId(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0 = FightParam.New()

	var_31_0:setEpisodeId(arg_31_1, arg_31_4)

	var_31_0.isReplay = arg_31_2
	var_31_0.multiplication = arg_31_3

	FightModel.instance:setFightParam(var_31_0)

	return var_31_0
end

function var_0_0.setFightParamByEpisodeBattleId(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = FightParam.New()

	var_32_0:setEpisodeId(arg_32_1, arg_32_2)
	FightModel.instance:setFightParam(var_32_0)

	return var_32_0
end

function var_0_0.setFightParamByBattleId(arg_33_0, arg_33_1)
	local var_33_0 = FightParam.New()

	var_33_0:setBattleId(arg_33_1)
	FightModel.instance:setFightParam(var_33_0)

	return var_33_0
end

function var_0_0.setFightHeroGroup(arg_34_0)
	local var_34_0 = FightModel.instance:getFightParam()

	if not var_34_0 then
		return false
	end

	local var_34_1 = HeroGroupModel.instance:getCurGroupMO()

	if not var_34_1 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_34_2, var_34_3 = var_34_1:getMainList()
	local var_34_4, var_34_5 = var_34_1:getSubList()

	if (not var_34_1.aidDict or #var_34_1.aidDict <= 0) and var_34_3 + var_34_5 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_34_6 = var_34_0.battleId
	local var_34_7 = var_34_6 and lua_battle.configDict[var_34_6]
	local var_34_8 = var_34_7 and var_34_7.noClothSkill == 0 and var_34_1.clothId or 0
	local var_34_9 = SeasonFightHandler.getSeasonEquips(var_34_1, var_34_0)

	var_34_0:setMySide(var_34_8, var_34_2, var_34_1:getSubList(), var_34_1:getAllHeroEquips(), var_34_9, nil, nil, var_34_1:getAssistBossId())

	return true
end

function var_0_0.setFightHeroSingleGroup(arg_35_0)
	local var_35_0 = FightModel.instance:getFightParam()

	if not var_35_0 then
		return false
	end

	local var_35_1 = HeroGroupModel.instance:getCurGroupMO()

	if not var_35_1 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_35_2, var_35_3 = var_35_1:getMainList()
	local var_35_4, var_35_5 = var_35_1:getSubList()
	local var_35_6 = HeroSingleGroupModel.instance:getList()
	local var_35_7 = var_35_1:getAllHeroEquips()
	local var_35_8 = var_35_1:getAssistBossId()

	for iter_35_0 = 1, #var_35_2 do
		if var_35_2[iter_35_0] ~= var_35_6[iter_35_0].heroUid then
			var_35_2[iter_35_0] = "0"
			var_35_3 = var_35_3 - 1

			if var_35_7[iter_35_0] then
				var_35_7[iter_35_0].heroUid = "0"
			end
		end
	end

	for iter_35_1 = #var_35_2 + 1, math.min(#var_35_2 + #var_35_4, #var_35_6) do
		if var_35_4[iter_35_1 - #var_35_2] ~= var_35_6[iter_35_1].heroUid then
			var_35_4[iter_35_1 - #var_35_2] = "0"
			var_35_5 = var_35_5 - 1

			if var_35_7[iter_35_1] then
				var_35_7[iter_35_1].heroUid = "0"
			end
		end
	end

	if (not var_35_1.aidDict or #var_35_1.aidDict <= 0) and var_35_3 + var_35_5 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_35_9 = SeasonFightHandler.getSeasonEquips(var_35_1, var_35_0)
	local var_35_10 = var_35_0.battleId
	local var_35_11 = var_35_10 and lua_battle.configDict[var_35_10]
	local var_35_12 = var_35_11 and var_35_11.noClothSkill == 0 and var_35_1.clothId or 0

	var_35_0:setMySide(var_35_12, var_35_2, var_35_4, var_35_7, var_35_9, nil, nil, var_35_8)

	return true
end

function var_0_0.openRoundView(arg_36_0)
	if arg_36_0:canOpenRoundView() then
		ViewMgr.instance:openView(ViewName.FightRoundView)
	end
end

function var_0_0.canOpenRoundView(arg_37_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		return false
	end

	if not FightModel.instance:getFightParam().episodeId then
		return false
	end

	return not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRoundView)
end

function var_0_0.getPlayerPrefKeyAuto(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return
	end

	local var_38_0 = PlayerPrefsKey.FightAutoEpsodeIds .. PlayerModel.instance:getPlayinfo().userId
	local var_38_1 = PlayerPrefsHelper.getString(var_38_0, "")

	if string.nilorempty(var_38_1) then
		return false
	end

	local var_38_2 = string.splitToNumber(var_38_1, "#")

	for iter_38_0, iter_38_1 in ipairs(var_38_2) do
		if iter_38_1 == arg_38_1 then
			return true
		end
	end

	return false
end

function var_0_0.setPlayerPrefKeyAuto(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_1 then
		return
	end

	local var_39_0 = PlayerPrefsKey.FightAutoEpsodeIds .. PlayerModel.instance:getPlayinfo().userId
	local var_39_1 = PlayerPrefsHelper.getString(var_39_0, "")

	if string.nilorempty(var_39_1) then
		if arg_39_2 then
			var_39_1 = tostring(arg_39_1)

			PlayerPrefsHelper.setString(var_39_0, var_39_1)
		end

		return
	end

	local var_39_2 = false
	local var_39_3 = string.splitToNumber(var_39_1, "#")

	for iter_39_0, iter_39_1 in ipairs(var_39_3) do
		if iter_39_1 == arg_39_1 then
			var_39_2 = true
		end
	end

	if not var_39_2 and arg_39_2 then
		local var_39_4 = table.concat({
			var_39_1,
			"#",
			tostring(arg_39_1)
		})

		PlayerPrefsHelper.setString(var_39_0, var_39_4)

		return
	end

	if var_39_2 and not arg_39_2 then
		local var_39_5 = {}

		for iter_39_2, iter_39_3 in ipairs(var_39_3) do
			if iter_39_3 ~= arg_39_1 then
				table.insert(var_39_5, iter_39_3)
			end
		end

		local var_39_6 = table.concat(var_39_5, "#")

		PlayerPrefsHelper.setString(var_39_0, var_39_6)

		return
	end
end

function var_0_0.checkFightQuitTipViewClose(arg_40_0)
	if ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		ViewMgr.instance:closeView(ViewName.FightQuitTipView, nil)
	end

	SeasonFightHandler.closeSeasonFightRuleTipView()
end

function var_0_0.openFightSpecialTipView(arg_41_0, arg_41_1)
	if not arg_41_1 then
		local var_41_0 = FightModel.instance:getFightParam()

		if var_41_0 then
			local var_41_1 = var_41_0.episodeId
			local var_41_2 = DungeonConfig.instance:getEpisodeCO(var_41_1)
			local var_41_3 = var_41_2 and var_41_2.type

			if SeasonFightHandler.openSeasonFightRuleTipView(var_41_3) then
				return
			end
		end
	end

	ViewMgr.instance:openView(ViewName.FightSpecialTipView)
end

function var_0_0.openFightTechniqueView(arg_42_0)
	ViewMgr.instance:openView(ViewName.FightTechniqueView)
end

function var_0_0._recordFreeTicket(arg_43_0)
	local var_43_0 = FightModel.instance:getFightParam()
	local var_43_1 = var_43_0 and var_43_0.episodeId
	local var_43_2 = var_43_1 and lua_episode.configDict[var_43_1]

	if not var_43_2 then
		return
	end

	local var_43_3 = DungeonConfig.instance:getChapterCO(var_43_2.chapterId)

	arg_43_0.TEMP_equip_chapter_free_count = nil

	if var_43_3.type == DungeonEnum.ChapterType.Equip then
		arg_43_0.TEMP_equip_chapter_free_count = DungeonModel.instance:getChapterRemainingNum(var_43_3.type)
	end
end

function var_0_0.onResultViewClose()
	local var_44_0 = {}

	var_0_0.instance:dispatchEvent(FightEvent.OnBreakResultViewClose, var_44_0)

	if var_44_0.isBreak then
		return
	end

	var_0_0.instance:dispatchEvent(FightEvent.OnResultViewClose)
end

function var_0_0.errorAndEnterMainScene(arg_45_0)
	DungeonModel.instance.curSendEpisodeId = nil

	arg_45_0:clearFightData()
	MainController.instance:enterMainScene(true)
end

function var_0_0.clearFightData(arg_46_0)
	FightModel.instance.needFightReconnect = false

	FightModel.instance:onEndFight()
	FightSystem.instance:dispose()
	FightModel.instance:clearRecordMO()
end

var_0_0.instance = var_0_0.New()

return var_0_0
