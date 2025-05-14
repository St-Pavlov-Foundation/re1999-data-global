module("modules.logic.versionactivity1_5.aizila.model.AiZiLaItemMO", package.seeall)

local var_0_0 = pureTable("AiZiLaItemMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.uid = arg_1_1
	arg_1_0.itemId = arg_1_2 or 0
	arg_1_0.quantity = arg_1_3 or 0
end

function var_0_0.getConfig(arg_2_0)
	if not arg_2_0._config then
		arg_2_0._config = AiZiLaConfig.instance:getItemCo(arg_2_0.itemId)
	end

	return arg_2_0._config
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0.itemId = arg_3_1.itemId
	arg_3_0.quantity = arg_3_1.quantity
end

function var_0_0.addInfo(arg_4_0, arg_4_1)
	if arg_4_0.itemId == arg_4_1.itemId then
		arg_4_0.quantity = arg_4_0.quantity + arg_4_1.quantity
	end
end

function var_0_0.getQuantity(arg_5_0)
	return arg_5_0.quantity
end

return var_0_0
