module("modules.logic.guide.controller.action.impl.GuideActionDispatchFightEvent", package.seeall)

local var_0_0 = class("GuideActionDispatchFightEvent", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = string.split(arg_1_3, "#")
	local var_1_1 = var_1_0[1]

	arg_1_0._evtId = FightEvent[var_1_1]
	arg_1_0._evtParamList = nil

	for iter_1_0 = 2, #var_1_0, 2 do
		local var_1_2 = var_1_0[iter_1_0]
		local var_1_3 = var_1_0[iter_1_0 + 1]

		var_1_2 = string.getValueByType(var_1_2, var_1_3) or var_1_2
		arg_1_0._evtParamList = arg_1_0._evtParamList or {}

		table.insert(arg_1_0._evtParamList, var_1_2)
	end
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	if arg_2_0._evtParamList then
		FightController.instance:dispatchEvent(arg_2_0._evtId, unpack(arg_2_0._evtParamList))
	else
		FightController.instance:dispatchEvent(arg_2_0._evtId)
	end

	arg_2_0:onDone(true)
end

return var_0_0
