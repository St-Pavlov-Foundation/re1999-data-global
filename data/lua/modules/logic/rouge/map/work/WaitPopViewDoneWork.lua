module("modules.logic.rouge.map.work.WaitPopViewDoneWork", package.seeall)

local var_0_0 = class("WaitPopViewDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	if not RougePopController.instance:hadPopView() then
		return arg_2_0:onDone(true)
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onPopViewDone, arg_2_0.onPopViewDone, arg_2_0)
	RougePopController.instance:tryPopView()
end

function var_0_0.onPopViewDone(arg_3_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPopViewDone, arg_3_0.onPopViewDone, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPopViewDone, arg_4_0.onPopViewDone, arg_4_0)
end

return var_0_0
