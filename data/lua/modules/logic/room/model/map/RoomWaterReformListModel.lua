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

function var_0_0.initShowBlock(arg_5_0)
	arg_5_0:setShowBlockList()
end

function var_0_0.setShowBlockList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = RoomConfig.instance:getWaterReformTypeList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = {
			waterType = iter_6_1,
			blockId = RoomConfig.instance:getWaterReformTypeBlockId(iter_6_1),
			blockCfg = RoomConfig.instance:getWaterReformTypeBlockCfg(iter_6_1)
		}

		var_6_0[#var_6_0 + 1] = var_6_2
	end

	arg_6_0:setList(var_6_0)
end

function var_0_0.setSelectWaterType(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = arg_7_0:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.waterType and iter_7_1.waterType == arg_7_1 then
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

var_0_0.instance = var_0_0.New()

return var_0_0
