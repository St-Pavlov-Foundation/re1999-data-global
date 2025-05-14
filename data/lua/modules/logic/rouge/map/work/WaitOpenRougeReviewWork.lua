module("modules.logic.rouge.map.work.WaitOpenRougeReviewWork", package.seeall)

local var_0_0 = class("WaitOpenRougeReviewWork", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = RougeModel.instance:getRougeResult()

	if (var_1_0 and var_1_0.finalScore or 0) <= 0 then
		return arg_1_0:onDone(true)
	end

	arg_1_0.flow = FlowSequence.New()

	arg_1_0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeResultReView))
	arg_1_0.flow:registerDoneListener(arg_1_0._onFlowDone, arg_1_0)
	arg_1_0.flow:start()
end

function var_0_0._onFlowDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0.flow then
		arg_3_0.flow:destroy()

		arg_3_0.flow = nil
	end
end

return var_0_0
