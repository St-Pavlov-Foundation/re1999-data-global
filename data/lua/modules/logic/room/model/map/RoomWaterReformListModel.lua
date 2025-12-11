module("modules.logic.room.model.map.RoomWaterReformListModel", package.seeall)

local var_0_0 = class("RoomWaterReformListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	arg_3_0:_clearData()
	var_0_0.super.clear(arg_3_0)
end

function var_0_0._clearData(arg_4_0)
	if arg_4_0._scrollViews then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._scrollViews) do
			if iter_4_1.setSelectList then
				iter_4_1:setSelectList()
			end
		end
	end
end

function var_0_0.setShowBlockList(arg_5_0)
	local var_5_0 = RoomWaterReformModel.instance:getReformMode()
	local var_5_1 = {}

	if var_5_0 == RoomEnum.ReformMode.Water then
		local var_5_2 = RoomConfig.instance:getWaterReformTypeList()

		for iter_5_0, iter_5_1 in ipairs(var_5_2) do
			local var_5_3 = {
				waterType = iter_5_1,
				blockId = RoomConfig.instance:getWaterReformTypeBlockId(iter_5_1)
			}

			var_5_1[#var_5_1 + 1] = var_5_3
		end
	elseif var_5_0 == RoomEnum.ReformMode.Block then
		local var_5_4 = {}
		local var_5_5 = RoomConfig.instance:getBlockColorReformList()

		for iter_5_2, iter_5_3 in ipairs(var_5_5) do
			local var_5_6 = {
				blockColor = iter_5_3,
				blockId = RoomConfig.instance:getBlockColorReformBlockId(iter_5_3)
			}

			if RoomWaterReformModel.instance:isUnlockBlockColor(iter_5_3) then
				var_5_1[#var_5_1 + 1] = var_5_6
			else
				var_5_4[#var_5_4 + 1] = var_5_6
			end
		end

		for iter_5_4, iter_5_5 in ipairs(var_5_4) do
			var_5_1[#var_5_1 + 1] = iter_5_5
		end
	end

	arg_5_0:setList(var_5_1)
end

function var_0_0.setSelectWaterType(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = arg_6_0:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1.waterType and iter_6_1.waterType == arg_6_1 then
			var_6_0 = iter_6_1

			break
		end
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._scrollViews) do
		iter_6_3:setSelect(var_6_0)
	end
end

function var_0_0.setSelectBlockColor(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = arg_7_0:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.blockColor and iter_7_1.blockColor == arg_7_1 then
			var_7_0 = iter_7_1

			break
		end
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0._scrollViews) do
		iter_7_3:setSelect(var_7_0)
	end
end

function var_0_0.getDefaultSelectWaterType(arg_8_0)
	if not RoomWaterReformModel.instance:hasSelectWaterArea() then
		return
	end

	local var_8_0
	local var_8_1 = RoomWaterReformModel.instance:getSelectWaterBlockMoList()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = iter_8_1:getDefineWaterType()

		if var_8_0 and var_8_0 ~= var_8_2 then
			var_8_0 = nil

			break
		end

		var_8_0 = var_8_2
	end

	return var_8_0
end

function var_0_0.getDefaultSelectBlockColor(arg_9_0)
	if not RoomWaterReformModel.instance:hasSelectedBlock() then
		return
	end

	local var_9_0
	local var_9_1 = RoomWaterReformModel.instance:getSelectedBlocks()

	if var_9_1 then
		for iter_9_0, iter_9_1 in pairs(var_9_1) do
			local var_9_2 = RoomMapBlockModel.instance:getFullBlockMOById(iter_9_0)

			if var_9_2 then
				local var_9_3 = var_9_2:getDefineBlockType()

				if var_9_0 and var_9_0 ~= var_9_3 then
					var_9_0 = nil

					break
				end

				var_9_0 = var_9_3
			end
		end
	end

	return var_9_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
