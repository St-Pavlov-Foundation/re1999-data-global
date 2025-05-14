module("modules.logic.versionactivity1_5.act142.controller.Activity142Controller", package.seeall)

local var_0_0 = class("Activity142Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0:_endBlock()
end

function var_0_0.openMapView(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._tmpOpenMapViewCb = arg_4_1
	arg_4_0._tmpOpenMapViewCbObj = arg_4_2
	arg_4_0._tmpOpenMapViewCbParam = arg_4_3

	local var_4_0 = Activity142Model.instance:getActivityId()

	Va3ChessRpcController.instance:sendGetActInfoRequest(var_4_0, arg_4_0._onOpenMapViewGetActInfoCb, arg_4_0)
end

function var_0_0._onOpenMapViewGetActInfoCb(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		return
	end

	local var_5_0 = Activity142Model.instance:getActivityId()
	local var_5_1 = Activity142Model.instance:isEpisodeOpen(var_5_0, Activity142Enum.AUTO_ENTER_EPISODE_ID)
	local var_5_2 = Activity142Model.instance:isEpisodeClear(Activity142Enum.AUTO_ENTER_EPISODE_ID)

	if var_5_1 and not var_5_2 then
		arg_5_0:enterChessGame(Activity142Enum.AUTO_ENTER_EPISODE_ID, arg_5_0._realOpenMapView, arg_5_0)
	else
		arg_5_0:_realOpenMapView()
	end
end

function var_0_0._realOpenMapView(arg_6_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity142
	})
	ViewMgr.instance:openView(ViewName.Activity142MapView, nil, true)

	if arg_6_0._tmpOpenMapViewCb then
		arg_6_0._tmpOpenMapViewCb(arg_6_0._tmpOpenMapViewCbObj, arg_6_0._tmpOpenMapViewCbParam)
	end

	arg_6_0._tmpOpenMapViewCb = nil
	arg_6_0._tmpOpenMapViewCbObj = nil
	arg_6_0._tmpOpenMapViewCbParam = nil
end

function var_0_0.openStoryView(arg_7_0, arg_7_1)
	if Activity142Model.instance:isEpisodeClear(arg_7_1) then
		local var_7_0 = Activity142Model.instance:getActivityId()

		if var_7_0 then
			ViewMgr.instance:openView(ViewName.Activity142StoryView, {
				actId = var_7_0,
				episodeId = arg_7_1
			})
		end
	end
end

function var_0_0.enterChessGame(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	Va3ChessGameModel.instance:clearLastMapRound()

	local var_8_0 = Activity142Model.instance:getActivityId()

	Va3ChessModel.instance:setActId(var_8_0)
	Activity142Model.instance:setCurEpisodeId(arg_8_1)
	Activity142Helper.setAct142UIBlock(true)
	Va3ChessController.instance:startNewEpisode(arg_8_1, arg_8_0._afterEnterChessGame, arg_8_0, ViewName.Activity142GameView, arg_8_2, arg_8_3)

	if not Va3ChessConfig.instance:isStoryEpisode(var_8_0, arg_8_1) then
		Activity142StatController.instance:statStart()
	end
end

function var_0_0._afterEnterChessGame(arg_9_0)
	arg_9_0:_endBlock()
end

function var_0_0._endBlock(arg_10_0)
	Activity142Helper.setAct142UIBlock(false)
end

function var_0_0.act142Back2CheckPoint(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = Activity142Model.instance:getActivityId()

	Activity142Rpc.instance:sendAct142CheckPointRequest(var_11_0, true, arg_11_1, arg_11_2)
end

function var_0_0.act142ResetGame(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = Va3ChessModel.instance:getEpisodeId()

	if not var_12_0 then
		return
	end

	arg_12_0._tmpResetCallback = arg_12_1
	arg_12_0._tmpResetCallbackObj = arg_12_2

	local var_12_1 = Activity142Model.instance:getActivityId()

	Va3ChessModel.instance:setActId(var_12_1)
	Va3ChessGameModel.instance:clearLastMapRound()
	Va3ChessController.instance:startResetEpisode(var_12_0, arg_12_0._act142ResetCallback, arg_12_0, ViewName.Activity142GameView)
end

function var_0_0._act142ResetCallback(arg_13_0)
	if arg_13_0._tmpResetCallback then
		arg_13_0._tmpResetCallback(arg_13_0._tmpResetCallbackObj)

		arg_13_0._tmpResetCallback = nil
		arg_13_0._tmpResetCallbackObj = nil
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameReset)
end

function var_0_0.delayRequestGetReward(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._tmpTaskMO == nil and arg_14_2 then
		arg_14_0._tmpTaskMO = arg_14_2

		TaskDispatcher.runDelay(arg_14_0.requestGetReward, arg_14_0, arg_14_1)
	end
end

function var_0_0.requestGetReward(arg_15_0)
	if arg_15_0._tmpTaskMO == nil then
		return
	end

	if arg_15_0._tmpTaskMO.id == Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity142)
	elseif arg_15_0._tmpTaskMO:haveRewardToGet() then
		TaskRpc.instance:sendFinishTaskRequest(arg_15_0._tmpTaskMO.id)
	end

	arg_15_0._tmpTaskMO = nil
end

function var_0_0.dispatchAllTaskItemGotReward(arg_16_0)
	arg_16_0:dispatchEvent(Activity142Event.OneClickClaimReward)
end

function var_0_0.setPlayedUnlockAni(arg_17_0, arg_17_1)
	local var_17_0 = Activity142Model.instance:getPlayerCacheData()

	if not var_17_0 then
		return
	end

	var_17_0[arg_17_1] = true

	Activity142Model.instance:saveCacheData()
end

function var_0_0.havePlayedUnlockAni(arg_18_0, arg_18_1)
	local var_18_0 = false

	if not arg_18_1 then
		return var_18_0
	end

	local var_18_1 = Activity142Model.instance:getPlayerCacheData()

	if not var_18_1 then
		return var_18_0
	end

	return var_18_1[arg_18_1] or false
end

var_0_0.instance = var_0_0.New()

return var_0_0
