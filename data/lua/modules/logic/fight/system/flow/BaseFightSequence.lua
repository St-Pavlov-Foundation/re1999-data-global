module("modules.logic.fight.system.flow.BaseFightSequence", package.seeall)

local var_0_0 = class("BaseFightSequence")

function var_0_0.ctor(arg_1_0)
	arg_1_0._sequence = nil
end

function var_0_0.buildFlow(arg_2_0)
	if arg_2_0._sequence then
		arg_2_0._sequence:destroy()
	end

	arg_2_0._sequence = FlowSequence.New()
end

function var_0_0.addWork(arg_3_0, arg_3_1)
	arg_3_0._sequence:addWork(arg_3_1)
end

function var_0_0.start(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._callback = arg_4_1
	arg_4_0._callbackObj = arg_4_2

	arg_4_0._sequence:registerDoneListener(arg_4_0.doCallback, arg_4_0)
	arg_4_0._sequence:start({})
end

function var_0_0.stop(arg_5_0)
	if arg_5_0._sequence and arg_5_0._sequence.status == WorkStatus.Running then
		arg_5_0._sequence:stop()
	end
end

function var_0_0.isRunning(arg_6_0)
	return arg_6_0._sequence and arg_6_0._sequence.status == WorkStatus.Running
end

function var_0_0.doneRunningWork(arg_7_0)
	local var_7_0 = {}

	arg_7_0:_getRunningWorks(arg_7_0._sequence, var_7_0)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		logError("行为复现出错，work: " .. iter_7_1.__cname)
		iter_7_1:onDone(true)
	end
end

function var_0_0._getRunningWorks(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:getWorkList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1.status == WorkStatus.Running then
			if isTypeOf(iter_8_1, FlowSequence) then
				arg_8_0:_getRunningWorks(iter_8_1, arg_8_2)
			elseif isTypeOf(iter_8_1, FlowParallel) then
				arg_8_0:_getRunningWorks(iter_8_1, arg_8_2)
			else
				table.insert(arg_8_2, iter_8_1)
			end
		end
	end
end

function var_0_0.dispose(arg_9_0)
	if arg_9_0._sequence then
		arg_9_0._sequence:unregisterDoneListener(arg_9_0.doCallback, arg_9_0)
		arg_9_0._sequence:destroy()
	end

	arg_9_0._sequence = nil
	arg_9_0._context = nil
	arg_9_0._callback = nil
	arg_9_0._callbackObj = nil
end

function var_0_0.doCallback(arg_10_0)
	arg_10_0._sequence:unregisterDoneListener(arg_10_0.doCallback, arg_10_0)

	if arg_10_0._callback then
		if arg_10_0._callbackObj then
			arg_10_0._callback(arg_10_0._callbackObj)
		else
			arg_10_0._callback()
		end
	end
end

return var_0_0
