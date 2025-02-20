module("modules.logic.fight.controller.FightController", package.seeall)

slot0 = class("FightController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	TaskDispatcher.cancelTask(slot0._delayEnterFightScene, slot0)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightSystem.instance:dispose()
	end

	slot0._guideContinueEvent = nil
end

function slot0.addConstEvents(slot0)
	uv0.instance:registerCallback(FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	uv0.instance:registerCallback(FightEvent.PushEndFight, slot0._pushEndFight, slot0)
	uv0.instance:registerCallback(FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	uv0.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	uv0.instance:registerCallback(FightEvent.OnEndSequenceFinish, slot0._onEndSequenceFinish, slot0)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, slot0._onFightSceneStart, slot0)

	slot0._fightEventExtend = FightEventExtend.New()

	slot0._fightEventExtend:addConstEvents()
end

function slot0.sendTestFight(slot0, slot1, slot2)
	logNormal("Enter Test Fight, param = \n" .. cjson.encode(slot1))
	FightModel.instance:setFightParam(slot1)
	FightRpc.instance:sendTestFightRequest(slot1, slot1.monsterGroupIds, slot2 or FightEnum.FightActType.Normal)
end

function slot0.sendTestFightId(slot0, slot1)
	logNormal("Enter Test FightId, param = \n" .. cjson.encode(slot1))
	FightModel.instance:setFightParam(slot1)

	slot1.fightActType = slot1.fightActType or FightEnum.FightActType.Normal

	FightRpc.instance:sendTestFightIdRequest(slot1)
end

function slot0.enterFightScene(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		if GameSceneMgr.instance:isLoading() then
			logNormal("正在进入战斗，无法重复进入战斗")
		else
			logNormal("已经在战斗中，无法重复进入战斗")
		end

		return
	end

	if FightModel.instance:getFightParam() and slot1.sceneId then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView2)
		GameSceneMgr.instance:showLoading(SceneType.Fight)
		TaskDispatcher.runDelay(slot0._delayEnterFightScene, slot0, 0.5)
	else
		logError("FightParam.sceneId not exist")
	end
end

function slot0._delayEnterFightScene(slot0)
	if FightModel.instance:getFightParam() and slot1.sceneId then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterFbFight)
		PlayerModel.instance:getAndResetPlayerLevelUp()
		FightModel.instance:checkEnterUseFreeLimit()
		GameSceneMgr.instance:startScene(SceneType.Fight, slot1.sceneId, slot1.levelId)
	else
		GameSceneMgr.instance:hideLoading(SceneType.Fight)
		logError("FightParam.sceneId not exist")
	end
end

function slot0.exitFightScene(slot0)
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Checkpointend)

	if ToughBattleController.instance:checkIsToughBattle() then
		ToughBattleController.instance:enterToughBattle()

		return
	end

	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity()

		return
	end

	if JumpModel.instance:getRecordFarmItem() then
		if slot1.canBackSource and (slot1.special or slot1.openedViewNameList and #slot1.openedViewNameList > 0) then
			slot0:handleJump()

			return
		end

		if slot1.checkFunc and slot1.checkFunc(slot1.checkFuncObj) then
			JumpModel.instance:clearRecordFarmItem()
		end
	end

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) then
		if slot3.type == DungeonEnum.EpisodeType.Explore then
			ExploreController.instance:enterExploreScene()

			return
		end

		if slot3.type == DungeonEnum.EpisodeType.Rouge then
			RougeMapController.instance:onExistFight()

			return
		end
	end

	slot2 = FightResultModel.instance.episodeId

	if slot0:isReplayMode(slot2) then
		GameSceneMgr.instance:closeScene(nil, , , true)
		GameSceneMgr.instance:setPrevScene(GameSceneMgr.instance:getPreSceneType(), GameSceneMgr.instance:getPreSceneId(), GameSceneMgr.instance:getPreLevelId())
		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2, DungeonModel.instance.curSelectTicketId)
	else
		GameSceneMgr.instance:startScene(slot5, slot6, slot7)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(slot2, true)
		end
	end
end

function slot0.isReplayMode(slot0, slot1)
	slot2 = false

	if not string.nilorempty(PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")) then
		slot2 = cjson.decode(slot3)[tostring(slot1)]
	end

	return slot2
end

function slot0.enterVersionActivityDungeon(slot0, slot1, slot2)
	slot3 = DungeonModel.instance.curSendChapterId
	slot4 = DungeonModel.instance.curSendEpisodeId

	if not slot2 and slot0:isReplayMode(slot4) then
		if FightSuccView.checkRecordFarmItem(slot4, JumpModel.instance:getRecordFarmItem()) then
			if not (slot7.quantity <= ItemModel.instance:getItemQuantity(slot7.type, slot7.id)) then
				GameSceneMgr.instance:closeScene(nil, , , true)
				DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot4).chapterId, slot4, DungeonModel.instance.curSelectTicketId)

				return
			end
		else
			GameSceneMgr.instance:closeScene(nil, , , true)
			DungeonFightController.instance:enterFight(slot6.chapterId, slot4, DungeonModel.instance.curSelectTicketId)

			return
		end
	end

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot1)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()

		if uv0.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)

			DungeonMapModel.instance.lastElementBattleId = uv1
			uv1 = DungeonConfig.instance:getElementFightEpisodeToNormalEpisodeId(uv0)

			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, uv1)
		elseif DungeonModel.instance.curSendEpisodePass then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, uv1)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(uv2, uv1, function ()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					episodeId = uv0
				})
			end)
		end
	end)
end

function slot0.enterVersionActivityDogView(slot0, slot1, slot2)
	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot1)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
		Activity109ChessController.instance:openGameAfterFight(uv0)
	end)
end

function slot0.enterVersionActivity1_2YaXianView(slot0, slot1, slot2)
end

function slot0.handleJump(slot0)
	slot1 = JumpModel.instance:getRecordFarmItem()

	JumpModel.instance:clearRecordFarmItem()

	slot1.canBackSource = nil
	DungeonModel.instance.curSendEpisodeId = nil
	slot2 = SceneType.Main

	if slot1.sceneType == SceneType.Main then
		slot2 = SceneType.Main

		MainController.instance:enterMainScene()
	elseif slot1.sceneType == SceneType.Room then
		slot2 = SceneType.Room

		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, , , , true)
	elseif slot1.sceneType == SceneType.Fight then
		if not slot0._fightViewDict then
			slot0._fightViewDict = {
				[ViewName.HeroGroupFightView] = true,
				[ViewName.V1a2_HeroGroupFightView] = true,
				[ViewName.V1a3_HeroGroupFightView] = true,
				[ViewName.V1a5_HeroGroupFightView] = true,
				[ViewName.V1a6_HeroGroupFightView] = true,
				[ViewName.HeroGroupFightWeekwalkView] = true,
				[ViewName.Season123HeroGroupFightView] = true,
				[ViewName.Season166HeroGroupFightView] = true,
				[ViewName.HeroGroupEditView] = true,
				[ViewName.VersionActivity_1_2_HeroGroupEditView] = true,
				[ViewName.Season123HeroGroupEditView] = true,
				[ViewName.Season166HeroGroupEditView] = true,
				[ViewName.RougeHeroGroupEditView] = true
			}
		end

		if slot1.openedViewNameList then
			for slot6 = #slot1.openedViewNameList, 1, -1 do
				if slot0._fightViewDict[slot1.openedViewNameList[slot6].viewName] then
					table.remove(slot1.openedViewNameList, slot6)
				end
			end
		end

		slot2 = SceneType.Main

		MainController.instance:enterMainScene()
	else
		slot2 = SceneType.Main

		MainController.instance:enterMainScene()
		logWarn("not handle recordFarmItem.sceneType : " .. tostring(slot1.sceneType))
	end

	SceneHelper.instance:waitSceneDone(slot2, function ()
		if uv0.jumpId then
			GameFacade.jump(uv0.jumpId)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, uv0.openedViewNameList[#uv0.openedViewNameList].viewName)

			if RoomController.instance:isRoomScene() then
				slot4 = uv0.openedViewNameList

				RoomController.instance:popUpSourceView(slot4)

				for slot4, slot5 in ipairs(uv0.openedViewNameList) do
					if slot5.viewName ~= ViewName.RoomInitBuildingView and slot5.viewName ~= ViewName.RoomFormulaView then
						ViewMgr.instance:openView(slot5.viewName, slot5.viewParam)
					end
				end
			else
				for slot4, slot5 in ipairs(uv0.openedViewNameList) do
					if slot5.viewName == ViewName.RoomInitBuildingView or slot5.viewName == ViewName.RoomFormulaView then
						RoomController.instance:popUpSourceView(uv0.openedViewNameList)
					elseif slot5.viewName == ViewName.BackpackView then
						BackpackController.instance:enterItemBackpack()
					else
						ViewMgr.instance:openView(slot5.viewName, slot5.viewParam)
					end
				end
			end
		end
	end)
end

function slot0._respBeginFight(slot0)
	slot0:enterFightScene()
end

function slot0._pushEndFight(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and not GameSceneMgr.instance:isLoading() then
		FightSystem.instance:endFight()
	end
end

function slot0._onFightSceneStart(slot0, slot1, slot2)
	if slot2 == 1 then
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

function slot0._onStartSequenceFinish(slot0)
	slot0:_recordFreeTicket()
	slot0:beginWave()
end

function slot0.setCurStage(slot0, slot1)
	FightModel.instance:setCurStage(slot1)
	logNormal("当前阶段：" .. FightModel.instance:getCurStageDesc())
	uv0.instance:dispatchEvent(FightEvent.OnStageChange, slot1)
end

function slot0.beginWave(slot0)
	uv0.instance:dispatchEvent(FightEvent.OnBeginWave)
end

function slot0._onRoundSequenceFinish(slot0)
	if FightModel.instance:isFinish() then
		logNormal("回合结束，战斗结束")

		if FightDataHelper.fieldMgr:isDouQuQu() then
			return
		end

		FightRpc.instance:sendEndFightRequest(false)
	end
end

function slot0._onEndSequenceFinish(slot0)
end

function slot0.GuideFlowPauseAndContinue(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = FightModel.instance:getGuideParam()

	uv0.instance:dispatchEvent(slot2, slot9, slot6, slot7, slot8)

	if slot9[slot1] then
		slot9[slot1] = false

		if slot0._guideContinueEvent then
			logError("guiding event: " .. slot0._guideContinueEvent .. ", try to replase with: " .. slot3)
			uv0.instance:unregisterCallback(slot0._guideContinueEvent, slot0._continueCallback, slot0)
		end

		slot0._guideContinueEvent = slot3
		slot0._guideCallback = slot4
		slot0._guideCallbackObj = slot5

		uv0.instance:registerCallback(slot0._guideContinueEvent, slot0._continueCallback, slot0)

		return true
	else
		slot4(slot5)

		if slot0._guideContinueEvent == slot2 then
			uv0.instance:unregisterCallback(slot0._guideContinueEvent, slot0._continueCallback, slot0)

			slot0._guideContinueEvent = nil
			slot0._guideCallback = nil
			slot0._guideCallbackObj = nil
		end
	end

	return false
end

function slot0._continueCallback(slot0)
	if slot0._guideContinueEvent then
		uv0.instance:unregisterCallback(slot0._guideContinueEvent, slot0._continueCallback, slot0)

		slot0._guideContinueEvent = nil
		slot0._guideCallback = nil
		slot0._guideCallbackObj = nil

		slot0._guideCallback(slot0._guideCallbackObj)
	end
end

function slot0.setNewBieFightParamByEpisodeId(slot0, slot1)
	slot2 = FightParam.New()

	slot2:setEpisodeId(slot1)
	FightModel.instance:setFightParam(slot2)

	return slot2
end

function slot0.setFightParamByEpisodeAndBattle(slot0, slot1, slot2)
	slot3 = FightParam.New()

	slot3:setEpisodeAndBattle(slot1, slot2)
	FightModel.instance:setFightParam(slot3)

	return slot3
end

function slot0.setFightParamByEpisodeId(slot0, slot1, slot2, slot3, slot4)
	slot5 = FightParam.New()

	slot5:setEpisodeId(slot1, slot4)

	slot5.isReplay = slot2
	slot5.multiplication = slot3

	FightModel.instance:setFightParam(slot5)

	return slot5
end

function slot0.setFightParamByEpisodeBattleId(slot0, slot1, slot2)
	slot3 = FightParam.New()

	slot3:setEpisodeId(slot1, slot2)
	FightModel.instance:setFightParam(slot3)

	return slot3
end

function slot0.setFightParamByBattleId(slot0, slot1)
	slot2 = FightParam.New()

	slot2:setBattleId(slot1)
	FightModel.instance:setFightParam(slot2)

	return slot2
end

function slot0.setFightHeroGroup(slot0)
	if not FightModel.instance:getFightParam() then
		return false
	end

	if not HeroGroupModel.instance:getCurGroupMO() then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	slot3, slot4 = slot2:getMainList()
	slot5, slot6 = slot2:getSubList()

	if (not slot2.aidDict or #slot2.aidDict <= 0) and slot4 + slot6 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	slot8 = slot1.battleId and lua_battle.configDict[slot7]

	slot1:setMySide(slot8 and slot8.noClothSkill == 0 and slot2.clothId or 0, slot3, slot2:getSubList(), slot2:getAllHeroEquips(), SeasonFightHandler.getSeasonEquips(slot2, slot1), nil, , slot2:getAssistBossId())

	return true
end

function slot0.setFightHeroSingleGroup(slot0)
	if not FightModel.instance:getFightParam() then
		return false
	end

	if not HeroGroupModel.instance:getCurGroupMO() then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	slot3, slot4 = slot2:getMainList()
	slot5, slot6 = slot2:getSubList()
	slot7 = HeroSingleGroupModel.instance:getList()
	slot8 = slot2:getAllHeroEquips()
	slot9 = slot2:getAssistBossId()

	for slot13 = 1, #slot3 do
		if slot3[slot13] ~= slot7[slot13].heroUid then
			slot3[slot13] = "0"
			slot4 = slot4 - 1

			if slot8[slot13] then
				slot8[slot13].heroUid = "0"
			end
		end
	end

	slot13 = #slot3 + #slot5

	for slot13 = #slot3 + 1, math.min(slot13, #slot7) do
		if slot5[slot13 - #slot3] ~= slot7[slot13].heroUid then
			slot5[slot13 - #slot3] = "0"
			slot6 = slot6 - 1

			if slot8[slot13] then
				slot8[slot13].heroUid = "0"
			end
		end
	end

	if (not slot2.aidDict or #slot2.aidDict <= 0) and slot4 + slot6 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	slot12 = slot1.battleId and lua_battle.configDict[slot11]

	slot1:setMySide(slot12 and slot12.noClothSkill == 0 and slot2.clothId or 0, slot3, slot5, slot8, SeasonFightHandler.getSeasonEquips(slot2, slot1), nil, , slot9)

	return true
end

function slot0.openRoundView(slot0)
	if slot0:canOpenRoundView() then
		ViewMgr.instance:openView(ViewName.FightRoundView)
	end
end

function slot0.canOpenRoundView(slot0)
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

function slot0.getPlayerPrefKeyAuto(slot0, slot1)
	if not slot1 then
		return
	end

	if string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.FightAutoEpsodeIds .. PlayerModel.instance:getPlayinfo().userId, "")) then
		return false
	end

	for slot8, slot9 in ipairs(string.splitToNumber(slot3, "#")) do
		if slot9 == slot1 then
			return true
		end
	end

	return false
end

function slot0.setPlayerPrefKeyAuto(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.FightAutoEpsodeIds .. PlayerModel.instance:getPlayinfo().userId, "")) then
		if slot2 then
			PlayerPrefsHelper.setString(slot3, tostring(slot1))
		end

		return
	end

	slot5 = false

	for slot10, slot11 in ipairs(string.splitToNumber(slot4, "#")) do
		if slot11 == slot1 then
			slot5 = true
		end
	end

	if not slot5 and slot2 then
		PlayerPrefsHelper.setString(slot3, table.concat({
			slot4,
			"#",
			tostring(slot1)
		}))

		return
	end

	if slot5 and not slot2 then
		slot7 = {}

		for slot11, slot12 in ipairs(slot6) do
			if slot12 ~= slot1 then
				table.insert(slot7, slot12)
			end
		end

		PlayerPrefsHelper.setString(slot3, table.concat(slot7, "#"))

		return
	end
end

function slot0.checkFightQuitTipViewClose(slot0)
	if ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		ViewMgr.instance:closeView(ViewName.FightQuitTipView, nil)
	end

	SeasonFightHandler.closeSeasonFightRuleTipView()
end

function slot0.openFightSpecialTipView(slot0, slot1)
	if not slot1 and FightModel.instance:getFightParam() and SeasonFightHandler.openSeasonFightRuleTipView(DungeonConfig.instance:getEpisodeCO(slot2.episodeId) and slot4.type) then
		return
	end

	ViewMgr.instance:openView(ViewName.FightSpecialTipView)
end

function slot0.openFightTechniqueView(slot0)
	ViewMgr.instance:openView(ViewName.FightTechniqueView)
end

function slot0._recordFreeTicket(slot0)
	slot2 = FightModel.instance:getFightParam() and slot1.episodeId

	if not (slot2 and lua_episode.configDict[slot2]) then
		return
	end

	slot0.TEMP_equip_chapter_free_count = nil

	if DungeonConfig.instance:getChapterCO(slot3.chapterId).type == DungeonEnum.ChapterType.Equip then
		slot0.TEMP_equip_chapter_free_count = DungeonModel.instance:getChapterRemainingNum(slot4.type)
	end
end

function slot0.onResultViewClose()
	slot0 = {}

	uv0.instance:dispatchEvent(FightEvent.OnBreakResultViewClose, slot0)

	if slot0.isBreak then
		return
	end

	uv0.instance:dispatchEvent(FightEvent.OnResultViewClose)
end

function slot0.errorAndEnterMainScene(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	slot0:clearFightData()
	MainController.instance:enterMainScene(true)
end

function slot0.clearFightData(slot0)
	FightModel.instance.needFightReconnect = false

	FightModel.instance:onEndFight()
	FightSystem.instance:dispose()
	FightCardModel.instance:clear()
	FightModel.instance:clearRecordMO()
end

slot0.instance = slot0.New()

return slot0
