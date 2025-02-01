module("modules.logic.room.define.RoomBlockEnum", package.seeall)

slot0 = _M
slot0.BlockSize = 0.499
slot0.EmptyBlockDistanceStyleCount = 1
slot0.BlockState = {
	Water = 2,
	Inventory = 4,
	WaterReform = 6,
	Fake = 5,
	Temp = 3,
	Map = 1
}
slot0.OpState = {
	Back = 2,
	Normal = 1
}
slot0.UseState = {
	TransportPath = 2,
	Normal = 1
}
slot0.CleanType = {
	CleanLand = 1,
	Normal = 0
}
slot0.OwnType = {
	Special = 1,
	Package = 0
}
slot0.BlockType = {
	Snow2 = 16,
	Snow = 15,
	Green = 1
}
slot0.BlockLinkEffectGOPath = {
	[slot0.BlockType.Green] = "junsi"
}
slot0.FootPrintDict = {
	[slot0.BlockType.Snow] = true,
	[slot0.BlockType.Snow2] = true
}
slot0.EmptyDefineId = 1
slot0.PlaceEffectAnimatorCloseTime = 0.16666666666666666
slot0.InitBlockDegreeValue = 48
slot0.WaterReformCommonDefineId = 292

return slot0
