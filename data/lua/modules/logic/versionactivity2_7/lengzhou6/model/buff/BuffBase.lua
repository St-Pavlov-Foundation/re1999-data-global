module("modules.logic.versionactivity2_7.lengzhou6.model.buff.BuffBase", package.seeall)

local var_0_0 = class("BuffBase")

function var_0_0.ctor(arg_1_0)
	arg_1_0._id = 0
	arg_1_0._configId = 0
	arg_1_0._layerCount = 0
	arg_1_0._addLimit = 1
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._id = arg_2_1
	arg_2_0.config = LengZhou6Config.instance:getEliminateBattleBuff(arg_2_2)
	arg_2_0._addLimit = arg_2_0.config.limit
	arg_2_0._configId = arg_2_2
	arg_2_0._triggerPoint = arg_2_0.config.triggerPoint
	arg_2_0._layerCount = 1
	arg_2_0._effect = arg_2_0.config.effect
end

function var_0_0.getBuffEffect(arg_3_0)
	return arg_3_0._effect
end

function var_0_0.getLayerCount(arg_4_0)
	return arg_4_0._layerCount
end

function var_0_0.addCount(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._layerCount + arg_5_1

	arg_5_0._layerCount = math.max(0, math.min(var_5_0, arg_5_0._addLimit))
end

function var_0_0.execute(arg_6_0)
	return true
end

return var_0_0
