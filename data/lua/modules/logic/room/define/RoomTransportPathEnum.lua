module("modules.logic.room.define.RoomTransportPathEnum", package.seeall)

local var_0_0 = _M

var_0_0.PathLineType = {
	Line14 = 4001,
	Line12 = 4002,
	Line00 = 4004,
	Line10 = 4000,
	Line13 = 4003
}
var_0_0.PathLineTypeRes = {
	[var_0_0.PathLineType.Line10] = "4000",
	[var_0_0.PathLineType.Line14] = "4001",
	[var_0_0.PathLineType.Line12] = "4002",
	[var_0_0.PathLineType.Line13] = "4003",
	[var_0_0.PathLineType.Line00] = "4004"
}
var_0_0.StyleId = {
	EditLink = 3,
	ObLink = 4,
	NoLink = 2,
	ObWater = 5,
	Normal = 1
}
var_0_0.TipLang = {
	[RoomBuildingEnum.BuildingType.Collect] = "notice_route_collect_process",
	[RoomBuildingEnum.BuildingType.Process] = "notice_route_process_manufacture",
	[RoomBuildingEnum.BuildingType.Manufacture] = "notice_route_collect_manufacture"
}

return var_0_0
