module("modules.logic.bossrush.model.v2a9.V2a9BossRushAssassinMO", package.seeall)

local var_0_0 = class("V2a9BossRushAssassinMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.stage = arg_1_2
	arg_1_0.id = arg_1_1.id
	arg_1_0.count = arg_1_1.count
	arg_1_0.itemType = AssassinConfig.instance:getAssassinItemType(arg_1_0.id)
end

function var_0_0.getCount(arg_2_0)
	return arg_2_0.count
end

function var_0_0.getId(arg_3_0)
	return arg_3_0.id
end

return var_0_0
