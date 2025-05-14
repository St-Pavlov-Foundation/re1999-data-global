module("modules.logic.versionactivity1_3.chess.controller.Activity1_3ChessController", package.seeall)

local var_0_0 = class("Activity1_3ChessController", BaseController)

function var_0_0.openMapView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity122
	})
	Activity122Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act304, function()
		ViewMgr.instance:openView(ViewName.Activity1_3ChessMapView, {
			chapterId = arg_1_1
		}, true)

		if arg_1_2 then
			arg_1_2(arg_1_3, arg_1_4)
		end
	end)
end

function var_0_0.openStoryView(arg_3_0, arg_3_1)
	if Activity122Model.instance:isEpisodeClear(arg_3_1) then
		ViewMgr.instance:openView(ViewName.Activity1_3ChessStoryView, {
			actId = VersionActivity1_3Enum.ActivityId.Act304,
			episodeId = arg_3_1
		})
	end
end

function var_0_0.requestEnterChessGame(arg_4_0, arg_4_1, arg_4_2)
	Va3ChessGameModel.instance:clearLastMapRound()

	arg_4_0._isEnterPassedEpisode = Activity122Model.instance:isEpisodeClear(arg_4_1)

	Va3ChessModel.instance:setActId(VersionActivity1_3Enum.ActivityId.Act304)
	Activity122Model.instance:setCurEpisodeId(arg_4_1)
	arg_4_0:dispatchEvent(Activity1_3ChessEvent.BeginEnterChessGame, arg_4_1)
	Stat1_3Controller.instance:bristleStatStart()
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)

	if arg_4_2 then
		arg_4_0._enterEpisodeId = arg_4_1

		TaskDispatcher.runDelay(arg_4_0.delayRequestEnterChessGame, arg_4_0, arg_4_2)
	else
		Va3ChessController.instance:startNewEpisode(arg_4_1, arg_4_0._afterEnterGame, arg_4_0, ViewName.Activity1_3ChessGameView)
	end
end

function var_0_0.delayRequestEnterChessGame(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.delayRequestEnterChessGame, arg_5_0)
	Va3ChessController.instance:startNewEpisode(arg_5_0._enterEpisodeId, arg_5_0._afterEnterGame, arg_5_0, ViewName.Activity1_3ChessGameView)
end

function var_0_0.beginResetChessGame(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	Va3ChessGameModel.instance:clearLastMapRound()
	Va3ChessModel.instance:setActId(VersionActivity1_3Enum.ActivityId.Act304)

	arg_6_0._enterChessCallback = arg_6_2
	arg_6_0._enterChessCallbackObj = arg_6_3
	arg_6_0._resetChessGame = true

	Va3ChessController.instance:startResetEpisode(arg_6_1, arg_6_0._afterEnterGame, arg_6_0, ViewName.Activity1_3ChessGameView)
end

function var_0_0._afterEnterGame(arg_7_0)
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)

	local var_7_0 = Va3ChessModel.instance:getEpisodeId()

	if arg_7_0._enterChessCallback then
		arg_7_0._enterChessCallback(arg_7_0._enterChessCallbackObj)

		arg_7_0._enterChessCallback = nil
		arg_7_0._enterChessCallbackObj = nil
	end

	if arg_7_0._resetChessGame then
		arg_7_0:dispatchEvent(Activity1_3ChessEvent.AfterResetChessGame)

		arg_7_0._resetChessGame = nil
	end
end

function var_0_0.requestReadChessGame(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._readChessCallback = arg_8_2
	arg_8_0._readChessCallbackObj = arg_8_3

	Activity122Rpc.instance:sendAct122CheckPointRequest(arg_8_1, true, arg_8_0._readCallback, arg_8_0)
end

function var_0_0.requestBackChessGame(arg_9_0, arg_9_1)
	Activity122Rpc.instance:sendAct122CheckPointRequest(arg_9_1, false, arg_9_0._readCallback, arg_9_0)
end

function var_0_0._readCallback(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == 0 then
		local var_10_0 = arg_10_3.map
		local var_10_1 = var_10_0.mapId
		local var_10_2 = arg_10_3.activityId

		Va3ChessController.instance:initMapData(var_10_2, var_10_0)
		Va3ChessGameController.instance:enterChessGame(var_10_2, var_10_1, ViewName.Activity1_3ChessGameView)
	end

	if arg_10_0._readChessCallback then
		arg_10_0._readChessCallback(arg_10_0._readChessCallbackObj)

		arg_10_0._readChessCallback = nil
		arg_10_0._readChessCallbackObj = nil
	end

	arg_10_0:dispatchEvent(Activity1_3ChessEvent.OnReadChessGame)
end

function var_0_0.isEpisodeOpen(arg_11_0, arg_11_1)
	local var_11_0 = VersionActivity1_3Enum.ActivityId.Act304
	local var_11_1 = Activity122Config.instance:getEpisodeList(var_11_0)

	for iter_11_0 = 1, #var_11_1 do
		local var_11_2 = var_11_1[iter_11_0]

		if var_11_2.id == arg_11_1 and var_0_0.isOpenDay(var_11_2.id) and (var_11_2.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(var_11_2.id) or Activity122Model.instance:isEpisodeClear(var_11_2.preEpisode)) then
			return true
		end
	end

	return false
end

function var_0_0.checkEpisodeIsOpenByChapterId(arg_12_0, arg_12_1)
	local var_12_0 = VersionActivity1_3Enum.ActivityId.Act304
	local var_12_1 = Activity122Config.instance:getEpisodeList(var_12_0)

	for iter_12_0 = 1, #var_12_1 do
		local var_12_2 = var_12_1[iter_12_0]

		if var_12_2.chapterId == arg_12_1 and var_0_0.isOpenDay(var_12_2.id) and (var_12_2.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(var_12_2.id) or Activity122Model.instance:isEpisodeClear(var_12_2.preEpisode)) then
			return true
		end
	end

	return false
end

function var_0_0.isOpenDay(arg_13_0)
	local var_13_0 = VersionActivity1_3Enum.ActivityId.Act304
	local var_13_1 = ActivityModel.instance:getActMO(var_13_0)
	local var_13_2 = Activity122Config.instance:getEpisodeCo(var_13_0, arg_13_0)

	if var_13_1 and var_13_2 then
		local var_13_3 = var_13_1:getRealStartTimeStamp() + (var_13_2.openDay - 1) * 24 * 60 * 60
		local var_13_4 = ServerTime.now()

		if var_13_4 < var_13_3 then
			return false, var_13_3 - var_13_4
		end
	else
		return false, -1
	end

	return true
end

function var_0_0.isChapterOpen(arg_14_0, arg_14_1)
	local var_14_0 = var_0_0.getFristEpisodeCoByChapterId(arg_14_1)

	if not var_14_0 then
		return false, -1
	end

	if Activity122Model.instance:isEpisodeClear(var_14_0.id) then
		return true
	end

	local var_14_1, var_14_2 = var_0_0.isOpenDay(var_14_0.id)

	return var_14_1 and Activity122Model.instance:isEpisodeClear(var_14_0.preEpisode), var_14_2 or 0
end

function var_0_0.getFristEpisodeCoByChapterId(arg_15_0)
	local var_15_0 = VersionActivity1_3Enum.ActivityId.Act304
	local var_15_1 = Activity122Config.instance:getChapterEpisodeList(var_15_0, arg_15_0)

	return var_15_1 and var_15_1[1]
end

function var_0_0.isEnterPassedEpisode(arg_16_0)
	return arg_16_0._isEnterPassedEpisode
end

function var_0_0.getLimitTimeStr()
	local var_17_0 = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act304)

	if var_17_0 then
		return string.format(luaLang("activity_warmup_remain_time"), var_17_0:getRemainTimeStr())
	end

	return string.format(luaLang("activity_warmup_remain_time"), "0")
end

function var_0_0.setReviewStory(arg_18_0, arg_18_1)
	arg_18_0._isReviewStory = arg_18_1
end

function var_0_0.isReviewStory(arg_19_0)
	return arg_19_0._isReviewStory
end

function var_0_0.getCurChessMapCfg()
	local var_20_0 = Va3ChessGameModel.instance:getActId()
	local var_20_1 = Va3ChessGameModel.instance:getMapId()

	return (Activity122Config.instance:getMapCo(var_20_0, var_20_1))
end

local var_0_1 = -100

function var_0_0.delayRequestGetReward(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._taskMO == nil and arg_21_2 then
		arg_21_0._taskMO = arg_21_2

		TaskDispatcher.runDelay(arg_21_0.requestGetReward, arg_21_0, arg_21_1)
	end
end

function var_0_0.requestGetReward(arg_22_0)
	if arg_22_0._taskMO == nil then
		return
	end

	if arg_22_0._taskMO.id == var_0_1 then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity122)
	elseif arg_22_0._taskMO:haveRewardToGet() then
		TaskRpc.instance:sendFinishTaskRequest(arg_22_0._taskMO.id)
	end

	arg_22_0._taskMO = nil
end

function var_0_0.dispatchAllTaskItemGotReward(arg_23_0)
	var_0_0.instance:dispatchEvent(Activity1_3ChessEvent.OneClickClaimReward)
end

function var_0_0.showToastByEpsodeId(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = VersionActivity1_3Enum.ActivityId.Act304
	local var_24_1 = Activity122Config.instance:getEpisodeCo(var_24_0, arg_24_1)

	if not var_24_1 then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_3Enum.ActivityId.Act304, arg_24_1))

		return
	end

	local var_24_2, var_24_3 = var_0_0.isOpenDay(var_24_1.id)

	if not var_24_2 then
		GameFacade.showToast(arg_24_2 and ToastEnum.Va3Act120ChapterNotOpenTime or ToastEnum.Va3Act120EpisodeNotOpenTime)

		return
	end

	if not (var_24_1.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(var_24_1.preEpisode)) then
		local var_24_4 = Activity122Config.instance:getEpisodeCo(var_24_1.activityId, var_24_1.preEpisode)

		GameFacade.showToast(ToastEnum.Va3Act124PreEpisodeNotOpen, var_24_4 and var_24_4.name or var_24_1.preEpisode)
	end
end

function var_0_0.checkHasReward(arg_25_0)
	local var_25_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity122)

	if var_25_0 ~= nil then
		local var_25_1 = Activity122Config.instance:getTaskByActId(Va3ChessEnum.ActivityId.Act122)

		for iter_25_0, iter_25_1 in ipairs(var_25_1) do
			local var_25_2 = var_25_0[iter_25_1.id]

			if var_25_2 and var_25_2.hasFinished and var_25_2.finishCount == 0 then
				return true
			end
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
