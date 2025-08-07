module("modules.logic.sp01.assassin2.outside.model.AssassinBuildingMO", package.seeall)

local var_0_0 = pureTable("AssassinBuildingMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:initParams(arg_1_1.type, arg_1_1.level)
end

function var_0_0.initParams(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.type = arg_2_1
	arg_2_0.level = arg_2_2 or 0
	arg_2_0.config = AssassinConfig.instance:getBuildingLvCo(arg_2_0.type, arg_2_0.level == 0 and 1 or arg_2_0.level)
	arg_2_0.maxLevel = AssassinConfig.instance:getBuildingMaxLv(arg_2_0.type)
end

function var_0_0.getConfig(arg_3_0)
	return arg_3_0.config
end

function var_0_0.getType(arg_4_0)
	return arg_4_0.type
end

function var_0_0.getLv(arg_5_0)
	return arg_5_0.level
end

function var_0_0.isMaxLv(arg_6_0)
	return arg_6_0.level >= arg_6_0.maxLevel
end

return var_0_0
