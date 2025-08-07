module("modules.logic.sp01.odyssey.model.OdysseyMapMo", package.seeall)

local var_0_0 = pureTable("OdysseyMapMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.config = OdysseyConfig.instance:getDungeonMapConfig(arg_1_1)
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.exploreValue = arg_2_1.exploreValue
end

function var_0_0.isFullExplore(arg_3_0)
	return arg_3_0.exploreValue == 1000
end

return var_0_0
