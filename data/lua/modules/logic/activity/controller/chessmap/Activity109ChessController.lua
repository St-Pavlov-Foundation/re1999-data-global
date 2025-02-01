module("modules.logic.activity.controller.chessmap.Activity109ChessController", package.seeall)

slot0 = class("Activity109ChessController", BaseController)

function slot0.onInit(slot0)
	slot0._activityId = nil
	slot0._chessMapId = nil
	slot0._statViewTime = nil
end

function slot0.reInit(slot0)
	slot0._statViewTime = nil
end

function slot0.openEntry(slot0, slot1)
	Activity109ChessModel.instance:setActId(slot1)
	Activity109Rpc.instance:sendGetAct109InfoRequest(slot1, slot0.onReceiveInfoOpenView, slot0)
end

function slot0.onReceiveInfoOpenView(slot0, slot1, slot2)
	if slot2 == 0 then
		ViewMgr.instance:openView(ViewName.Activity109ChessEntry)
	end
end

function slot0.initMapData(slot0, slot1, slot2)
	if slot2 and slot2.id ~= 0 then
		Activity109ChessModel.instance:setEpisodeId(slot2.id)
		ActivityChessGameController.instance:initServerMap(slot1, slot2)
	else
		Activity109ChessModel.instance:setEpisodeId(nil)
		ActivityChessGameModel.instance:setRound(nil)
		ActivityChessGameModel.instance:setResult(nil)
		ActivityChessGameModel.instance:updateFinishInteracts(nil)
		ActivityChessGameController.instance:release()
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameMapDataUpdate)
end

function slot0.startNewEpisode(slot0, slot1, slot2, slot3)
	slot0._startEpisodeCallback = slot2
	slot0._startEpisodeCallbackObj = slot3

	Activity109Rpc.instance:sendAct109StartEpisodeRequest(Activity109ChessModel.instance:getActId(), slot1, slot0.handleReceiveStartEpisode, slot0)
end

function slot0.startEpisode(slot0, slot1)
	if slot0:checkCanStartEpisode(slot1) then
		uv0.instance:startNewEpisode(slot1)

		return true
	end

	return false
end

function slot0.checkCanStartEpisode(slot0, slot1)
	if not Activity109Model.instance:getEpisodeData(slot1) then
		GameFacade.showToast(ToastEnum.Chess1)

		return false
	end

	return true
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

function slot0.openGameView(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot4 = Activity109ChessModel.instance:getMapId()
	slot5 = Activity109ChessModel.instance:getEpisodeId()

	if Activity109ChessModel.instance:getActId() ~= nil and slot5 ~= nil then
		if Activity109Config.instance:getEpisodeCo(slot3, slot5) and slot6.storyBefore == 0 then
			uv0.onOpenGameStoryPlayOver()

			return
		end

		if not StoryModel.instance:isStoryHasPlayed(slot6.storyBefore) then
			StoryController.instance:playStories({
				slot7
			}, nil, uv0.onOpenGameStoryPlayOver)
		else
			uv0.onOpenGameStoryPlayOver()
		end
	end
end

function slot0.onOpenGameStoryPlayOver()
	slot1 = Activity109ChessModel.instance:getMapId()

	if ActivityChessGameController.instance:existGame() and slot1 then
		ActivityChessGameController.instance:enterChessGame(Activity109ChessModel.instance:getActId(), slot1)
	end
end

function slot0.openGameAfterFight(slot0, slot1)
	if FightModel.instance:getFightReason() and slot2.fromChessGame then
		Activity109ChessModel.instance:setActId(slot2.actId)
		Activity109ChessModel.instance:setEpisodeId(slot2.actEpisodeId)
	end

	slot0._isRefuseBattle = nil

	if Activity109ChessModel.instance:getActId() and Activity109ChessModel.instance:getEpisodeId() then
		slot0._isRefuseBattle = slot1

		Activity109Rpc.instance:sendGetAct109InfoRequest(slot3, slot0.onReceiveInfoAfterFight, slot0)
	end
end

function slot0.onReceiveInfoAfterFight(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot4 = Activity109ChessModel.instance:getEpisodeId()
	slot5 = Activity109ChessModel.instance:getMapId()

	ViewMgr.instance:openView(ViewName.Activity109ChessEntry, slot4)

	if slot4 and slot5 then
		ActivityChessGameController.instance:enterChessGame(Activity109ChessModel.instance:getActId(), slot5)
	else
		logNormal("no map return entry")
	end

	slot0._isRefuseBattle = nil
end

function slot0.getFromRefuseBattle(slot0)
	return slot0._isRefuseBattle
end

function slot0.getFightSourceEpisode(slot0)
	slot2 = Activity109ChessModel.instance:getEpisodeId()

	if Activity109ChessModel.instance:getActId() and slot2 then
		return slot1, slot2
	elseif FightModel.instance:getFightReason() ~= nil then
		return slot3.actId, slot3.actEpisodeId
	end
end

function slot0.enterActivityFight(slot0, slot1)
	slot2 = ActivityChessEnum.EpisodeId

	DungeonFightController.instance:enterFightByBattleId(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2, slot1)
end

function slot0.statStart(slot0)
	if slot0._statViewTime then
		return
	end

	if not ActivityChessGameModel.instance:getMapId() then
		return
	end

	slot0._statViewRound = ActivityChessGameModel.instance:getRound()
	slot0._statViewTime = ServerTime.now()
end

function slot0.statEnd(slot0, slot1)
	if not slot0._statViewTime then
		return
	end

	slot2 = ServerTime.now() - slot0._statViewTime

	if not ActivityChessGameModel.instance:getMapId() then
		return
	end

	if not Activity109ChessModel.instance:getEpisodeId() then
		return
	end

	slot5 = ActivityChessGameModel.instance:getRound()
	slot0._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitPicklesActivity, {
		[StatEnum.EventProperties.UseTime] = slot2,
		[StatEnum.EventProperties.MapId] = tostring(slot3),
		[StatEnum.EventProperties.ChallengesNum] = Activity109Model.instance:getEpisodeData(slot4).totalCount,
		[StatEnum.EventProperties.RoundNum] = slot5,
		[StatEnum.EventProperties.IncrementRoundNum] = math.max(0, slot5 - slot0._statViewRound),
		[StatEnum.EventProperties.GoalNum] = ActivityChessGameModel.instance:getFinishGoalNum(),
		[StatEnum.EventProperties.Result] = slot1
	})
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
