module("modules.logic.explore.controller.trigger.ExploreTriggerBase", package.seeall)

local var_0_0 = class("ExploreTriggerBase", BaseWork)

function var_0_0.onStart(arg_1_0)
	if arg_1_0.isCancel then
		arg_1_0:cancel(arg_1_0._param, arg_1_0._unit)
	else
		arg_1_0:handle(arg_1_0._param, arg_1_0._unit)
	end
end

function var_0_0.setParam(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0._recordLen = 0
	arg_2_0._param = arg_2_1
	arg_2_0._unit = arg_2_2
	arg_2_0.unitId = arg_2_2.id
	arg_2_0.unitType = arg_2_0._unit:getUnitType()
	arg_2_0.stepIndex = arg_2_3
	arg_2_0.clientOnly = arg_2_4
	arg_2_0.isCancel = arg_2_5
end

function var_0_0.onReply(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:onDone(true)
end

function var_0_0.sendTriggerRequest(arg_4_0, arg_4_1)
	if not arg_4_0.stepIndex then
		arg_4_0:onDone(false)

		return
	end

	ExploreRpc.instance:sendExploreInteractRequest(arg_4_0.unitId, arg_4_0.stepIndex, arg_4_1 or "", arg_4_0.onRequestCallBack, arg_4_0)
end

function var_0_0.onRequestCallBack(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == 0 then
		arg_5_0:onReply(arg_5_1, arg_5_2, arg_5_3)
	else
		arg_5_0:onDone(false)
	end
end

function var_0_0.onStepDone(arg_6_0, arg_6_1)
	arg_6_0:onDone(arg_6_1)
end

function var_0_0.handle(arg_7_0)
	arg_7_0:onDone(true)
end

function var_0_0.cancel(arg_8_0)
	arg_8_0:onDone(true)
end

return var_0_0
