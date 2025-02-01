module("modules.logic.room.define.RoomVehicleEnum", package.seeall)

slot0 = _M
slot0.OwnerType = {
	TransportSite = 2,
	Building = 1,
	None = 0
}
slot0.UseType = {
	Aircraft = 201,
	LandWater = 101
}
slot0.ReplaceType = {
	Land = 1,
	Water = 2,
	None = 0
}

return slot0
