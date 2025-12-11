module("modules.logic.versionactivity3_1.gaosiniao.controller.GaoSiNiaoController", package.seeall)

local var_0_0 = class("GaoSiNiaoController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._sys = GaoSiNiaoSysModel.instance
	arg_1_0._battle = GaoSiNiaoBattleModel.instance

	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	GameUtil.onDestroyViewMember(arg_2_0, "_enterFlow")
	GameUtil.onDestroyViewMember(arg_2_0, "_exitFlow")
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.enterLevelView(arg_5_0)
	GaoSiNiaoRpc.instance:sendGetAct210InfoRequest(arg_5_0._enterLevelViewOnSvrCb, arg_5_0)
end

function var_0_0._enterLevelViewOnSvrCb(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 ~= 0 then
		logError("GaoSiNiaoController:enterLevelView resultCode=" .. tostring(arg_6_2))

		return
	end

	ViewMgr.instance:openView(ViewName.V3a1_GaoSiNiao_LevelView)
end

function var_0_0.enterGame(arg_7_0, arg_7_1)
	GameUtil.onDestroyViewMember(arg_7_0, "_enterFlow")

	arg_7_0._enterFlow = GaoSiNiaoEnterFlow.New()

	local var_7_0 = arg_7_0:config():getEpisodeCO_gameId(arg_7_1)

	arg_7_0._enterFlow:registerDoneListener(arg_7_0._onEnterFlowRegisterDoneCb, arg_7_0)
	arg_7_0._enterFlow:start(arg_7_1)
end

function var_0_0._onEnterFlowRegisterDoneCb(arg_8_0)
	if not arg_8_0._enterFlow then
		return
	end

	local var_8_0 = arg_8_0._enterFlow:gameId()
	local var_8_1 = arg_8_0._enterFlow:episodeId()

	if var_8_0 == 0 then
		arg_8_0:exitGame(var_8_1)
	end
end

function var_0_0.completeGame(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_1 = arg_9_1 or arg_9_0._battle:episodeId()

	return GaoSiNiaoRpc.instance:sendAct210FinishEpisodeRequest(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
end

function var_0_0.exitGame(arg_10_0, arg_10_1)
	GameUtil.onDestroyViewMember(arg_10_0, "_exitFlow")

	arg_10_0._exitFlow = GaoSiNiaoExitFlow.New()

	arg_10_0._exitFlow:start(arg_10_1)
end

function var_0_0.actId(arg_11_0)
	return arg_11_0._sys:actId()
end

function var_0_0.taskType(arg_12_0)
	return arg_12_0._sys:taskType()
end

function var_0_0.config(arg_13_0)
	return arg_13_0._sys:config()
end

var_0_0.instance = var_0_0.New()

return var_0_0
