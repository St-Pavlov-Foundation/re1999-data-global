module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.ZhiXinQuanErDialogStep", package.seeall)

local var_0_0 = class("ZhiXinQuanErDialogStep", BaseWork)

function var_0_0.initData(arg_1_0, arg_1_1)
	arg_1_0._data = arg_1_1
	arg_1_0._dialogueId = tonumber(arg_1_1.param)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_0._data.param == 0 then
		return arg_2_0:onDone(true)
	end

	arg_2_0:beginPlayDialog()
end

function var_0_0.beginPlayDialog(arg_3_0)
	local var_3_0 = Activity176Config.instance:getBubbleCo(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, arg_3_0._dialogueId)

	if not var_3_0 then
		logError("纸信圈儿对话配置不存在" .. arg_3_0._dialogueId)
		arg_3_0:onDone(true)

		return
	end

	PuzzleMazeDrawController.instance:registerCallback(PuzzleEvent.OnFinishDialog, arg_3_0._onFinishDialog, arg_3_0)

	local var_3_1, var_3_2 = arg_3_0:_getDialogPos()
	local var_3_3 = {
		co = var_3_0,
		dialogPosX = var_3_1,
		dialogPosY = var_3_2
	}

	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnStartDialog, var_3_3)
end

function var_0_0._getDialogPos(arg_4_0)
	local var_4_0, var_4_1 = PuzzleMazeDrawController.instance:getLastPos()
	local var_4_2, var_4_3 = PuzzleMazeDrawModel.instance:getObjectAnchor(var_4_0, var_4_1)

	return var_4_2, var_4_3 + 100
end

function var_0_0._onFinishDialog(arg_5_0)
	PuzzleMazeDrawController.instance:unregisterAllCallback(PuzzleEvent.OnFinishDialog, arg_5_0._onFinishDialog, arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	PuzzleMazeDrawController.instance:unregisterCallback(PuzzleEvent.OnFinishDialog, arg_6_0._onFinishDialog, arg_6_0)
end

return var_0_0
