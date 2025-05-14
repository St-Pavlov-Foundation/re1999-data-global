module("modules.logic.room.entity.RoomBaseVehicleEntity", package.seeall)

local var_0_0 = class("RoomBaseVehicleEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
	arg_1_0._pathfindingEnabled = false
end

return var_0_0
