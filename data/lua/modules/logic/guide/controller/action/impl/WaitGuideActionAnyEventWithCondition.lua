module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyEventWithCondition", package.seeall)

local var_0_0 = class("WaitGuideActionAnyEventWithCondition", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]

	if arg_1_0:commonCheck(var_1_1) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_2 = var_1_0[2]
	local var_1_3 = var_1_0[3]
	local var_1_4 = var_1_0[4]

	arg_1_0._param = var_1_0[5]
	arg_1_0._controller = _G[var_1_2]

	if not arg_1_0._controller then
		logError("WaitGuideActionAnyEventWithCondition controllerName error:" .. tostring(var_1_2))

		return
	end

	arg_1_0._eventModule = _G[var_1_3]

	if not arg_1_0._eventModule then
		logError("WaitGuideActionAnyEventWithCondition eventModuleName error:" .. tostring(var_1_3))

		return
	end

	arg_1_0._eventName = arg_1_0._eventModule[var_1_4]

	if not arg_1_0._eventName then
		logError("WaitGuideActionAnyEventWithCondition eventName error:" .. tostring(var_1_4))

		return
	end

	arg_1_0._controller.instance:registerCallback(arg_1_0._eventName, arg_1_0._onReceiveEvent, arg_1_0)
end

function var_0_0.commonCheck(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return false
	end

	local var_2_0 = string.split(arg_2_1, "_")
	local var_2_1 = _G[var_2_0[1]]

	if not var_2_1 then
		return false
	end

	local var_2_2 = var_2_1[var_2_0[2]]

	if not var_2_2 then
		return false
	end

	if var_2_1.instance then
		return var_2_2(var_2_1.instance, unpack(var_2_0, 3))
	else
		return var_2_2(unpack(var_2_0, 3))
	end
end

function var_0_0._onReceiveEvent(arg_3_0, arg_3_1)
	if arg_3_0:checkGuideLock() then
		return
	end

	local var_3_0 = type(arg_3_1)
	local var_3_1 = false

	if var_3_0 == "number" then
		arg_3_1 = tostring(arg_3_1)
	elseif var_3_0 == "boolean" then
		arg_3_1 = tostring(arg_3_1)
	elseif var_3_0 == "function" then
		var_3_1 = arg_3_1(arg_3_0._param)
	end

	if not var_3_1 and arg_3_0._param and arg_3_0._param ~= arg_3_1 then
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
