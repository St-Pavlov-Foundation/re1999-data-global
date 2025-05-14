module("modules.logic.rouge.map.work.WaitFinishViewDoneWork", package.seeall)

local var_0_0 = class("WaitFinishViewDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.rougeFinish = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	if arg_2_0.rougeFinish then
		RougeMapController.instance:openRougeFinishView()
	else
		RougeMapController.instance:openRougeFailView()
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onFinishViewDone, arg_2_0.onFinishViewDone, arg_2_0)
end

function var_0_0.onFinishViewDone(arg_3_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onFinishViewDone, arg_3_0.onFinishViewDone, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onFinishViewDone, arg_4_0.onFinishViewDone, arg_4_0)
end

return var_0_0
