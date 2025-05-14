module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessDieStep", package.seeall)

local var_0_0 = class("EliminateChessDieStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.x
	local var_1_1 = arg_1_0._data.y

	arg_1_0.resourceIds = arg_1_0._data.resourceIds

	local var_1_2 = arg_1_0._data.source

	arg_1_0.chess = EliminateChessItemController.instance:getChessItem(var_1_0, var_1_1)

	if not arg_1_0.chess then
		logError("步骤 Die 棋子：" .. var_1_0, var_1_1 .. "不存在")
		arg_1_0:onDone(true)

		return
	end

	arg_1_0.chess:toDie(EliminateEnum.AniTime.Die, var_1_2)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateEnum.DieStepTime)
	TaskDispatcher.runDelay(arg_1_0._playFly, arg_1_0, EliminateEnum.DieToFlyOffsetTime)
end

function var_0_0._playFly(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._playFly, arg_2_0)

	if arg_2_0.chess ~= nil and arg_2_0.resourceIds ~= nil then
		arg_2_0.chess:toFlyResource(arg_2_0.resourceIds)
	end
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._playFly, arg_3_0)
	var_0_0.super.clearWork(arg_3_0)
end

return var_0_0
