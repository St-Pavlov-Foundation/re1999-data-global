module("modules.logic.scene.room.work.RoomSceneWaitAStarWork", package.seeall)

local var_0_0 = class("RoomSceneWaitAStarWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._scene = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._isLoadingFinish = false

	TaskDispatcher.runDelay(arg_2_0._overtime, arg_2_0, 30)
	TaskDispatcher.runRepeat(arg_2_0._onUpdate, arg_2_0, 0)
	arg_2_0:_logState()
end

function var_0_0._onUpdate(arg_3_0)
	arg_3_0:_logState()

	if not arg_3_0._scene.loader:isLoaderInProgress() and (not RoomEnum.UseAStarPath or not ZProj.AStarPathBridge.IsAStarInProgress()) then
		arg_3_0:_finish()
	else
		logNormal("RoomSceneWaitAStarWork: waiting")
	end
end

function var_0_0._logState(arg_4_0)
	local var_4_0 = arg_4_0._scene.loader:isLoaderInProgress() and "true" or "false"
	local var_4_1 = ZProj.AStarPathBridge.IsAStarInProgress() and "true" or "false"

	RoomHelper.logElapse(string.format("loading = %s, scaning = %s", var_4_0, var_4_1))
end

function var_0_0._overtime(arg_5_0)
	logError("RoomSceneWaitAStarWork: 超时, 直接进场景")
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomEnterLoadingTimeOut, MsgBoxEnum.BoxType.Yes, function()
		if not arg_5_0._isLoadingFinish then
			TaskDispatcher.runDelay(arg_5_0._overtime, arg_5_0, 30)
		end
	end)
end

function var_0_0._finish(arg_7_0)
	logNormal("RoomSceneWaitAStarWork: finish")

	arg_7_0._isLoadingFinish = true

	TaskDispatcher.cancelTask(arg_7_0._overtime, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._onUpdate, arg_7_0)

	arg_7_0._scene = nil

	arg_7_0:onDone(true)
end

function var_0_0.clearWork(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._overtime, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onUpdate, arg_8_0)

	arg_8_0._scene = nil
end

return var_0_0
