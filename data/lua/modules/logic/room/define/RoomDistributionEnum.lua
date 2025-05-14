module("modules.logic.room.define.RoomDistributionEnum", package.seeall)

local var_0_0 = _M

var_0_0.DistributionType = {
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
var_0_0.DistributionTypeValue = {
	[var_0_0.DistributionType.C1TA] = {
		true,
		false,
		false,
		false,
		false,
		false
	},
	[var_0_0.DistributionType.C2TA] = {
		true,
		true,
		false,
		false,
		false,
		false
	},
	[var_0_0.DistributionType.C2TB] = {
		true,
		false,
		true,
		false,
		false,
		false
	},
	[var_0_0.DistributionType.C2TC] = {
		true,
		false,
		false,
		true,
		false,
		false
	},
	[var_0_0.DistributionType.C3TA] = {
		true,
		true,
		true,
		false,
		false,
		false
	},
	[var_0_0.DistributionType.C3TB] = {
		true,
		true,
		false,
		true,
		false,
		false
	},
	[var_0_0.DistributionType.C3TC] = {
		true,
		false,
		true,
		false,
		true,
		false
	},
	[var_0_0.DistributionType.C3TD] = {
		true,
		true,
		false,
		false,
		true,
		false
	},
	[var_0_0.DistributionType.C4TA] = {
		true,
		true,
		true,
		true,
		false,
		false
	},
	[var_0_0.DistributionType.C4TB] = {
		true,
		true,
		true,
		false,
		true,
		false
	},
	[var_0_0.DistributionType.C4TC] = {
		true,
		true,
		false,
		true,
		true,
		false
	},
	[var_0_0.DistributionType.C5TA] = {
		true,
		true,
		true,
		true,
		true,
		false
	},
	[var_0_0.DistributionType.C6TA] = {
		true,
		true,
		true,
		true,
		true,
		true
	}
}
var_0_0.CountToTypeList = {
	{
		var_0_0.DistributionType.C1TA
	},
	{
		var_0_0.DistributionType.C2TA,
		var_0_0.DistributionType.C2TB,
		var_0_0.DistributionType.C2TC
	},
	{
		var_0_0.DistributionType.C3TA,
		var_0_0.DistributionType.C3TB,
		var_0_0.DistributionType.C3TC,
		var_0_0.DistributionType.C3TD
	},
	{
		var_0_0.DistributionType.C4TA,
		var_0_0.DistributionType.C4TB,
		var_0_0.DistributionType.C4TC
	},
	{
		var_0_0.DistributionType.C5TA
	},
	{
		var_0_0.DistributionType.C6TA
	}
}

return var_0_0
