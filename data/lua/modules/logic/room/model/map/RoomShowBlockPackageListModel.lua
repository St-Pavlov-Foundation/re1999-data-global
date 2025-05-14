module("modules.logic.room.model.map.RoomShowBlockPackageListModel", package.seeall)

local var_0_0 = class("RoomShowBlockPackageListModel", ListScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	function arg_1_0._selectSortFunc(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0._selectBlockPackageId == arg_2_0.id
		local var_2_1 = arg_1_0._selectBlockPackageId == arg_2_1.id

		if var_2_0 ~= var_2_1 then
			if var_2_0 then
				return true
			elseif var_2_1 then
				return false
			end
		end

		local var_2_2 = arg_2_0.num < 1
		local var_2_3 = arg_2_1.num < 1

		if var_2_2 ~= var_2_3 then
			return var_2_3
		end

		local var_2_4

		if arg_1_0._isSortRate then
			if arg_2_0.rare ~= arg_2_1.rare then
				if arg_1_0._isSortOrder then
					return arg_2_0.rare < arg_2_1.rare
				else
					return arg_2_0.rare > arg_2_1.rare
				end
			end

			if arg_2_0.num ~= arg_2_1.num then
				return arg_2_0.num > arg_2_1.num
			end
		else
			if arg_2_0.num ~= arg_2_1.num then
				if arg_1_0._isSortOrder then
					return arg_2_0.num < arg_2_1.num
				else
					return arg_2_0.num > arg_2_1.num
				end
			end

			if arg_2_0.rare ~= arg_2_1.rare then
				return arg_2_0.rare > arg_2_1.rare
			end
		end

		if arg_2_0.id ~= arg_2_1.id then
			return arg_2_0.id < arg_2_1.id
		end
	end
end

function var_0_0.getSortRate(arg_3_0)
	return arg_3_0._isSortRate
end

function var_0_0.getSortOrder(arg_4_0)
	return arg_4_0._isSortOrder
end

function var_0_0.setSortParam(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._isSortOrder = arg_5_2
	arg_5_0._isSortRate = arg_5_1

	arg_5_0:sort(arg_5_0._selectSortFunc)
end

function var_0_0.setShowBlockList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList()

	for iter_6_0 = 1, #var_6_1 do
		local var_6_2 = var_6_1[iter_6_0]
		local var_6_3 = RoomConfig.instance:getBlockPackageConfig(var_6_2.id)

		if var_6_3 and arg_6_0:_checkTheme(var_6_2.id) then
			local var_6_4 = RoomShowBlockPackageMO.New()

			var_6_4:init(var_6_2.id, var_6_2:getUnUseCount(), var_6_3.rare or 0)
			table.insert(var_6_0, var_6_4)
		end
	end

	table.sort(var_6_0, arg_6_0._selectSortFunc)
	arg_6_0:setList(var_6_0)
	arg_6_0:setSelect(nil)
end

function var_0_0._checkTheme(arg_7_0, arg_7_1)
	local var_7_0 = RoomThemeFilterListModel.instance

	if not var_7_0:getIsAll() and var_7_0:getSelectCount() > 0 then
		local var_7_1 = RoomConfig.instance:getThemeIdByItem(arg_7_1, MaterialEnum.MaterialType.BlockPackage)

		if not var_7_0:isSelectById(var_7_1) then
			return false
		end
	end

	return true
end

function var_0_0.clearSelect(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._scrollViews) do
		iter_8_1:setSelect(nil)
	end

	arg_8_0._selectBlockPackageId = nil
end

function var_0_0._refreshSelect(arg_9_0)
	local var_9_0
	local var_9_1 = arg_9_0:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if iter_9_1.id == arg_9_0._selectBlockPackageId then
			var_9_0 = iter_9_1

			break
		end
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0._scrollViews) do
		iter_9_3:setSelect(var_9_0)
	end
end

function var_0_0.setSelect(arg_10_0, arg_10_1)
	arg_10_0._selectBlockPackageId = arg_10_1

	arg_10_0:_refreshSelect()
end

function var_0_0.initShow(arg_11_0, arg_11_1)
	arg_11_0._isSortRate = true
	arg_11_0._isSortOrder = true
	arg_11_0._selectBlockPackageId = arg_11_1

	arg_11_0:setShowBlockList()
end

var_0_0.instance = var_0_0.New()

return var_0_0
