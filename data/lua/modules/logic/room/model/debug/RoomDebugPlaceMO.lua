module("modules.logic.room.model.debug.RoomDebugPlaceMO", package.seeall)

local var_0_0 = pureTable("RoomDebugPlaceMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.defineId = arg_1_1.id
	arg_1_0.blockId = arg_1_1.blockId
	arg_1_0.config = RoomConfig.instance:getBlockDefineConfig(arg_1_0.defineId)
end

return var_0_0
