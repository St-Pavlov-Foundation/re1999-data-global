module("modules.logic.versionactivity1_3.va3chess.controller.Va3ChessController", package.seeall)

slot0 = class("Va3ChessController", BaseController)

function slot0.onInit(slot0)
	slot0._activityId = nil
	slot0._chessMapId = nil
	slot0._statViewTime = nil
end

function slot0.reInit(slot0)
	slot0._statViewTime = nil
end

function slot0.initMapData(slot0, slot1, slot2)
	if slot2 and slot2.id ~= 0 then
		Va3ChessModel.instance:setActId(slot1)
		Va3ChessModel.instance:setEpisodeId(slot2.id)
		Va3ChessGameController.instance:initServerMap(slot1, slot2)
	else
		Va3ChessModel.instance:setActId(nil)
		Va3ChessModel.instance:setEpisodeId(nil)
		Va3ChessGameModel.instance:setRound(nil)
		Va3ChessGameModel.instance:setResult(nil)
		Va3ChessGameModel.instance:setFireBallCount(nil)
		Va3ChessGameModel.instance:updateFinishInteracts(nil)
		Va3ChessGameController.instance:release()
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameMapDataUpdate)
end

function slot0.startNewEpisode(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._startEpisodeCallback = slot2
	slot0._startEpisodeCallbackObj = slot3

	if Va3ChessConfig.instance:isStoryEpisode(Va3ChessModel.instance:getActId(), slot1) then
		slot0:storyEpisodePlayStory(slot7, slot1, slot5, slot6)
	else
		Va3ChessGameController.instance:setViewName(slot4)
		Va3ChessRpcController.instance:sendActStartEpisodeRequest(slot7, slot1, slot0.handleReceiveStartEpisode, slot0)
	end
end

function slot0.storyEpisodePlayStory(slot0, slot1, slot2, slot3, slot4)
	slot0.tmpPlayStoryFinishCb = slot3
	slot0.tmpPlayStoryFinishCbObj = slot4

	if not Va3ChessConfig.instance:getEpisodeCo(slot1, slot2) then
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

	Va3ChessRpcController.instance:sendActStartEpisodeRequest(slot1.actId, slot1.episodeId, slot0.onSendPlayOverCb, slot0)
end

function slot0.onSendPlayOverCb(slot0, slot1, slot2, slot3)
	slot0:reGetActInfo(slot0.tmpPlayStoryFinishCb, slot0.tmpPlayStoryFinishCbObj)

	slot0.tmpPlayStoryFinishCb = nil
	slot0.tmpPlayStoryFinishCbObj = nil
end

function slot0.reGetActInfo(slot0, slot1, slot2)
	Va3ChessRpcController.instance:sendGetActInfoRequest(Va3ChessModel.instance:getActId(), slot1, slot2)
end

function slot0.startResetEpisode(slot0, slot1, slot2, slot3, slot4)
	slot0._startEpisodeCallback = slot2
	slot0._startEpisodeCallbackObj = slot3

	Va3ChessGameController.instance:setViewName(slot4)
	Va3ChessRpcController.instance:sendActStartEpisodeRequest(Va3ChessModel.instance:getActId(), slot1, slot0.handleReceiveResetEpisode, slot0)
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

	slot5 = Va3ChessModel.instance:getMapId()
	slot6 = Va3ChessModel.instance:getEpisodeId()

	if Va3ChessModel.instance:getActId() ~= nil and slot6 ~= nil then
		if Va3ChessConfig.instance:getEpisodeCo(slot4, slot6) and slot7.storyBefore == 0 then
			uv0.onOpenGameStoryPlayOver()

			return
		end

		slot8 = slot7.storyBefore

		if not slot3 and (slot7.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(slot8)) then
			StoryController.instance:playStories({
				slot8
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
	slot1 = Va3ChessModel.instance:getMapId()

	if Va3ChessGameController.instance:existGame() and slot1 then
		Va3ChessGameController.instance:enterChessGame(Va3ChessModel.instance:getActId(), slot1, Va3ChessGameController.instance:getViewName())
	end
end

function slot0.openGameAfterFight(slot0, slot1)
	if FightModel.instance:getFightReason() and slot2.fromChessGame then
		Va3ChessModel.instance:setActId(slot2.actId)
		Va3ChessModel.instance:setEpisodeId(slot2.actEpisodeId)
	end

	slot0._isRefuseBattle = nil

	if Va3ChessModel.instance:getActId() and Va3ChessModel.instance:getEpisodeId() then
		slot0._isRefuseBattle = slot1

		Va3ChessRpcController.instance:sendGetActInfoRequest(slot3, slot0.onReceiveInfoAfterFight, slot0)
	end
end

function slot0.onReceiveInfoAfterFight(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot4 = Va3ChessModel.instance:getActId()
	slot6 = Va3ChessModel.instance:getMapId()

	if Va3ChessModel.instance:getEpisodeId() and slot6 then
		Va3ChessGameController.instance:enterChessGame(slot4, slot6, Va3ChessGameController.instance:getViewName())

		if slot4 == VersionActivity1_3Enum.ActivityId.Act306 and slot3.map.brokenTilebases then
			Va3ChessGameModel.instance:updateBrokenTilebases(slot4, slot3.map.brokenTilebases)
		end
	else
		logNormal("no map return entry")
	end

	slot0._isRefuseBattle = nil
end

function slot0.getFromRefuseBattle(slot0)
	return slot0._isRefuseBattle
end

function slot0.getFightSourceEpisode(slot0)
	slot2 = Va3ChessModel.instance:getEpisodeId()

	if Va3ChessModel.instance:getActId() and slot2 then
		return slot1, slot2
	elseif FightModel.instance:getFightReason() ~= nil then
		return slot3.actId, slot3.actEpisodeId
	end
end

function slot0.enterActivityFight(slot0, slot1)
	slot3, slot4 = Va3ChessConfig.instance:getChapterEpisodeId(Va3ChessModel.instance:getActId())

	if (slot3 or DungeonConfig.instance:getEpisodeCO(slot1).chapterId) and slot4 then
		DungeonFightController.instance:enterFightByBattleId(slot3, slot4, slot1)
	end
end

slot0.instance = slot0.New()

return slot0
