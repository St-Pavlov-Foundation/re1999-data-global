module("modules.logic.room.model.map.RoomWaterReformModel", package.seeall)

local var_0_0 = class("RoomWaterReformModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0._waterAreaMo = nil
	arg_4_0._isWaterReform = false

	arg_4_0:setSelectWaterArea()
	arg_4_0:clearChangeWaterTypeDict()
end

function var_0_0.clearChangeWaterTypeDict(arg_5_0)
	arg_5_0._changeWaterTypeDict = {}
end

function var_0_0.initWaterArea(arg_6_0)
	arg_6_0:setSelectWaterArea()

	local var_6_0 = RoomResourceEnum.ResourceId.River

	arg_6_0._waterAreaMo = RoomResourceHelper.getResourcePointAreaMODict(nil, {
		var_6_0
	}, true)[var_6_0]
end

function var_0_0.recordChangeWaterType(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or not arg_7_2 then
		return
	end

	if not arg_7_0._changeWaterTypeDict then
		arg_7_0:clearChangeWaterTypeDict()
	end

	arg_7_0._changeWaterTypeDict[arg_7_1] = arg_7_2
end

function var_0_0.clearChangeWaterRecord(arg_8_0, arg_8_1)
	if not arg_8_1 or not arg_8_0._changeWaterTypeDict then
		return
	end

	arg_8_0._changeWaterTypeDict[arg_8_1] = nil
end

function var_0_0.hasChangedWaterType(arg_9_0)
	local var_9_0 = arg_9_0:getRecordChangeWaterType()

	return var_9_0 and next(var_9_0)
end

function var_0_0.resetChangeWaterType(arg_10_0)
	if not arg_10_0._changeWaterTypeDict then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0._changeWaterTypeDict) do
		local var_10_0 = RoomMapBlockModel.instance:getFullBlockMOById(iter_10_0)

		if var_10_0 then
			var_10_0:setTempWaterType()
		end
	end

	arg_10_0:clearChangeWaterTypeDict()
end

function var_0_0.isWaterReform(arg_11_0)
	return arg_11_0._isWaterReform
end

function var_0_0.hasSelectWaterArea(arg_12_0)
	return arg_12_0._selectAreaId and true or false
end

function var_0_0.getSelectWaterBlockMoList(arg_13_0)
	local var_13_0 = {}

	if not arg_13_0:hasSelectWaterArea() then
		return var_13_0
	end

	local var_13_1 = {}
	local var_13_2 = arg_13_0._waterAreaMo and arg_13_0._waterAreaMo:findeArea()
	local var_13_3 = var_13_2 and var_13_2[arg_13_0._selectAreaId]

	if var_13_3 then
		for iter_13_0, iter_13_1 in ipairs(var_13_3) do
			local var_13_4 = iter_13_1.x
			local var_13_5 = iter_13_1.y

			if not var_13_1[var_13_4] or not var_13_1[var_13_4][var_13_5] then
				local var_13_6 = RoomMapBlockModel.instance:getBlockMO(var_13_4, var_13_5)

				var_13_0[#var_13_0 + 1] = var_13_6
				var_13_1[var_13_4] = var_13_1[var_13_4] or {}
				var_13_1[var_13_4][var_13_5] = true
			end
		end
	end

	return var_13_0
end

function var_0_0.getWaterAreaId(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return (arg_14_0._waterAreaMo:getAreaIdByXYD(arg_14_1, arg_14_2, arg_14_3))
end

function var_0_0.getWaterAreaList(arg_15_0)
	return arg_15_0._waterAreaMo and arg_15_0._waterAreaMo:findeArea() or {}
end

function var_0_0.getSelectWaterResourcePointList(arg_16_0)
	return arg_16_0:getWaterAreaList()[arg_16_0._selectAreaId]
end

function var_0_0.isBlockInSelect(arg_17_0, arg_17_1)
	local var_17_0 = false
	local var_17_1 = arg_17_0:hasSelectWaterArea()
	local var_17_2 = arg_17_0:isWaterReform()

	if not (arg_17_1 and arg_17_1:hasRiver()) or not var_17_1 or not var_17_2 then
		return var_17_0
	end

	local var_17_3 = arg_17_0:getSelectWaterBlockMoList()

	for iter_17_0, iter_17_1 in ipairs(var_17_3) do
		var_17_0 = iter_17_1.id == arg_17_1.id

		if var_17_0 then
			break
		end
	end

	return var_17_0
end

function var_0_0.getSelectAreaId(arg_18_0)
	return arg_18_0._selectAreaId
end

function var_0_0.getRecordChangeWaterType(arg_19_0)
	return arg_19_0._changeWaterTypeDict
end

function var_0_0.isUnlockWaterReform(arg_20_0, arg_20_1)
	local var_20_0 = true
	local var_20_1 = RoomConfig.instance:getWaterReformItemId(arg_20_1)

	if var_20_1 and var_20_1 ~= 0 then
		var_20_0 = ItemModel.instance:getItemCount(var_20_1) > 0
	end

	return var_20_0
end

function var_0_0.setWaterReform(arg_21_0, arg_21_1)
	arg_21_0._isWaterReform = arg_21_1 == true
end

function var_0_0.setSelectWaterArea(arg_22_0, arg_22_1)
	arg_22_0._selectAreaId = arg_22_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
