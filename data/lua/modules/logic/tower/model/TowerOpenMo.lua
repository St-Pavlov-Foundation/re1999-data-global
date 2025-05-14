module("modules.logic.tower.model.TowerOpenMo", package.seeall)

local var_0_0 = pureTable("TowerOpenMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.type = arg_2_1.type
	arg_2_0.towerId = arg_2_1.towerId
	arg_2_0.id = arg_2_1.towerId
	arg_2_0.status = arg_2_1.status
	arg_2_0.round = arg_2_1.round
	arg_2_0.nextTime = arg_2_1.nextTime
end

return var_0_0
