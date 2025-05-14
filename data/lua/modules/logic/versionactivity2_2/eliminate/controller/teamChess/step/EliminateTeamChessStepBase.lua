module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessStepBase", package.seeall)

local var_0_0 = class("EliminateTeamChessStepBase", BaseWork)

function var_0_0.initData(arg_1_0, arg_1_1)
	arg_1_0._data = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._onDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onDone, arg_4_0)
end

return var_0_0
