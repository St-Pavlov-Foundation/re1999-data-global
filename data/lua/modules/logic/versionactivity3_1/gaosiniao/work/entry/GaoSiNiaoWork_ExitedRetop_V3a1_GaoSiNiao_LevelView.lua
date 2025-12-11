module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView", package.seeall)

local var_0_0 = class("GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView", GaoSiNiaoEntryFlow_WorkBase)
local var_0_1 = ViewName.V3a1_GaoSiNiao_LevelView

function var_0_0._getV3a1_GaoSiNiao_LevelViewObj(arg_1_0)
	local var_1_0 = ViewMgr.instance:getContainer(var_0_1)

	if not var_1_0 then
		return nil
	end

	return var_1_0:mainView()
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:clearWork()

	local var_2_0 = arg_2_0:_getV3a1_GaoSiNiao_LevelViewObj()

	if not var_2_0 then
		logWarn("viewObj is invalid")

		return arg_2_0:onSucc()
	end

	if not GaoSiNiaoBattleModel.instance:isServerCompleted() then
		return arg_2_0:onSucc()
	end

	var_2_0:setActive_btnEndlessGo(false)

	local var_2_1 = V3a1_GaoSiNiao_LevelView_OpenFinishFlow.New()

	arg_2_0:insertWork(GaoSiNiaoWork_WaitFlowDone.s_create(var_2_1, var_2_0))
	arg_2_0:onSucc()
end

return var_0_0
