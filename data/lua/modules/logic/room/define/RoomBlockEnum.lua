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
	Snow4 = 48,
	Snow5 = 49,
	Green = 1,
	Snow3 = 47,
	Snow = 15,
	Snow2 = 16
}
var_0_0.BlockLinkEffectGOPath = {
	[var_0_0.BlockType.Green] = "junsi"
}
var_0_0.FootPrintDict = {
	[var_0_0.BlockType.Snow] = true,
	[var_0_0.BlockType.Snow2] = true,
	[var_0_0.BlockType.Snow3] = true,
	[var_0_0.BlockType.Snow4] = true,
	[var_0_0.BlockType.Snow5] = true
}
var_0_0.EmptyDefineId = 1
var_0_0.PlaceEffectAnimatorCloseTime = 0.16666666666666666
var_0_0.InitBlockDegreeValue = 48
var_0_0.WaterReformCommonDefineId = 292

return var_0_0
