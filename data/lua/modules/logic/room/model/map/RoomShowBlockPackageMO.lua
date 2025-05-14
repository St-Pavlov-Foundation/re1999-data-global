module("modules.logic.room.model.map.RoomShowBlockPackageMO", package.seeall)

local var_0_0 = pureTable("RoomShowBlockPackageMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.packageId = arg_1_1
	arg_1_0.num = arg_1_2 or 0
	arg_1_0.rare = arg_1_3 or 0
end

return var_0_0
