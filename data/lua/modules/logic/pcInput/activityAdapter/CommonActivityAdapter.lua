module("modules.logic.pcInput.activityAdapter.CommonActivityAdapter", package.seeall)

local var_0_0 = class("CommonActivityAdapter", BaseActivityAdapter)

var_0_0.keytoFunction = {
	Esc = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyCommonCancel)
	end,
	Return = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyCommonConfirm)
	end
}

function var_0_0.ctor(arg_3_0)
	arg_3_0.keytoFunction = var_0_0.keytoFunction
	arg_3_0._priorty = 1

	arg_3_0:registerFunction()
end

function var_0_0.registerFunction(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.keytoFunction) do
		PCInputController.instance:registerKey(iter_4_0, ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function var_0_0.unRegisterFunction(arg_5_0)
	return
end

function var_0_0.OnkeyUp(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.keytoFunction[arg_6_1]

	if var_6_0 then
		var_6_0()

		return true
	end

	return false
end

function var_0_0.OnkeyDown(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.keytoFunction[arg_7_1]

	if var_7_0 then
		var_7_0()

		return true
	end

	return false
end

function var_0_0.destroy(arg_8_0)
	arg_8_0:unRegisterFunction()
end

return var_0_0
