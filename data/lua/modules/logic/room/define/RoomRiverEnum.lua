module("modules.logic.room.define.RoomRiverEnum", package.seeall)

slot0 = _M
slot0.RiverBlockType = {
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
slot0.LakeOutLinkType = {
	Floor = 4031,
	River = 4032,
	Right = 4033,
	RightLeft = 4036,
	HalfLake = 4037,
	Left = 4034,
	NoLink = 4035
}
slot0.LakeBlockType = {
	[slot0.LakeOutLinkType.Floor] = "4031",
	[slot0.LakeOutLinkType.River] = "4032",
	[slot0.LakeOutLinkType.Right] = "4033",
	[slot0.LakeOutLinkType.Left] = "4034",
	[slot0.LakeOutLinkType.NoLink] = "4035",
	[slot0.LakeOutLinkType.RightLeft] = "4036",
	[slot0.LakeOutLinkType.HalfLake] = "4037"
}
slot0.LakeFloorType = {
	[slot0.LakeOutLinkType.Floor] = "4031",
	[slot0.LakeOutLinkType.River] = "4032",
	[slot0.LakeOutLinkType.Right] = "4033",
	[slot0.LakeOutLinkType.Left] = "4034",
	[slot0.LakeOutLinkType.NoLink] = "4035",
	[slot0.LakeOutLinkType.RightLeft] = "4036"
}
slot0.LakeFloorBType = {
	[slot0.LakeOutLinkType.RightLeft] = "4036b"
}

return slot0
