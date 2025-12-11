module("modules.logic.room.model.gift.RoomGiftShowBuildingMo", package.seeall)

local var_0_0 = pureTable("RoomGiftShowBuildingMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.config = arg_1_1
	arg_1_0.rare = arg_1_0.config.rare or 0
	arg_1_0.subTypeIndex = 2
	arg_1_0.subType = RoomBlockGiftEnum.SubType[arg_1_0.subTypeIndex]
	arg_1_0.itemCofig = ItemModel.instance:getItemConfig(arg_1_0.subType, arg_1_1.id)
	arg_1_0.numLimit = arg_1_0.config.numLimit
	arg_1_0.isSelect = false
end

function var_0_0.getIcon(arg_2_0)
	if arg_2_0.config then
		if arg_2_0.config.canLevelUp then
			for iter_2_0 = 0, 3 do
				local var_2_0 = RoomConfig.instance:getLevelGroupConfig(arg_2_0.id, iter_2_0)

				if var_2_0 and not string.nilorempty(var_2_0.icon) then
					return var_2_0.icon
				end
			end
		end

		return arg_2_0.config.icon
	end
end

function var_0_0.getBuildingAreaConfig(arg_3_0)
	return (RoomConfig.instance:getBuildingAreaConfig(arg_3_0.config.areaId))
end

function var_0_0.isCollect(arg_4_0)
	return ItemModel.instance:getItemQuantity(arg_4_0.subType, arg_4_0.id) >= arg_4_0.numLimit
end

return var_0_0
