module("modules.logic.chargepush.model.ChargePushModel", package.seeall)

local var_0_0 = class("ChargePushModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	return
end

function var_0_0.onReceivePushInfo(arg_4_0, arg_4_1)
	arg_4_0:clear()

	for iter_4_0 = 1, #arg_4_1.pushId do
		arg_4_0:addPushInfo(arg_4_1.pushId[iter_4_0])
	end

	arg_4_0:sort(ChargePushMO.sortFunction)
end

function var_0_0.addPushInfo(arg_5_0, arg_5_1)
	if not arg_5_0:getById(arg_5_1) then
		local var_5_0 = ChargePushMO.New()

		var_5_0:init(arg_5_1)
		arg_5_0:addAtLast(var_5_0)
	end
end

function var_0_0.popNextPushInfo(arg_6_0)
	return (arg_6_0:removeFirst())
end

var_0_0.instance = var_0_0.New()

return var_0_0
