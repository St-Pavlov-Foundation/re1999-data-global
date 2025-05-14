module("modules.logic.room.define.RoomVehicleEnum", package.seeall)

local var_0_0 = _M

var_0_0.OwnerType = {
	TransportSite = 2,
	Building = 1,
	None = 0
}
var_0_0.UseType = {
	Aircraft = 201,
	LandWater = 101
}
var_0_0.ReplaceType = {
	Land = 1,
	Water = 2,
	None = 0
}

return var_0_0
