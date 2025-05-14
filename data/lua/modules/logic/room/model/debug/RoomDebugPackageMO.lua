module("modules.logic.room.model.debug.RoomDebugPackageMO", package.seeall)

local var_0_0 = pureTable("RoomDebugPackageMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.blockId = arg_1_1.id
	arg_1_0.packageId = arg_1_1.packageId
	arg_1_0.packageOrder = arg_1_1.packageOrder
	arg_1_0.defineId = arg_1_1.defineId
	arg_1_0.config = RoomConfig.instance:getBlockDefineConfig(arg_1_0.defineId)
end

return var_0_0
