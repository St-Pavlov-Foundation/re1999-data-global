module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoEntryFlow_WorkBase", package.seeall)

local var_0_0 = class("GaoSiNiaoEntryFlow_WorkBase", GaoSiNiaoWorkBase)

function var_0_0.episodeId(arg_1_0)
	return arg_1_0.root:episodeId()
end

function var_0_0.restartBattle(arg_2_0)
	GaoSiNiaoBattleModel.instance:restart(arg_2_0:episodeId())
end

function var_0_0.insertWork(arg_3_0, arg_3_1)
	return arg_3_0.root:insertWork(arg_3_1)
end

return var_0_0
