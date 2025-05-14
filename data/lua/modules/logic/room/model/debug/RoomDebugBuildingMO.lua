module("modules.logic.room.model.debug.RoomDebugBuildingMO", package.seeall)

local var_0_0 = pureTable("RoomDebugBuildingMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.buildingId = arg_1_1.id
	arg_1_0.config = RoomConfig.instance:getBuildingConfig(arg_1_0.buildingId)
end

return var_0_0
