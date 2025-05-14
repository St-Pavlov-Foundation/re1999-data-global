module("modules.logic.pcInput.activityAdapter.BaseActivityAdapter", package.seeall)

local var_0_0 = class("BaseActivityAdapter")

function var_0_0.ctor(arg_1_0)
	arg_1_0.keytoFunction = {}
	arg_1_0.activitid = nil
	arg_1_0._registeredKey = {}
	arg_1_0._priorty = 0
end

function var_0_0.getPriorty(arg_2_0)
	return arg_2_0._priorty or 0
end

function var_0_0.registerFunction(arg_3_0)
	local var_3_0 = PCInputModel.instance:getActivityKeys(arg_3_0.activitid)

	if not var_3_0 then
		return
	end

	arg_3_0._registeredKey = var_3_0

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		PCInputController.instance:registerKey(iter_3_1[4], ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function var_0_0.unRegisterFunction(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._registeredKey) do
		PCInputController.instance:unregisterKey(iter_4_1[4], ZProj.PCInputManager.PCInputEvent.KeyUp)
	end

	arg_4_0._registeredKey = {}
end

function var_0_0.OnkeyUp(arg_5_0, arg_5_1)
	local var_5_0 = PCInputModel.instance:getkeyidBykeyName(arg_5_0.activitid, arg_5_1)

	if not var_5_0 then
		return
	end

	local var_5_1 = arg_5_0.keytoFunction[var_5_0]

	if var_5_1 then
		var_5_1()
	end
end

function var_0_0.OnkeyDown(arg_6_0, arg_6_1)
	local var_6_0 = PCInputModel.instance:getkeyidBykeyName(arg_6_0.activitid, arg_6_1)

	if not var_6_0 then
		return
	end

	local var_6_1 = arg_6_0.keytoFunction[var_6_0]

	if var_6_1 then
		var_6_1()
	end
end

function var_0_0.destroy(arg_7_0)
	arg_7_0:unRegisterFunction()
end

return var_0_0
