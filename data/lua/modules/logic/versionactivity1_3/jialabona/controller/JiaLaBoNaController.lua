module("modules.logic.versionactivity1_3.jialabona.controller.JiaLaBoNaController", package.seeall)

local var_0_0 = class("JiaLaBoNaController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._waitActId = nil
	arg_4_0._waitEpisodeId = nil
end

function var_0_0.delayReward(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._act120TaskMO == nil and arg_5_2 then
		arg_5_0._act120TaskMO = arg_5_2

		TaskDispatcher.runDelay(arg_5_0._onPreFinish, arg_5_0, arg_5_1)

		return true
	end

	return false
end

function var_0_0._onPreFinish(arg_6_0)
	local var_6_0 = arg_6_0._act120TaskMO

	arg_6_0._act120TaskMO = nil

	if var_6_0 and (var_6_0.id == JiaLaBoNaEnum.TaskMOAllFinishId or var_6_0:alreadyGotReward()) then
		Activity120TaskListModel.instance:preFinish(var_6_0)

		arg_6_0._act120TaskId = var_6_0.id

		TaskDispatcher.runDelay(arg_6_0._onRewardTask, arg_6_0, JiaLaBoNaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._onRewardTask(arg_7_0)
	local var_7_0 = arg_7_0._act120TaskId

	arg_7_0._act120TaskId = nil

	if var_7_0 then
		if var_7_0 == JiaLaBoNaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity120)
		else
			TaskRpc.instance:sendFinishTaskRequest(var_7_0)
		end
	end
end

function var_0_0.oneClaimReward(arg_8_0, arg_8_1)
	local var_8_0 = Activity120TaskListModel.instance:getList()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1:alreadyGotReward() and iter_8_1.id ~= JiaLaBoNaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(iter_8_1.id)
		end
	end
end

function var_0_0.openMapView(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity120
	}, function()
		Activity120Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act306)
		Activity120Model.instance:setCurEpisodeId(arg_9_1)
		ViewMgr.instance:openView(ViewName.JiaLaBoNaMapView, {
			episodeId = arg_9_1
		})

		if arg_9_2 then
			arg_9_2(arg_9_3, arg_9_4)
		end
	end)
end

function var_0_0.openStoryView(arg_11_0, arg_11_1)
	if Activity120Model.instance:isEpisodeClear(arg_11_1) then
		ViewMgr.instance:openView(ViewName.JiaLaBoNaStoryView, {
			actId = VersionActivity1_3Enum.ActivityId.Act306,
			episodeId = arg_11_1
		})
	end
end

function var_0_0.isEnterBforeClear(arg_12_0)
	return arg_12_0._isBeforeClear
end

var_0_0.ENTER_CHESS_GAME_BLOCK_KEY = "JiaLaBoNaController.ENTER_CHESS_GAME_BLOCK_KEY"

function var_0_0.enterChessGame(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	UIBlockMgr.instance:startBlock(var_0_0.ENTER_CHESS_GAME_BLOCK_KEY)

	arg_13_0._waitActId = arg_13_1
	arg_13_0._waitEpisodeId = arg_13_2
	arg_13_0._isBeforeClear = Activity120Model.instance:isEpisodeClear(arg_13_2)

	Activity120Model.instance:setCurEpisodeId(arg_13_2)
	TaskDispatcher.cancelTask(arg_13_0._onEnterChessGame, arg_13_0, arg_13_3)
	TaskDispatcher.runDelay(arg_13_0._onEnterChessGame, arg_13_0, arg_13_3 or 0.1)
end

function var_0_0._onEnterChessGame(arg_14_0)
	UIBlockMgr.instance:endBlock(var_0_0.ENTER_CHESS_GAME_BLOCK_KEY)

	if arg_14_0._waitActId and arg_14_0._waitEpisodeId then
		Activity120Rpc.instance:sendActStartEpisodeRequest(arg_14_0._waitActId, arg_14_0._waitEpisodeId, arg_14_0._onOpenGame, arg_14_0)
	end
end

function var_0_0.resetStartGame(arg_15_0)
	local var_15_0 = Va3ChessModel.instance:getEpisodeId()
	local var_15_1 = Va3ChessModel.instance:getActId()

	if var_15_1 and var_15_0 then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		Activity120Rpc.instance:sendActStartEpisodeRequest(var_15_1, var_15_0, arg_15_0._onRestartCallback, arg_15_0)
	end
end

var_0_0.RETURN_POINT_GAME_BLOCK_KEY = "JiaLaBoNaController.RETURN_POINT_GAME_BLOCK_KEY"

function var_0_0.returnPointGame(arg_16_0, arg_16_1)
	UIBlockMgr.instance:startBlock(var_0_0.RETURN_POINT_GAME_BLOCK_KEY)

	arg_16_0._isLastCheckPoint = arg_16_1

	local var_16_0 = Va3ChessModel.instance:getActId()

	if var_16_0 then
		Activity120Rpc.instance:sendActCheckPointRequest(var_16_0, arg_16_1, arg_16_0._onReurnPiontGame, arg_16_0)
	end
end

function var_0_0._onRestartCallback(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_2 == 0 then
		Va3ChessController.onOpenGameStoryPlayOver()
		Stat1_3Controller.instance:jiaLaBoNaStatStart()
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameReset)
	else
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	end
end

function var_0_0._onReurnPiontGame(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	UIBlockMgr.instance:endBlock(var_0_0.RETURN_POINT_GAME_BLOCK_KEY)

	if arg_18_2 ~= 0 then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	elseif arg_18_0._isLastCheckPoint then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(arg_18_0._eventReurnPiontGame, arg_18_0, JiaLaBoNaEnum.AnimatorTime.SwithSceneOpen)
		ViewMgr.instance:closeView(ViewName.JiaLaBoNaGameResultView)
	else
		arg_18_0:_eventReurnPiontGame()
	end
end

function var_0_0._eventReurnPiontGame(arg_19_0)
	var_0_0.instance:dispatchEvent(JiaLaBoNaEvent.GamePointReturn)
end

function var_0_0._onOpenGame(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 == 0 then
		Activity120Model.instance:increaseCount(arg_20_3.map.id)
		Va3ChessController.instance:initMapData(arg_20_3.activityId, arg_20_3.map)
		Va3ChessGameController.instance:setViewName(ViewName.JiaLaBoNaGameView)
		Stat1_3Controller.instance:jiaLaBoNaStatStart()
		Va3ChessController.instance:openGameView(arg_20_1, arg_20_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
