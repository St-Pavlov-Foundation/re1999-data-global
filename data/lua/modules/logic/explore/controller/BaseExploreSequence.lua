module("modules.logic.explore.controller.BaseExploreSequence", package.seeall)

local var_0_0 = class("BaseExploreSequence")

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

function var_0_0.dispose(arg_5_0)
	if arg_5_0._sequence then
		arg_5_0._sequence:unregisterDoneListener(arg_5_0.doCallback, arg_5_0)
		arg_5_0._sequence:destroy()
	end

	arg_5_0._sequence = nil
	arg_5_0._context = nil
	arg_5_0._callback = nil
	arg_5_0._callbackObj = nil
end

function var_0_0.doCallback(arg_6_0)
	arg_6_0._sequence:unregisterDoneListener(arg_6_0.doCallback, arg_6_0)

	if arg_6_0._callback then
		if arg_6_0._callbackObj then
			arg_6_0._callback(arg_6_0._callbackObj, arg_6_0._sequence.isSuccess)
		else
			arg_6_0._callback(arg_6_0._sequence.isSuccess)
		end
	end
end

return var_0_0
