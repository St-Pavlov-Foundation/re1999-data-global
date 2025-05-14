module("modules.logic.guide.controller.action.impl.GuideActionDispatchEvent", package.seeall)

local var_0_0 = class("GuideActionDispatchEvent", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = var_1_0[2]
	local var_1_3 = var_1_0[3]
	local var_1_4 = var_1_0[4]

	arg_1_0._controller = getModuleDef(var_1_1)

	if not arg_1_0._controller then
		logError("GuideActionDispatchEvent controllerName error:" .. tostring(var_1_1))
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._eventModule = getModuleDef(var_1_2)

	if not arg_1_0._eventModule then
		logError("GuideActionDispatchEvent eventModuleName error:" .. tostring(var_1_2))
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._eventName = arg_1_0._eventModule[var_1_3]

	if not arg_1_0._eventName then
		logError("GuideActionDispatchEvent eventName error:" .. tostring(var_1_3))
		arg_1_0:onDone(true)

		return
	end

	logNormal(string.format("%s dispatch %s %s param:%s", var_1_1, var_1_2, arg_1_0._eventName or "nil", var_1_4 or "nil"))
	arg_1_0._controller.instance:dispatchEvent(arg_1_0._eventName, var_1_4)
	arg_1_0:onDone(true)
end

return var_0_0
