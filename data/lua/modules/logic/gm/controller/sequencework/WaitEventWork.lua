module("modules.logic.gm.controller.sequencework.WaitEventWork", package.seeall)

local var_0_0 = class("WaitEventWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	local var_1_0 = string.split(arg_1_1, ";")
	local var_1_1 = var_1_0[1]
	local var_1_2 = var_1_0[2]
	local var_1_3 = var_1_0[3]

	arg_1_0._param = var_1_0[4]
	arg_1_0._controller = _G[var_1_1]

	if not arg_1_0._controller then
		logError("WaitEventWork controllerName error:" .. tostring(var_1_1))

		return
	end

	arg_1_0._eventModule = _G[var_1_2]

	if not arg_1_0._eventModule then
		logError("WaitEventWork eventModuleName error:" .. tostring(var_1_2))

		return
	end

	arg_1_0._eventName = arg_1_0._eventModule[var_1_3]

	if not arg_1_0._eventName then
		logError("WaitEventWork eventName error:" .. tostring(var_1_3))

		return
	end
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._controller.instance:registerCallback(arg_2_0._eventName, arg_2_0._onReceiveEvent, arg_2_0)
end

function var_0_0._onReceiveEvent(arg_3_0, arg_3_1)
	local var_3_0 = type(arg_3_1)

	if var_3_0 == "number" then
		arg_3_1 = tostring(arg_3_1)
	elseif var_3_0 == "boolean" then
		arg_3_1 = tostring(arg_3_1)
	end

	if arg_3_0._param and arg_3_0._param ~= arg_3_1 then
		return
	end

	arg_3_0._controller.instance:unregisterCallback(arg_3_0._eventName, arg_3_0._onReceiveEvent, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._controller then
		arg_4_0._controller.instance:unregisterCallback(arg_4_0._eventName, arg_4_0._onReceiveEvent, arg_4_0)
	end
end

return var_0_0
