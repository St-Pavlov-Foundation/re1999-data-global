module("modules.logic.commonprop.model.CommonPropListModel", package.seeall)

local var_0_0 = class("CommonPropListModel", ListScrollModel)

function var_0_0.setPropList(arg_1_0, arg_1_1)
	arg_1_0._moList = arg_1_1 and arg_1_1 or {}

	arg_1_0:_sortList(arg_1_0._moList)
	arg_1_0:_stackList(arg_1_0._moList)
	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0._sortList(arg_2_0, arg_2_1)
	table.sort(arg_2_1, function(arg_3_0, arg_3_1)
		if arg_2_0:_getQuality(arg_3_0) ~= arg_2_0:_getQuality(arg_3_1) then
			return arg_2_0:_getQuality(arg_3_0) > arg_2_0:_getQuality(arg_3_1)
		elseif arg_3_0.materilType ~= arg_3_1.materilType then
			return arg_3_0.materilType > arg_3_1.materilType
		elseif arg_3_0.materilType == 1 and arg_3_1.materilType == 1 and arg_2_0:_getSubType(arg_3_0) ~= arg_2_0:_getSubType(arg_3_1) then
			return arg_2_0:_getSubType(arg_3_0) < arg_2_0:_getSubType(arg_3_1)
		elseif arg_3_0.materilId ~= arg_3_1.materilId then
			return arg_3_0.materilId > arg_3_1.materilId
		end
	end)
end

function var_0_0._getQuality(arg_4_0, arg_4_1)
	local var_4_0 = ItemModel.instance:getItemConfig(arg_4_1.materilType, arg_4_1.materilId)

	return ItemModel.instance:getItemRare(var_4_0)
end

function var_0_0._getSubType(arg_5_0, arg_5_1)
	local var_5_0 = ItemModel.instance:getItemConfig(arg_5_1.materilType, arg_5_1.materilId)

	return var_5_0.subType == nil and 0 or var_5_0.subType
end

function var_0_0._getStackable(arg_6_0, arg_6_1)
	return ItemConfig.instance:isItemStackable(arg_6_1.materilType, arg_6_1.materilId)
end

function var_0_0._stackList(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if arg_7_0:_getStackable(iter_7_1) then
			table.insert(var_7_0, iter_7_1)
		else
			for iter_7_2 = 1, iter_7_1.quantity do
				local var_7_1 = {
					quantity = 1,
					materilType = iter_7_1.materilType,
					materilId = iter_7_1.materilId,
					uid = iter_7_1.uid
				}

				table.insert(var_7_0, var_7_1)
			end
		end
	end

	arg_7_0._moList = var_7_0
end

var_0_0.HighRare = 5

function var_0_0.isHadHighRareProp(arg_8_0)
	local var_8_0 = arg_8_0:getList()
	local var_8_1

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if tonumber(iter_8_1.materilType) == MaterialEnum.MaterialType.PlayerCloth then
			return true
		end

		local var_8_2 = ItemModel.instance:getItemConfig(tonumber(iter_8_1.materilType), tonumber(iter_8_1.materilId))

		if not var_8_2 or not var_8_2.rare then
			logWarn(string.format("type : %s, id : %s; getConfig error", iter_8_1.materilType, iter_8_1.materilId))
		elseif var_8_2.rare >= var_0_0.HighRare then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
