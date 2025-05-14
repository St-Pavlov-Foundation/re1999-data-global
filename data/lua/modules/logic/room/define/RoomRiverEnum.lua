module("modules.logic.room.define.RoomRiverEnum", package.seeall)

local var_0_0 = _M

var_0_0.RiverBlockType = {
	["4008"] = "4008",
	["4010"] = "4010",
	["4004"] = "4004",
	["4009"] = "4009",
	["4000"] = "4000",
	["4005"] = "4005",
	["4011"] = "4011",
	["4001"] = "4001",
	["4006"] = "4006",
	["4002"] = "4002",
	["4007"] = "4007",
	["4003"] = "4003"
}
var_0_0.LakeOutLinkType = {
	Floor = 4031,
	River = 4032,
	Right = 4033,
	RightLeft = 4036,
	HalfLake = 4037,
	Left = 4034,
	NoLink = 4035
}
var_0_0.LakeBlockType = {
	[var_0_0.LakeOutLinkType.Floor] = "4031",
	[var_0_0.LakeOutLinkType.River] = "4032",
	[var_0_0.LakeOutLinkType.Right] = "4033",
	[var_0_0.LakeOutLinkType.Left] = "4034",
	[var_0_0.LakeOutLinkType.NoLink] = "4035",
	[var_0_0.LakeOutLinkType.RightLeft] = "4036",
	[var_0_0.LakeOutLinkType.HalfLake] = "4037"
}
var_0_0.LakeFloorType = {
	[var_0_0.LakeOutLinkType.Floor] = "4031",
	[var_0_0.LakeOutLinkType.River] = "4032",
	[var_0_0.LakeOutLinkType.Right] = "4033",
	[var_0_0.LakeOutLinkType.Left] = "4034",
	[var_0_0.LakeOutLinkType.NoLink] = "4035",
	[var_0_0.LakeOutLinkType.RightLeft] = "4036"
}
var_0_0.LakeFloorBType = {
	[var_0_0.LakeOutLinkType.RightLeft] = "4036b"
}

return var_0_0
