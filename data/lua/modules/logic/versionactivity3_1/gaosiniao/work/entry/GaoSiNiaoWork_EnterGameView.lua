module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoWork_EnterGameView", package.seeall)

local var_0_0 = class("GaoSiNiaoWork_EnterGameView", GaoSiNiaoEntryFlow_WorkBase)

function var_0_0.s_create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0._viewName = arg_1_0

	return var_1_0
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:clearWork()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0)
	arg_2_0:restartBattle()

	local var_2_0 = arg_2_0._viewName

	if not ViewMgr.instance:isOpen(var_2_0) then
		ViewMgr.instance:openView(var_2_0)
	else
		arg_2_0:onSucc()
	end
end

function var_0_0._onOpenViewFinish(arg_3_0, arg_3_1)
	if arg_3_0._viewName == arg_3_1 then
		arg_3_0:onSucc()
	end
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	var_0_0.super.clearWork(arg_4_0)
end

return var_0_0
