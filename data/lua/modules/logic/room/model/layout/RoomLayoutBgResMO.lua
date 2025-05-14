module("modules.logic.room.model.layout.RoomLayoutBgResMO", package.seeall)

local var_0_0 = pureTable("RoomLayoutBgResMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.config = arg_1_2
end

function var_0_0.getName(arg_2_0)
	return arg_2_0.config and arg_2_0.config.name
end

function var_0_0.getResPath(arg_3_0)
	return arg_3_0.config and arg_3_0.config.coverResPath
end

return var_0_0
