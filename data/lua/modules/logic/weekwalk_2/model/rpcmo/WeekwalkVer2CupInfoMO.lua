module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2CupInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2CupInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.result = arg_1_1.result
	arg_1_0.config = lua_weekwalk_ver2_cup.configDict[arg_1_0.id]
	arg_1_0.index = arg_1_0.config.cupNo
end

return var_0_0
