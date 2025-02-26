module("modules.logic.versionactivity1_5.aizila.controller.AiZiLaGameController", package.seeall)

slot0 = class("AiZiLaGameController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.exitGame(slot0)
	if ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventResult) then
		uv0.instance:leaveEventResult()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventView) then
		ViewMgr.instance:closeView(ViewName.AiZiLaGameEventView)

		return
	end

	slot2 = 0

	if AiZiLaGameModel.instance:getEpisodeMO():getRoundCfg() then
		slot2 = 1000 - slot3.keepMaterialRate
	end

	if slot1:isCanSafe() or slot2 == 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5AiZiLaSafeExitGame, MsgBoxEnum.BoxType.Yes_No, uv0._onExitGameYes)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5AiZiLaNotSafeExitGame, MsgBoxEnum.BoxType.Yes_No, uv0._onExitGameYes, nil, , slot0, nil, , slot2 * 0.1)
	end
end

function slot0._onExitGameYes()
	uv0.instance:settleEpisode()
end

function slot0.enterGame(slot0, slot1)
	AiZiLaGameModel.instance:reInit()
	AiZiLaGameModel.instance:setEpisodeId(slot1)

	slot0._enterStoryFinish = true
	slot0._enterRpcFinish = false

	if slot0:_checkCanPlayStory(AiZiLaConfig.instance:getEpisodeCo(AiZiLaGameModel.instance:getActivityID(), slot1).storyBefore) then
		slot0._enterStoryFinish = false

		slot0:_playStory(slot3.storyBefore, slot0._afterPlayEnterStory, slot0)
	end

	Activity144Rpc.instance:sendAct144EnterEpisodeRequest(slot2, slot1, slot0._onEnterGameRequest, slot0)
end

function slot0._checkCanPlayStory(slot0, slot1)
	if slot1 and slot1 ~= 0 and not StoryModel.instance:isStoryHasPlayed(slot1) then
		return true
	end

	return false
end

function slot0.playStory(slot0, slot1, slot2, slot3)
	slot0:_playStory(slot1)
end

function slot0._playStory(slot0, slot1, slot2, slot3)
	StoryController.instance:playStory(slot1, {
		blur = true,
		hideStartAndEndDark = true,
		mark = true,
		isReplay = false
	}, slot2, slot3)
end

function slot0._afterPlayEnterStory(slot0)
	slot0._enterStoryFinish = true

	slot0:dispatchEvent(AiZiLaEvent.GameStoryPlayFinish)
	slot0:_checkEnterGame()
end

function slot0._onEnterGameRequest(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0._enterRpcFinish = true

		AiZiLaGameModel.instance:updateEpisode(slot3.act144Episode)
		slot0:_checkEnterGame()
	end
end

function slot0._checkEnterGame(slot0)
	if slot0._enterRpcFinish and slot0._enterStoryFinish then
		slot0:_startGame()
		ViewMgr.instance:openView(ViewName.AiZiLaGameOpenEffectView, {
			callback = slot0._afterOpenEffect,
			callbackObj = slot0
		})
	end
end

function slot0._afterOpenEffect(slot0)
	ViewMgr.instance:openView(ViewName.AiZiLaGameView)
	ViewMgr.instance:closeView(ViewName.AiZiLaEpsiodeDetailView)
	ViewMgr.instance:closeView(ViewName.AiZiLaTaskView)
end

function slot0.gameResult(slot0)
	slot0:_delayGameResult(0.05)
end

function slot0._delayGameResult(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._onGameResult, slot0)
	TaskDispatcher.runDelay(slot0._onGameResult, slot0, slot1)
end

function slot0._onGameResult(slot0)
	if slot0._storyClearPlayIng then
		return
	end

	if slot0._isWaitingEventResult then
		slot0._isWaitingGameResult = true

		return
	end

	slot0._isWaitingGameResult = false

	ViewMgr.instance:openView(ViewName.AiZiLaGameResultView)
	slot0:_endGame()
end

function slot0.gameResultOver(slot0)
	if ViewMgr.instance:isOpenFinish(ViewName.AiZiLaGameResultView) then
		slot0._storyClearPlayIng = false

		if slot0:_checkCanPlayStory(AiZiLaConfig.instance:getEpisodeCo(AiZiLaGameModel.instance:getActivityID(), AiZiLaGameModel.instance:getEpisodeId()).storyClear) and AiZiLaGameModel.instance:isPass() then
			slot0._storyClearPlayIng = true

			slot0:_playStory(slot3.storyClear, slot0._afterPlayStoryClear, slot0)
			ViewMgr.instance:closeView(ViewName.AiZiLaGameResultView)
		else
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.ExitGame)
		end
	end
end

function slot0._startGame(slot0)
	if slot0._statGameTime then
		return
	end

	slot0._statGameTime = ServerTime.now()
end

function slot0._endGame(slot0)
	if not slot0._statGameTime then
		return
	end

	slot1 = ServerTime.now() - slot0._statGameTime

	if not AiZiLaGameModel.instance:getEpisodeMO() then
		return
	end

	slot3 = slot2:getConfig()
	slot4 = AiZiLaGameModel.instance:getIsSafe()
	slot5 = {}

	if AiZiLaGameModel.instance:getIsFirstPass() and slot3 then
		AiZiLaHelper.getItemMOListByBonusStr(slot3.bonus, slot5)
	end

	tabletool.addValues(slot5, AiZiLaGameModel.instance:getResultItemList())

	for slot10, slot11 in ipairs(slot5) do
		if slot11:getConfig() then
			table.insert({}, {
				materialtype = 1,
				materialname = slot12.name,
				materialnum = slot11:getQuantity()
			})
		end
	end

	slot7 = {}

	for slot12, slot13 in ipairs(AiZiLaModel.instance:getEquipMOList()) do
		if slot13:getConfig() then
			table.insert(slot7, {
				Ezra_equipname = slot14.name,
				Ezra_equip_level = slot14.level
			})
		end
	end

	slot0._statGameTime = nil

	StatController.instance:track(StatEnum.EventName.ExitEzraActivity, {
		[StatEnum.EventProperties.UseTime] = slot1,
		[StatEnum.EventProperties.EpisodeId] = string.format("%s", slot2.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = slot2.enterTimes,
		[StatEnum.EventProperties.RoundNum] = slot2.round,
		[StatEnum.EventProperties.RemainingMobility] = slot2.actionPoint,
		[StatEnum.EventProperties.CurrentAltitude] = slot2.altitude,
		[StatEnum.EventProperties.Result] = slot4 and "安全撤离" or "紧急撤离",
		[StatEnum.EventProperties.EquipInformation] = slot7,
		[StatEnum.EventProperties.Reward] = slot6
	})
end

function slot0._afterPlayStoryClear(slot0)
	slot0._storyClearPlayIng = false

	slot0:dispatchEvent(AiZiLaEvent.GameStoryPlayFinish)
	AiZiLaController.instance:dispatchEvent(AiZiLaEvent.ExitGame)
end

slot0.GAME_FORWARD_GAME_BLOCK_KEY = "AiZiLaGameController.GAME_FORWARD_GAME_BLOCK_KEY"

function slot0.forwardGame(slot0)
	AiZiLaHelper.startBlock(uv0.GAME_FORWARD_GAME_BLOCK_KEY)
	Activity144Rpc.instance:sendAct144NextDayRequest(AiZiLaGameModel.instance:getActivityID(), slot0._onForwardGameRequest, slot0)
end

function slot0._onForwardGameRequest(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		AiZiLaGameModel.instance:updateEpisode(slot3.act144Episode)
		ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
		slot0:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
	end

	AiZiLaHelper.endBlock(uv0.GAME_FORWARD_GAME_BLOCK_KEY)
end

slot0.GAME_SELECT_OPTION_BLOCK_KEY = "AiZiLaGameController.GAME_SELECT_OPTION_BLOCK_KEY"

function slot0.selectOption(slot0, slot1)
	AiZiLaHelper.startBlock(uv0.GAME_SELECT_OPTION_BLOCK_KEY)

	slot0._isWaitingEventResult = true

	Activity144Rpc.instance:sendAct144SelectOptionRequest(AiZiLaGameModel.instance:getActivityID(), slot1, slot0._onSelectOptionRequest, slot0)
end

function slot0._onSelectOptionRequest(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot4 = slot3.act144Episode
		slot0._eventResultViewParams = {
			eventId = slot4.eventId,
			actId = slot3.activityId,
			optionId = slot4.option,
			optionResultId = slot4.optionResultId,
			itemMOList = {}
		}
		slot6 = AiZiLaGameModel.instance

		slot6:updateEpisode(slot4)
		slot6:setAct144Items(slot4 and slot4.tempAct144Items or {})

		if AiZiLaConfig.instance:getOptionResultCo(slot3.activityId, slot4.optionResultId) and not string.nilorempty(slot8.bonus) then
			AiZiLaHelper.getItemMOListByBonusStr(slot8.bonus, slot5.itemMOList)
		end

		AiZiLaHelper.playViewAnimator(ViewName.AiZiLaGameEventView, UIAnimationName.Switch)
		TaskDispatcher.runDelay(slot0._onOpenGameEventResult, slot0, AiZiLaEnum.AnimatorTime.GameEventViewClose)
		slot0:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
	else
		slot0._eventResultViewParams = nil
		slot0._isWaitingEventResult = false

		TaskDispatcher.cancelTask(slot0._onOpenGameEventResult, slot0)
		AiZiLaHelper.endBlock(uv0.GAME_SELECT_OPTION_BLOCK_KEY)
	end
end

function slot0._onOpenGameEventResult(slot0)
	AiZiLaHelper.endBlock(uv0.GAME_SELECT_OPTION_BLOCK_KEY)

	slot0._isWaitingEventResult = false

	if slot0._eventResultViewParams then
		slot0._eventResultViewParams = nil

		ViewMgr.instance:openView(ViewName.AiZiLaGameEventResult, slot0._eventResultViewParams)
		ViewMgr.instance:closeView(ViewName.AiZiLaGameEventView, true)
	end
end

function slot0.settleEpisode(slot0)
	Activity144Rpc.instance:sendAct144SettleEpisodeRequest(VersionActivity1_5Enum.ActivityId.AiZiLa)
end

function slot0.leaveEventResult(slot0)
	if slot0._isWaitingGameResult then
		if ViewMgr.instance:getContainer(ViewName.AiZiLaGameView) and slot1:needPlayRiseAnim() then
			slot0:_delayGameResult(AiZiLaEnum.AnimatorTime.MapViewRise)
		else
			slot0:gameResult()
		end
	end

	ViewMgr.instance:closeView(ViewName.AiZiLaGameEventResult)
end

slot0.instance = slot0.New()

return slot0
