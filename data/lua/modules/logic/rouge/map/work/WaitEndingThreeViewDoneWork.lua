module("modules.logic.rouge.map.work.WaitEndingThreeViewDoneWork", package.seeall)

local var_0_0 = class("WaitEndingThreeViewDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.endId = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	if arg_2_0.endId ~= RougeEnum.EndingThreeId then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = RougeModel.instance:getRougeResult()

	if not (var_2_0 and var_2_0:isSucceed()) then
		arg_2_0:onDone(true)
	end

	arg_2_0.flow = FlowSequence.New()

	arg_2_0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeEndingThreeView))
	arg_2_0.flow:registerDoneListener(arg_2_0.onFlowDone, arg_2_0)
	arg_2_0.flow:start()
end

function var_0_0.onFlowDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0.flow then
		arg_4_0.flow:onDestroy()

		arg_4_0.flow = nil
	end
end

return var_0_0
