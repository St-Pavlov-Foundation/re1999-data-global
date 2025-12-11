module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_JustCompleteGame", package.seeall)

local var_0_0 = class("GaoSiNiaoWork_JustCompleteGame", GaoSiNiaoWorkBase)

function var_0_0.s_create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0._episodeId = arg_1_0

	return var_1_0
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:clearWork()
	GaoSiNiaoController.instance:completeGame(arg_2_0._episodeId, nil, arg_2_0._onCompleteGameDone, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._onTimeout, arg_2_0, 10)
end

function var_0_0._onCompleteGameDone(arg_3_0)
	GaoSiNiaoBattleModel.instance:setServerCompleted(true, arg_3_0._episodeId)
	arg_3_0:onSucc()
end

function var_0_0._onTimeout(arg_4_0)
	arg_4_0:onFail()
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onTimeout, arg_5_0)
	var_0_0.super.clearWork(arg_5_0)
end

return var_0_0
