module("modules.logic.room.define.RoomBlockEnum", package.seeall)

local var_0_0 = _M

var_0_0.BlockSize = 0.499
var_0_0.EmptyBlockDistanceStyleCount = 1
var_0_0.BlockState = {
	Water = 2,
	Inventory = 4,
	WaterReform = 6,
	Fake = 5,
	Temp = 3,
	Map = 1
}
var_0_0.OpState = {
	Back = 2,
	Normal = 1
}
var_0_0.UseState = {
	TransportPath = 2,
	Normal = 1
}
var_0_0.CleanType = {
	CleanLand = 1,
	Normal = 0
}
var_0_0.OwnType = {
	Special = 1,
	Package = 0
}
var_0_0.BlockType = {
	v2a6_Snow = 47,
	v1a8_Snow = 15,
	v1a8_Snow2 = 16,
	Green = 1,
	v2a6_Snow3 = 49,
	v2a6_Snow2 = 48,
	v2a8_Snow = 51
}
var_0_0.BlockLinkEffectGOPath = {
	[var_0_0.BlockType.Green] = "junsi"
}
var_0_0.FootPrintDict = {
	[var_0_0.BlockType.v1a8_Snow] = true,
	[var_0_0.BlockType.v1a8_Snow2] = true,
	[var_0_0.BlockType.v2a6_Snow] = true,
	[var_0_0.BlockType.v2a6_Snow2] = true,
	[var_0_0.BlockType.v2a6_Snow3] = true,
	[var_0_0.BlockType.v2a8_Snow] = true
}
var_0_0.EmptyDefineId = 1
var_0_0.PlaceEffectAnimatorCloseTime = 0.16666666666666666
var_0_0.InitBlockDegreeValue = 48
var_0_0.WaterReformCommonDefineId = 292
var_0_0.BlockColorReformCommonDefineId = 6

return var_0_0
