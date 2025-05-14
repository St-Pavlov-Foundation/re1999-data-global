module("modules.logic.rouge.map.work.WaitLimiterResultViewDoneWork", package.seeall)

local var_0_0 = class("WaitLimiterResultViewDoneWork", BaseWork)

function var_0_0.onStart(arg_1_0)
	if not arg_1_0:_checkIsNeedOpenRougeLimiterResultView() then
		arg_1_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0.onCloseViewDone, arg_1_0)
	RougeDLCController101.instance:openRougeLimiterResultView()
end

function var_0_0._checkIsNeedOpenRougeLimiterResultView(arg_2_0)
	local var_2_0 = RougeModel.instance:getRougeResult()

	return (var_2_0 and var_2_0:getLimiterResultMo()) ~= nil
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0.onCloseViewDone, arg_3_0)
end

function var_0_0.onCloseViewDone(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.RougeLimiterResultView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_4_0.onCloseView, arg_4_0)
		arg_4_0:onDone(true)
	end
end

return var_0_0
