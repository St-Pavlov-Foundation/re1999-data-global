module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_WaitViewOnTheTop", package.seeall)

local var_0_0 = class("GaoSiNiaoWork_WaitViewOnTheTop", GaoSiNiaoWorkBase)

function var_0_0.s_create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0._viewName = arg_1_0
	var_1_0._ignoreViewList = arg_1_1

	return var_1_0
end

function var_0_0._checkViewOnTheTop(arg_2_0)
	return ViewHelper.instance:checkViewOnTheTop(arg_2_0._viewName, arg_2_0._ignoreViewList)
end

function var_0_0.onStart(arg_3_0)
	arg_3_0:clearWork()

	local var_3_0 = arg_3_0._viewName

	if string.nilorempty(var_3_0) then
		logWarn("viewName is invalid")
		arg_3_0:onSucc()

		return
	end

	if not ViewMgr.instance:isOpen(var_3_0) then
		logWarn("viewName is not open: " .. tostring(var_3_0))
		arg_3_0:onSucc()

		return
	end

	if arg_3_0:_checkViewOnTheTop() then
		arg_3_0:onSucc()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	end
end

function var_0_0._onCloseViewFinish(arg_4_0)
	if arg_4_0:_checkViewOnTheTop() then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
		arg_4_0:onSucc()
	end
end

function var_0_0.clearWork(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
	var_0_0.super.clearWork(arg_5_0)
end

return var_0_0
