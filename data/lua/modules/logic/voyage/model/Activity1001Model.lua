module("modules.logic.voyage.model.Activity1001Model", package.seeall)

local var_0_0 = class("Activity1001Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.__activityId = false
	arg_2_0.__config = false
	arg_2_0.__id2StateDict = {}
end

function var_0_0._internal_set_activity(arg_3_0, arg_3_1)
	arg_3_0.__activityId = arg_3_1
end

function var_0_0._internal_set_config(arg_4_0, arg_4_1)
	assert(isTypeOf(arg_4_1, Activity1001Config), debug.traceback())

	arg_4_0.__config = arg_4_1
end

function var_0_0.getConfig(arg_5_0)
	return assert(arg_5_0.__config, "pleaes call self:_internal_set_config(config) first")
end

function var_0_0._updateInfo(arg_6_0, arg_6_1)
	arg_6_0.__id2StateDict[arg_6_1.id] = arg_6_1.state
end

function var_0_0.onReceiveAct1001GetInfoReply(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1.act1001Infos) do
		arg_7_0:_updateInfo(iter_7_1)
	end
end

function var_0_0.onReceiveAct1001UpdatePush(arg_8_0, arg_8_1)
	arg_8_0:_updateInfo(arg_8_1)
end

function var_0_0.getStateById(arg_9_0, arg_9_1)
	return arg_9_0.__id2StateDict[arg_9_1] or VoyageEnum.State.None
end

return var_0_0
