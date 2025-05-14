module("modules.logic.activity.controller.chessmap.Activity109ChessController", package.seeall)

local var_0_0 = class("Activity109ChessController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._activityId = nil
	arg_1_0._chessMapId = nil
	arg_1_0._statViewTime = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._statViewTime = nil
end

function var_0_0.openEntry(arg_3_0, arg_3_1)
	Activity109ChessModel.instance:setActId(arg_3_1)
	Activity109Rpc.instance:sendGetAct109InfoRequest(arg_3_1, arg_3_0.onReceiveInfoOpenView, arg_3_0)
end

function var_0_0.onReceiveInfoOpenView(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 0 then
		ViewMgr.instance:openView(ViewName.Activity109ChessEntry)
	end
end

function var_0_0.initMapData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 and arg_5_2.id ~= 0 then
		Activity109ChessModel.instance:setEpisodeId(arg_5_2.id)
		ActivityChessGameController.instance:initServerMap(arg_5_1, arg_5_2)
	else
		Activity109ChessModel.instance:setEpisodeId(nil)
		ActivityChessGameModel.instance:setRound(nil)
		ActivityChessGameModel.instance:setResult(nil)
		ActivityChessGameModel.instance:updateFinishInteracts(nil)
		ActivityChessGameController.instance:release()
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameMapDataUpdate)
end

function var_0_0.startNewEpisode(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = Activity109ChessModel.instance:getActId()

	arg_6_0._startEpisodeCallback = arg_6_2
	arg_6_0._startEpisodeCallbackObj = arg_6_3

	Activity109Rpc.instance:sendAct109StartEpisodeRequest(var_6_0, arg_6_1, arg_6_0.handleReceiveStartEpisode, arg_6_0)
end

function var_0_0.startEpisode(arg_7_0, arg_7_1)
	if arg_7_0:checkCanStartEpisode(arg_7_1) then
		var_0_0.instance:startNewEpisode(arg_7_1)

		return true
	end

	return false
end

function var_0_0.checkCanStartEpisode(arg_8_0, arg_8_1)
	if not Activity109Model.instance:getEpisodeData(arg_8_1) then
		GameFacade.showToast(ToastEnum.Chess1)

		return false
	end

	return true
end

function var_0_0.handleReceiveStartEpisode(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._startEpisodeCallback
	local var_9_1 = arg_9_0._startEpisodeCallbackObj

	arg_9_0._startEpisodeCallback = nil
	arg_9_0._startEpisodeCallbackObj = nil

	if arg_9_2 ~= 0 then
		return
	end

	arg_9_0:openGameView(arg_9_1, arg_9_2)

	if var_9_0 then
		var_9_0(var_9_1)
	end
end

function var_0_0.openGameView(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 ~= 0 then
		return
	end

	local var_10_0 = Activity109ChessModel.instance:getActId()
	local var_10_1 = Activity109ChessModel.instance:getMapId()
	local var_10_2 = Activity109ChessModel.instance:getEpisodeId()

	if var_10_0 ~= nil and var_10_2 ~= nil then
		local var_10_3 = Activity109Config.instance:getEpisodeCo(var_10_0, var_10_2)

		if var_10_3 and var_10_3.storyBefore == 0 then
			var_0_0.onOpenGameStoryPlayOver()

			return
		end

		local var_10_4 = var_10_3.storyBefore

		if not StoryModel.instance:isStoryHasPlayed(var_10_4) then
			StoryController.instance:playStories({
				var_10_4
			}, nil, var_0_0.onOpenGameStoryPlayOver)
		else
			var_0_0.onOpenGameStoryPlayOver()
		end
	end
end

function var_0_0.onOpenGameStoryPlayOver()
	local var_11_0 = Activity109ChessModel.instance:getActId()
	local var_11_1 = Activity109ChessModel.instance:getMapId()

	if ActivityChessGameController.instance:existGame() and var_11_1 then
		ActivityChessGameController.instance:enterChessGame(var_11_0, var_11_1)
	end
end

function var_0_0.openGameAfterFight(arg_12_0, arg_12_1)
	local var_12_0 = FightModel.instance:getFightReason()

	if var_12_0 and var_12_0.fromChessGame then
		Activity109ChessModel.instance:setActId(var_12_0.actId)
		Activity109ChessModel.instance:setEpisodeId(var_12_0.actEpisodeId)
	end

	local var_12_1 = Activity109ChessModel.instance:getActId()
	local var_12_2 = Activity109ChessModel.instance:getEpisodeId()

	arg_12_0._isRefuseBattle = nil

	if var_12_1 and var_12_2 then
		arg_12_0._isRefuseBattle = arg_12_1

		Activity109Rpc.instance:sendGetAct109InfoRequest(var_12_1, arg_12_0.onReceiveInfoAfterFight, arg_12_0)
	end
end

function var_0_0.onReceiveInfoAfterFight(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 ~= 0 then
		return
	end

	local var_13_0 = Activity109ChessModel.instance:getActId()
	local var_13_1 = Activity109ChessModel.instance:getEpisodeId()
	local var_13_2 = Activity109ChessModel.instance:getMapId()

	ViewMgr.instance:openView(ViewName.Activity109ChessEntry, var_13_1)

	if var_13_1 and var_13_2 then
		ActivityChessGameController.instance:enterChessGame(var_13_0, var_13_2)
	else
		logNormal("no map return entry")
	end

	arg_13_0._isRefuseBattle = nil
end

function var_0_0.getFromRefuseBattle(arg_14_0)
	return arg_14_0._isRefuseBattle
end

function var_0_0.getFightSourceEpisode(arg_15_0)
	local var_15_0 = Activity109ChessModel.instance:getActId()
	local var_15_1 = Activity109ChessModel.instance:getEpisodeId()

	if var_15_0 and var_15_1 then
		return var_15_0, var_15_1
	else
		local var_15_2 = FightModel.instance:getFightReason()

		if var_15_2 ~= nil then
			return var_15_2.actId, var_15_2.actEpisodeId
		end
	end
end

function var_0_0.enterActivityFight(arg_16_0, arg_16_1)
	local var_16_0 = ActivityChessEnum.EpisodeId
	local var_16_1 = DungeonConfig.instance:getEpisodeCO(var_16_0)

	DungeonFightController.instance:enterFightByBattleId(var_16_1.chapterId, var_16_0, arg_16_1)
end

function var_0_0.statStart(arg_17_0)
	if arg_17_0._statViewTime then
		return
	end

	if not ActivityChessGameModel.instance:getMapId() then
		return
	end

	arg_17_0._statViewRound = ActivityChessGameModel.instance:getRound()
	arg_17_0._statViewTime = ServerTime.now()
end

function var_0_0.statEnd(arg_18_0, arg_18_1)
	if not arg_18_0._statViewTime then
		return
	end

	local var_18_0 = ServerTime.now() - arg_18_0._statViewTime
	local var_18_1 = ActivityChessGameModel.instance:getMapId()

	if not var_18_1 then
		return
	end

	local var_18_2 = Activity109ChessModel.instance:getEpisodeId()

	if not var_18_2 then
		return
	end

	local var_18_3 = ActivityChessGameModel.instance:getRound()
	local var_18_4 = math.max(0, var_18_3 - arg_18_0._statViewRound)
	local var_18_5 = ActivityChessGameModel.instance:getFinishGoalNum()
	local var_18_6 = Activity109Model.instance:getEpisodeData(var_18_2).totalCount

	arg_18_0._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitPicklesActivity, {
		[StatEnum.EventProperties.UseTime] = var_18_0,
		[StatEnum.EventProperties.MapId] = tostring(var_18_1),
		[StatEnum.EventProperties.ChallengesNum] = var_18_6,
		[StatEnum.EventProperties.RoundNum] = var_18_3,
		[StatEnum.EventProperties.IncrementRoundNum] = var_18_4,
		[StatEnum.EventProperties.GoalNum] = var_18_5,
		[StatEnum.EventProperties.Result] = arg_18_1
	})
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
