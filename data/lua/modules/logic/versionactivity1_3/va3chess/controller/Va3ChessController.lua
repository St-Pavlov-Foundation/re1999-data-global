module("modules.logic.versionactivity1_3.va3chess.controller.Va3ChessController", package.seeall)

local var_0_0 = class("Va3ChessController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._activityId = nil
	arg_1_0._chessMapId = nil
	arg_1_0._statViewTime = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._statViewTime = nil
end

function var_0_0.initMapData(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 and arg_3_2.id ~= 0 then
		Va3ChessModel.instance:setActId(arg_3_1)
		Va3ChessModel.instance:setEpisodeId(arg_3_2.id)
		Va3ChessGameController.instance:initServerMap(arg_3_1, arg_3_2)
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

function var_0_0.startNewEpisode(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0._startEpisodeCallback = arg_4_2
	arg_4_0._startEpisodeCallbackObj = arg_4_3

	local var_4_0 = Va3ChessModel.instance:getActId()

	if Va3ChessConfig.instance:isStoryEpisode(var_4_0, arg_4_1) then
		arg_4_0:storyEpisodePlayStory(var_4_0, arg_4_1, arg_4_5, arg_4_6)
	else
		Va3ChessGameController.instance:setViewName(arg_4_4)
		Va3ChessRpcController.instance:sendActStartEpisodeRequest(var_4_0, arg_4_1, arg_4_0.handleReceiveStartEpisode, arg_4_0)
	end
end

function var_0_0.storyEpisodePlayStory(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.tmpPlayStoryFinishCb = arg_5_3
	arg_5_0.tmpPlayStoryFinishCbObj = arg_5_4

	local var_5_0 = {
		actId = arg_5_1,
		episodeId = arg_5_2
	}
	local var_5_1 = Va3ChessConfig.instance:getEpisodeCo(arg_5_1, arg_5_2)

	if not var_5_1 then
		arg_5_0:onStoryEpisodePlayOver(var_5_0)

		return
	end

	local var_5_2 = var_5_1.storyBefore
	local var_5_3 = var_5_2 and var_5_2 ~= 0 or false
	local var_5_4 = var_5_1.storyRepeat == 1
	local var_5_5 = StoryModel.instance:isStoryHasPlayed(var_5_2)

	if var_5_3 and (var_5_4 or not var_5_5) then
		local var_5_6 = {}

		var_5_6.blur = true
		var_5_6.mark = true
		var_5_6.hideStartAndEndDark = true

		StoryController.instance:playStories({
			var_5_2
		}, var_5_6, arg_5_0.onStoryEpisodePlayOver, arg_5_0, var_5_0)
	else
		arg_5_0:onStoryEpisodePlayOver(var_5_0)
	end

	if arg_5_0._startEpisodeCallback then
		arg_5_0._startEpisodeCallback(arg_5_0._startEpisodeCallbackObj)
	end

	arg_5_0._startEpisodeCallback = nil
	arg_5_0._startEpisodeCallbackObj = nil
end

function var_0_0.onStoryEpisodePlayOver(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	Va3ChessRpcController.instance:sendActStartEpisodeRequest(arg_6_1.actId, arg_6_1.episodeId, arg_6_0.onSendPlayOverCb, arg_6_0)
end

function var_0_0.onSendPlayOverCb(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:reGetActInfo(arg_7_0.tmpPlayStoryFinishCb, arg_7_0.tmpPlayStoryFinishCbObj)

	arg_7_0.tmpPlayStoryFinishCb = nil
	arg_7_0.tmpPlayStoryFinishCbObj = nil
end

function var_0_0.reGetActInfo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = Va3ChessModel.instance:getActId()

	Va3ChessRpcController.instance:sendGetActInfoRequest(var_8_0, arg_8_1, arg_8_2)
end

function var_0_0.startResetEpisode(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = Va3ChessModel.instance:getActId()

	arg_9_0._startEpisodeCallback = arg_9_2
	arg_9_0._startEpisodeCallbackObj = arg_9_3

	Va3ChessGameController.instance:setViewName(arg_9_4)
	Va3ChessRpcController.instance:sendActStartEpisodeRequest(var_9_0, arg_9_1, arg_9_0.handleReceiveResetEpisode, arg_9_0)
end

function var_0_0.handleReceiveStartEpisode(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._startEpisodeCallback
	local var_10_1 = arg_10_0._startEpisodeCallbackObj

	arg_10_0._startEpisodeCallback = nil
	arg_10_0._startEpisodeCallbackObj = nil

	if arg_10_2 ~= 0 then
		return
	end

	arg_10_0:openGameView(arg_10_1, arg_10_2)

	if var_10_0 then
		var_10_0(var_10_1)
	end
end

function var_0_0.handleReceiveResetEpisode(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._startEpisodeCallback
	local var_11_1 = arg_11_0._startEpisodeCallbackObj

	arg_11_0._startEpisodeCallback = nil
	arg_11_0._startEpisodeCallbackObj = nil

	if arg_11_2 ~= 0 then
		return
	end

	arg_11_0:openGameView(arg_11_1, arg_11_2, true)

	if var_11_0 then
		var_11_0(var_11_1)
	end
end

function var_0_0.openGameView(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 ~= 0 then
		return
	end

	local var_12_0 = Va3ChessModel.instance:getActId()
	local var_12_1 = Va3ChessModel.instance:getMapId()
	local var_12_2 = Va3ChessModel.instance:getEpisodeId()

	if var_12_0 ~= nil and var_12_2 ~= nil then
		local var_12_3 = Va3ChessConfig.instance:getEpisodeCo(var_12_0, var_12_2)

		if var_12_3 and var_12_3.storyBefore == 0 then
			var_0_0.onOpenGameStoryPlayOver()

			return
		end

		local var_12_4 = var_12_3.storyBefore

		if not arg_12_3 and (var_12_3.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(var_12_4)) then
			local var_12_5 = {}

			var_12_5.blur = true
			var_12_5.mark = true
			var_12_5.hideStartAndEndDark = true

			StoryController.instance:playStories({
				var_12_4
			}, var_12_5, var_0_0.onOpenGameStoryPlayOver)
		else
			var_0_0.onOpenGameStoryPlayOver()
		end
	end
end

function var_0_0.onOpenGameStoryPlayOver()
	local var_13_0 = Va3ChessModel.instance:getActId()
	local var_13_1 = Va3ChessModel.instance:getMapId()

	if Va3ChessGameController.instance:existGame() and var_13_1 then
		Va3ChessGameController.instance:enterChessGame(var_13_0, var_13_1, Va3ChessGameController.instance:getViewName())
	end
end

function var_0_0.openGameAfterFight(arg_14_0, arg_14_1)
	local var_14_0 = FightModel.instance:getFightReason()

	if var_14_0 and var_14_0.fromChessGame then
		Va3ChessModel.instance:setActId(var_14_0.actId)
		Va3ChessModel.instance:setEpisodeId(var_14_0.actEpisodeId)
	end

	local var_14_1 = Va3ChessModel.instance:getActId()
	local var_14_2 = Va3ChessModel.instance:getEpisodeId()

	arg_14_0._isRefuseBattle = nil

	if var_14_1 and var_14_2 then
		arg_14_0._isRefuseBattle = arg_14_1

		Va3ChessRpcController.instance:sendGetActInfoRequest(var_14_1, arg_14_0.onReceiveInfoAfterFight, arg_14_0)
	end
end

function var_0_0.onReceiveInfoAfterFight(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_2 ~= 0 then
		return
	end

	local var_15_0 = Va3ChessModel.instance:getActId()
	local var_15_1 = Va3ChessModel.instance:getEpisodeId()
	local var_15_2 = Va3ChessModel.instance:getMapId()

	if var_15_1 and var_15_2 then
		Va3ChessGameController.instance:enterChessGame(var_15_0, var_15_2, Va3ChessGameController.instance:getViewName())

		if var_15_0 == VersionActivity1_3Enum.ActivityId.Act306 and arg_15_3.map.brokenTilebases then
			Va3ChessGameModel.instance:updateBrokenTilebases(var_15_0, arg_15_3.map.brokenTilebases)
		end
	else
		logNormal("no map return entry")
	end

	arg_15_0._isRefuseBattle = nil
end

function var_0_0.getFromRefuseBattle(arg_16_0)
	return arg_16_0._isRefuseBattle
end

function var_0_0.getFightSourceEpisode(arg_17_0)
	local var_17_0 = Va3ChessModel.instance:getActId()
	local var_17_1 = Va3ChessModel.instance:getEpisodeId()

	if var_17_0 and var_17_1 then
		return var_17_0, var_17_1
	else
		local var_17_2 = FightModel.instance:getFightReason()

		if var_17_2 ~= nil then
			return var_17_2.actId, var_17_2.actEpisodeId
		end
	end
end

function var_0_0.enterActivityFight(arg_18_0, arg_18_1)
	local var_18_0 = Va3ChessModel.instance:getActId()
	local var_18_1, var_18_2 = Va3ChessConfig.instance:getChapterEpisodeId(var_18_0)

	var_18_1 = var_18_1 or DungeonConfig.instance:getEpisodeCO(arg_18_1).chapterId

	if var_18_1 and var_18_2 then
		DungeonFightController.instance:enterFightByBattleId(var_18_1, var_18_2, arg_18_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
