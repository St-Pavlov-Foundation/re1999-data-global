-- chunkname: @modules/logic/partycloth/define/PartyClothEnum.lua

module("modules.logic.partycloth.define.PartyClothEnum", package.seeall)

local PartyClothEnum = _M

PartyClothEnum.ClothType = {
	Jacket = 2,
	Body = 6,
	Hat = 1,
	Pant = 3,
	Head = 5,
	Shoes = 4
}
PartyClothEnum.ResPath = {
	LotterySuitItem = "ui/viewres/partygame/cloth/partyclothlotterysuititem.prefab",
	SuitItem = "ui/viewres/partygame/cloth/partyclothsuititem.prefab",
	PartItem = "ui/viewres/partygame/cloth/partyclothpartitem.prefab"
}
PartyClothEnum.ClothLangTxt = {
	[PartyClothEnum.ClothType.Hat] = "p_partyclothview_txt_Hair",
	[PartyClothEnum.ClothType.Jacket] = "p_partyclothview_txt_Jacket",
	[PartyClothEnum.ClothType.Pant] = "p_partyclothview_txt_Pant",
	[PartyClothEnum.ClothType.Shoes] = "p_partyclothview_txt_Shoes",
	[PartyClothEnum.ClothType.Head] = "p_partyclothview_txt_Skin"
}
PartyClothEnum.DefaultSkinPartId = 3400015
PartyClothEnum.DefaultSuitId = 340001

return PartyClothEnum
