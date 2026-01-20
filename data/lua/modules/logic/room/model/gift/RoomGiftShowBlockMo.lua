-- chunkname: @modules/logic/room/model/gift/RoomGiftShowBlockMo.lua

module("modules.logic.room.model.gift.RoomGiftShowBlockMo", package.seeall)

local RoomGiftShowBlockMo = pureTable("RoomGiftShowBlockMo")

function RoomGiftShowBlockMo:init(co)
	self.id = co.id
	self.packageId = co.id
	self.config = co
	self.rare = self.config.rare or 0
	self.subTypeIndex = 1
	self.subType = RoomBlockGiftEnum.SubType[self.subTypeIndex]
	self.itemCofig = ItemModel.instance:getItemConfig(self.subType, co.id)
	self.isSelect = false
end

function RoomGiftShowBlockMo:getBlockNum()
	local blockList = RoomConfig.instance:getBlockListByPackageId(self.id)
	local blockNum = blockList and #blockList or 0

	return blockNum
end

function RoomGiftShowBlockMo:isCollect()
	local quantity = ItemModel.instance:getItemQuantity(self.subType, self.id)

	return quantity > 0
end

return RoomGiftShowBlockMo
