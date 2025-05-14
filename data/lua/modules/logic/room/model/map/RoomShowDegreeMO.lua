module("modules.logic.room.model.map.RoomShowDegreeMO", package.seeall)

local var_0_0 = pureTable("RoomShowDegreeMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.degreeType = arg_1_2 or 1
	arg_1_0.degree = 0
	arg_1_0.count = 0
	arg_1_0.name = arg_1_3 or ""
end

function var_0_0.getCount(arg_2_0)
	return arg_2_0.count
end

return var_0_0
