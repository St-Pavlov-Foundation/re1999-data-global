module("modules.logic.chessgame.controller.ChessController", package.seeall)

slot0 = class("ChessController", BaseController)

function slot0.onInit(slot0)
	slot0._activityId = nil
	slot0._chessMapId = nil
	slot0._statViewTime = nil
end

function slot0.reInit(slot0)
	slot0._statViewTime = nil
end

function slot0.initMapData(slot0, slot1, slot2, slot3)
	slot4 = ChessGameModel.instance:getGameState()

	if slot3.dead and slot4 == ChessGameEnum.GameState.Fail then
		ChessRpcController.instance:sendActRollBackRequest(slot1, slot2, ChessGameEnum.RollBack.CheckPoint)

		return
	end

	if slot3.win and slot4 == ChessGameEnum.GameState.Win then
		ChessRpcController.instance:sendActReStartEpisodeRequest(slot1, slot2)
		ChessGameModel.instance:setGameState(nil)

		return
	end

	if slot3 and slot3.episodeId ~= 0 then
		ChessModel.instance:setActId(slot1)
		ChessModel.instance:setEpisodeId(slot3.episodeId)
		ChessGameModel.instance:setGameState(nil)
		ChessGameController.instance:initServerMap(slot1, slot3)
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameMapDataUpdate)
end

function slot0.startNewEpisode(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._startEpisodeCallback = slot2
	slot0._startEpisodeCallbackObj = slot3

	if ChessConfig.instance:isStoryEpisode(ChessModel.instance:getActId(), slot1) then
		slot0:storyEpisodePlayStory(slot7, slot1, slot5, slot6)
	else
		ChessGameController.instance:setViewName(slot4)
		ChessRpcController.instance:sendActStartEpisodeRequest(slot7, slot1, slot0.handleReceiveStartEpisode, slot0)
	end
end

function slot0.storyEpisodePlayStory(slot0, slot1, slot2, slot3, slot4)
	slot0.tmpPlayStoryFinishCb = slot3
	slot0.tmpPlayStoryFinishCbObj = slot4

	if not ChessConfig.instance:getEpisodeCo(slot1, slot2) then
		slot0:onStoryEpisodePlayOver({
			actId = slot1,
			episodeId = slot2
		})

		return
	end

	if (slot6.storyBefore and slot7 ~= 0 or false) and (slot6.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(slot7)) then
		StoryController.instance:playStories({
			slot7
		}, {
			blur = true,
			mark = true,
			hideStartAndEndDark = true
		}, slot0.onStoryEpisodePlayOver, slot0, slot5)
	else
		slot0:onStoryEpisodePlayOver(slot5)
	end

	if slot0._startEpisodeCallback then
		slot0._startEpisodeCallback(slot0._startEpisodeCallbackObj)
	end

	slot0._startEpisodeCallback = nil
	slot0._startEpisodeCallbackObj = nil
end

function slot0.onStoryEpisodePlayOver(slot0, slot1)
	if not slot1 then
		return
	end

	ChessRpcController.instance:sendActStartEpisodeRequest(slot1.actId, slot1.episodeId, slot0.onSendPlayOverCb, slot0)
end

function slot0.onSendPlayOverCb(slot0, slot1, slot2, slot3)
	slot0:reGetActInfo(slot0.tmpPlayStoryFinishCb, slot0.tmpPlayStoryFinishCbObj)

	slot0.tmpPlayStoryFinishCb = nil
	slot0.tmpPlayStoryFinishCbObj = nil
end

function slot0.reGetActInfo(slot0, slot1, slot2)
	ChessRpcController.instance:sendGetActInfoRequest(ChessModel.instance:getActId(), slot1, slot2)
end

function slot0.startResetEpisode(slot0, slot1, slot2, slot3, slot4)
	slot0._startEpisodeCallback = slot2
	slot0._startEpisodeCallbackObj = slot3

	ChessGameController.instance:setViewName(slot4)
	ChessRpcController.instance:sendActStartEpisodeRequest(ChessModel.instance:getActId(), slot1, slot0.handleReceiveResetEpisode, slot0)
end

function slot0.handleReceiveStartEpisode(slot0, slot1, slot2)
	slot3 = slot0._startEpisodeCallback
	slot4 = slot0._startEpisodeCallbackObj
	slot0._startEpisodeCallback = nil
	slot0._startEpisodeCallbackObj = nil

	if slot2 ~= 0 then
		return
	end

	slot0:openGameView(slot1, slot2)

	if slot3 then
		slot3(slot4)
	end
end

function slot0.handleReceiveResetEpisode(slot0, slot1, slot2)
	slot3 = slot0._startEpisodeCallback
	slot4 = slot0._startEpisodeCallbackObj
	slot0._startEpisodeCallback = nil
	slot0._startEpisodeCallbackObj = nil

	if slot2 ~= 0 then
		return
	end

	slot0:openGameView(slot1, slot2, true)

	if slot3 then
		slot3(slot4)
	end
end

function slot0.openGameView(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot5 = ChessModel.instance:getEpisodeId()

	if ChessModel.instance:getActId() ~= nil and slot5 ~= nil then
		if ChessConfig.instance:getEpisodeCo(slot4, slot5) and slot6.storyBefore == 0 then
			uv0.onOpenGameStoryPlayOver()

			return
		end

		slot7 = slot6.storyBefore

		if not slot3 and (slot6.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(slot7)) then
			StoryController.instance:playStories({
				slot7
			}, {
				blur = true,
				mark = true,
				hideStartAndEndDark = true
			}, uv0.onOpenGameStoryPlayOver)
		else
			uv0.onOpenGameStoryPlayOver()
		end
	end
end

function slot0.onOpenGameStoryPlayOver()
	slot3 = ChessConfig.instance:getEpisodeCo(ChessModel.instance:getActId(), ChessModel.instance:getEpisodeId()).mapIds

	if ChessGameController.instance:existGame() and slot3 then
		ChessGameController.instance:enterChessGame(slot0, slot3, ChessGameController.instance:getViewName())
	end
end

function slot0.openGameAfterFight(slot0, slot1)
	if FightModel.instance:getFightReason() and slot2.fromChessGame then
		ChessModel.instance:setActId(slot2.actId)
		ChessModel.instance:setEpisodeId(slot2.actEpisodeId)
	end

	slot0._isRefuseBattle = nil

	if ChessModel.instance:getActId() and ChessModel.instance:getEpisodeId() then
		slot0._isRefuseBattle = slot1

		ChessRpcController.instance:sendGetActInfoRequest(slot3, slot0.onReceiveInfoAfterFight, slot0)
	end
end

function slot0.onReceiveInfoAfterFight(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot5 = ChessModel.instance:getMapId()

	if ChessModel.instance:getEpisodeId() and slot5 then
		ChessGameController.instance:enterChessGame(ChessModel.instance:getActId(), slot5, ChessGameController.instance:getViewName())
	else
		logNormal("no map return entry")
	end

	slot0._isRefuseBattle = nil
end

function slot0.getFromRefuseBattle(slot0)
	return slot0._isRefuseBattle
end

function slot0.getFightSourceEpisode(slot0)
	slot2 = ChessModel.instance:getEpisodeId()

	if ChessModel.instance:getActId() and slot2 then
		return slot1, slot2
	elseif FightModel.instance:getFightReason() ~= nil then
		return slot3.actId, slot3.actEpisodeId
	end
end

function slot0.enterActivityFight(slot0, slot1)
	slot3, slot4 = ChessConfig.instance:getChapterEpisodeId(ChessModel.instance:getActId())

	if (slot3 or DungeonConfig.instance:getEpisodeCO(slot1).chapterId) and slot4 then
		DungeonFightController.instance:enterFightByBattleId(slot3, slot4, slot1)
	end
end

slot0.instance = slot0.New()

return slot0
