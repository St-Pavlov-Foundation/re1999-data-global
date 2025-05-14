module("modules.logic.signin.controller.work.CheckSignInViewWork_1_3", package.seeall)

local var_0_0 = class("CheckSignInViewWork_1_3", BaseWork)

function var_0_0.onStart(arg_1_0)
	arg_1_0._funcs = {}

	SignInController.instance:registerCallback(SignInEvent.OnSignInPopupFlowUpdate, arg_1_0._onSignInPopupFlowUpdate, arg_1_0)
end

function var_0_0._removeSingleEvent(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._funcs[arg_2_1]

	if var_2_0 then
		SignInController.instance:unregisterCallback(arg_2_1, var_2_0, arg_2_0)

		arg_2_0._funcs[arg_2_1] = nil
	end

	if not next(arg_2_0._funcs) then
		arg_2_0:_startBlock()
		arg_2_0:onDone(true)
	end
end

function var_0_0._onSignInPopupFlowUpdate(arg_3_0, arg_3_1)
	if arg_3_1 == false then
		arg_3_0:_clear()
		arg_3_0:onDone(true)

		return
	end

	if arg_3_1 == nil then
		logError("impossible ?!")

		return
	end

	if arg_3_0._funcs[arg_3_1] then
		return
	end

	local var_3_0 = string.format("__internal_%s", arg_3_1)

	arg_3_0[var_3_0] = function()
		arg_3_0:_removeSingleEvent(arg_3_1)
	end
	arg_3_0._funcs[arg_3_1] = arg_3_0[var_3_0]

	SignInController.instance:registerCallback(arg_3_1, arg_3_0[var_3_0], arg_3_0)
end

function var_0_0._clear(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._funcs) do
		SignInController.instance:unregisterCallback(iter_5_0, iter_5_1, arg_5_0)
	end

	arg_5_0._funcs = {}
end

function var_0_0.clearWork(arg_6_0)
	if not arg_6_0.isSuccess then
		arg_6_0:_endBlock()
	end

	arg_6_0:_clear()
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInPopupFlowUpdate, arg_6_0._onSignInPopupFlowUpdate, arg_6_0)
end

function var_0_0._endBlock(arg_7_0)
	if not arg_7_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function var_0_0._startBlock(arg_8_0)
	if arg_8_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function var_0_0._isBlock(arg_9_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

return var_0_0
