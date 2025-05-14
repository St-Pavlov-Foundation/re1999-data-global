module("modules.logic.room.model.layout.RoomLayoutItemListModel", package.seeall)

local var_0_0 = class("RoomLayoutItemListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}

	arg_3_0._isBirthdayBlock = arg_3_3 and true or false

	local var_3_1, var_3_2 = arg_3_0:_findBlockInfos(arg_3_1)
	local var_3_3 = arg_3_0:_findbuildingInfos(arg_3_2)

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		local var_3_4 = RoomLayoutItemMO.New()

		var_3_4:init(#var_3_0 + 1, iter_3_0, MaterialEnum.MaterialType.BlockPackage, iter_3_1)
		table.insert(var_3_0, var_3_4)
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_2) do
		local var_3_5 = RoomLayoutItemMO.New()

		var_3_5:init(#var_3_0 + 1, iter_3_3, MaterialEnum.MaterialType.SpecialBlock, 1)
		table.insert(var_3_0, var_3_5)
	end

	for iter_3_4, iter_3_5 in pairs(var_3_3) do
		for iter_3_6 = 1, iter_3_5 do
			local var_3_6 = RoomLayoutItemMO.New()

			var_3_6:init(#var_3_0 + 1, iter_3_4, MaterialEnum.MaterialType.Building, 1)

			var_3_6.itemIndex = iter_3_6

			table.insert(var_3_0, var_3_6)
		end
	end

	table.sort(var_3_0, var_0_0.sortFuc)
	arg_3_0:setList(var_3_0)
end

function var_0_0.resortList(arg_4_0)
	local var_4_0 = arg_4_0:getList()

	table.sort(var_4_0, var_0_0.sortFuc)
	arg_4_0:setList(var_4_0)
end

function var_0_0._findBlockInfos(arg_5_0, arg_5_1)
	local var_5_0, var_5_1 = RoomLayoutHelper.findBlockInfos(arg_5_1, arg_5_0._isBirthdayBlock)

	return var_5_0, var_5_1
end

function var_0_0._findbuildingInfos(arg_6_0, arg_6_1)
	return (RoomLayoutHelper.findbuildingInfos(arg_6_1))
end

function var_0_0.sortFuc(arg_7_0, arg_7_1)
	local var_7_0 = var_0_0._getLackOrder(arg_7_0)
	local var_7_1 = var_0_0._getLackOrder(arg_7_1)

	if var_7_0 ~= var_7_1 then
		return var_7_0 < var_7_1
	end

	local var_7_2 = var_0_0._getItemTypeOrder(arg_7_0)
	local var_7_3 = var_0_0._getItemTypeOrder(arg_7_1)

	if var_7_2 ~= var_7_3 then
		return var_7_2 < var_7_3
	end

	local var_7_4 = arg_7_0:getItemConfig()
	local var_7_5 = arg_7_1:getItemConfig()
	local var_7_6 = var_7_4.rare or 0
	local var_7_7 = var_7_5.rare or 0

	if var_7_6 ~= var_7_7 then
		return var_7_7 < var_7_6
	end

	if arg_7_0:isBlockPackage() and arg_7_1:isBlockPackage() and arg_7_0.itemNum ~= arg_7_1.itemNum then
		return arg_7_0.itemNum > arg_7_1.itemNum
	end

	if arg_7_0:isBuilding() and arg_7_1:isBuilding() and var_7_4.buildDegree ~= var_7_5.buildDegree then
		return var_7_4.buildDegree > var_7_5.buildDegree
	end

	if arg_7_0.itemId ~= arg_7_1.itemId then
		return arg_7_0.itemId < arg_7_1.itemId
	end
end

function var_0_0._getLackOrder(arg_8_0)
	if arg_8_0:isLack() then
		return 1
	end

	return 2
end

function var_0_0._getItemTypeOrder(arg_9_0)
	if arg_9_0:isBlockPackage() then
		return 1
	elseif arg_9_0:isSpecialBlock() then
		return 2
	elseif arg_9_0:isBuilding() then
		return 3
	end

	return 100
end

var_0_0.instance = var_0_0.New()

return var_0_0
