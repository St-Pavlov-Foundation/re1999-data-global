module("modules.logic.room.define.RoomDistributionEnum", package.seeall)

slot0 = _M
slot0.DistributionType = {
	C3TA = "c3ta",
	C2TC = "c2tc",
	C4TC = "c4tc",
	C3TB = "c3tb",
	C2TB = "c2tb",
	C4TB = "c4tb",
	C3TC = "c3tc",
	C3TD = "c3td",
	C5TA = "c5ta",
	C4TA = "c4ta",
	C6TA = "c6ta",
	C1TA = "c1ta",
	C2TA = "c2ta"
}
slot0.DistributionTypeValue = {
	[slot0.DistributionType.C1TA] = {
		true,
		false,
		false,
		false,
		false,
		false
	},
	[slot0.DistributionType.C2TA] = {
		true,
		true,
		false,
		false,
		false,
		false
	},
	[slot0.DistributionType.C2TB] = {
		true,
		false,
		true,
		false,
		false,
		false
	},
	[slot0.DistributionType.C2TC] = {
		true,
		false,
		false,
		true,
		false,
		false
	},
	[slot0.DistributionType.C3TA] = {
		true,
		true,
		true,
		false,
		false,
		false
	},
	[slot0.DistributionType.C3TB] = {
		true,
		true,
		false,
		true,
		false,
		false
	},
	[slot0.DistributionType.C3TC] = {
		true,
		false,
		true,
		false,
		true,
		false
	},
	[slot0.DistributionType.C3TD] = {
		true,
		true,
		false,
		false,
		true,
		false
	},
	[slot0.DistributionType.C4TA] = {
		true,
		true,
		true,
		true,
		false,
		false
	},
	[slot0.DistributionType.C4TB] = {
		true,
		true,
		true,
		false,
		true,
		false
	},
	[slot0.DistributionType.C4TC] = {
		true,
		true,
		false,
		true,
		true,
		false
	},
	[slot0.DistributionType.C5TA] = {
		true,
		true,
		true,
		true,
		true,
		false
	},
	[slot0.DistributionType.C6TA] = {
		true,
		true,
		true,
		true,
		true,
		true
	}
}
slot0.CountToTypeList = {
	{
		slot0.DistributionType.C1TA
	},
	{
		slot0.DistributionType.C2TA,
		slot0.DistributionType.C2TB,
		slot0.DistributionType.C2TC
	},
	{
		slot0.DistributionType.C3TA,
		slot0.DistributionType.C3TB,
		slot0.DistributionType.C3TC,
		slot0.DistributionType.C3TD
	},
	{
		slot0.DistributionType.C4TA,
		slot0.DistributionType.C4TB,
		slot0.DistributionType.C4TC
	},
	{
		slot0.DistributionType.C5TA
	},
	{
		slot0.DistributionType.C6TA
	}
}

return slot0
