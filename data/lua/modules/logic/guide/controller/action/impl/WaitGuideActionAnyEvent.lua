module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyEvent", package.seeall)

local var_0_0 = class("WaitGuideActionAnyEvent", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = var_1_0[2]
	local var_1_3 = var_1_0[3]

	arg_1_0._param = var_1_0[4]
	arg_1_0._controller = _G[var_1_1]

	if not arg_1_0._controller then
		logError("WaitGuideActionAnyEvent controllerName error:" .. tostring(var_1_1))

		return
	end

	arg_1_0._eventModule = _G[var_1_2]

	if not arg_1_0._eventModule then
		logError("WaitGuideActionAnyEvent eventModuleName error:" .. tostring(var_1_2))

		return
	end

	arg_1_0._eventName = arg_1_0._eventModule[var_1_3]

	if not arg_1_0._eventName then
		logError("WaitGuideActionAnyEvent eventName error:" .. tostring(var_1_3))

		return
	end

	arg_1_0._controller.instance:registerCallback(arg_1_0._eventName, arg_1_0._onReceiveEvent, arg_1_0)
end

function var_0_0._onReceiveEvent(arg_2_0, arg_2_1)
	if arg_2_0:checkGuideLock() then
		return
	end

	local var_2_0 = type(arg_2_1)
	local var_2_1 = false

	if var_2_0 == "number" then
		arg_2_1 = tostring(arg_2_1)
	elseif var_2_0 == "boolean" then
		arg_2_1 = tostring(arg_2_1)
	elseif var_2_0 == "function" then
		var_2_1 = arg_2_1(arg_2_0._param)
	end

	if not var_2_1 and arg_2_0._param and arg_2_0._param ~= arg_2_1 then
		return
	end

	arg_2_0._controller.instance:unregisterCallback(arg_2_0._eventName, arg_2_0._onReceiveEvent, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._controller then
		arg_3_0._controller.instance:unregisterCallback(arg_3_0._eventName, arg_3_0._onReceiveEvent, arg_3_0)
	end
end

return var_0_0
