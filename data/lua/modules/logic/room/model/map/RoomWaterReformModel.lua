module("modules.logic.room.model.map.RoomWaterReformModel", package.seeall)

local var_0_0 = class("RoomWaterReformModel", BaseModel)

var_0_0.InitBlockColor = -1
var_0_0.InitWaterType = -1

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

	arg_4_0:setReformMode()
	arg_4_0:setSelectWaterArea()
	arg_4_0:clearChangeWaterTypeDict()
	arg_4_0:clearChangeBlockColorDict()
	arg_4_0:setBlockColorReformSelectMode()
	arg_4_0:clearBlockPermanentInfoDict()
end

function var_0_0.clearChangeWaterTypeDict(arg_5_0)
	arg_5_0._changeWaterTypeDict = {}
end

function var_0_0.clearChangeBlockColorDict(arg_6_0)
	arg_6_0._changeBlockColorDict = {}
end

function var_0_0.clearBlockPermanentInfoDict(arg_7_0)
	arg_7_0._blockPermanentInfoDict = {}
end

function var_0_0.initWaterArea(arg_8_0)
	arg_8_0:setSelectWaterArea()

	local var_8_0 = RoomResourceEnum.ResourceId.River

	arg_8_0._waterAreaMo = RoomResourceHelper.getResourcePointAreaMODict(nil, {
		var_8_0
	}, true)[var_8_0]
end

function var_0_0.clearChangeWaterRecord(arg_9_0, arg_9_1)
	if not arg_9_1 or not arg_9_0._changeWaterTypeDict then
		return
	end

	arg_9_0._changeWaterTypeDict[arg_9_1] = nil
end

function var_0_0.clearChangeBlockColorRecord(arg_10_0, arg_10_1)
	if not arg_10_1 or not arg_10_0._changeBlockColorDict then
		return
	end

	arg_10_0._changeBlockColorDict[arg_10_1] = nil
end

function var_0_0.resetChangeWaterType(arg_11_0)
	if not arg_11_0._changeWaterTypeDict then
		return
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0._changeWaterTypeDict) do
		local var_11_0 = RoomMapBlockModel.instance:getFullBlockMOById(iter_11_0)

		if var_11_0 then
			var_11_0:setTempWaterType()
		end
	end

	arg_11_0:clearChangeWaterTypeDict()
end

function var_0_0.resetChangeBlockColor(arg_12_0)
	if not arg_12_0._changeBlockColorDict then
		return
	end

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0._changeBlockColorDict) do
		local var_12_1 = RoomMapBlockModel.instance:getFullBlockMOById(iter_12_0)

		if var_12_1 then
			var_12_1:setTempBlockColorType()

			local var_12_2 = var_12_1.hexPoint

			var_12_0[#var_12_0 + 1] = var_12_2
		end
	end

	RoomMapBlockModel.instance:refreshNearRiverByHexPointList(var_12_0, 1)
	arg_12_0:clearChangeBlockColorDict()
end

function var_0_0.isWaterReform(arg_13_0)
	return arg_13_0._isWaterReform
end

function var_0_0.getReformMode(arg_14_0)
	return arg_14_0._reformMode
end

function var_0_0.isBlockInSelect(arg_15_0, arg_15_1)
	if not arg_15_0:isWaterReform() or not arg_15_1 then
		return
	end

	local var_15_0 = false
	local var_15_1 = arg_15_1.id

	if arg_15_1:hasRiver() then
		local var_15_2 = arg_15_0:getSelectWaterBlockMoList()

		for iter_15_0, iter_15_1 in ipairs(var_15_2) do
			var_15_0 = iter_15_1.id == var_15_1

			if var_15_0 then
				break
			end
		end
	else
		local var_15_3 = arg_15_0:getSelectedBlocks()

		var_15_0 = var_15_3 and var_15_3[var_15_1] and true or false
	end

	return var_15_0
end

function var_0_0.hasSelectWaterArea(arg_16_0)
	return arg_16_0._selectAreaId and true or false
end

function var_0_0.getSelectWaterBlockMoList(arg_17_0)
	local var_17_0 = {}

	if not arg_17_0:hasSelectWaterArea() then
		return var_17_0
	end

	local var_17_1 = {}
	local var_17_2 = arg_17_0._waterAreaMo and arg_17_0._waterAreaMo:findeArea()
	local var_17_3 = var_17_2 and var_17_2[arg_17_0._selectAreaId]

	if var_17_3 then
		for iter_17_0, iter_17_1 in ipairs(var_17_3) do
			local var_17_4 = iter_17_1.x
			local var_17_5 = iter_17_1.y

			if not var_17_1[var_17_4] or not var_17_1[var_17_4][var_17_5] then
				local var_17_6 = RoomMapBlockModel.instance:getBlockMO(var_17_4, var_17_5)

				var_17_0[#var_17_0 + 1] = var_17_6
				var_17_1[var_17_4] = var_17_1[var_17_4] or {}
				var_17_1[var_17_4][var_17_5] = true
			end
		end
	end

	return var_17_0
end

function var_0_0.getWaterAreaId(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return (arg_18_0._waterAreaMo:getAreaIdByXYD(arg_18_1, arg_18_2, arg_18_3))
end

function var_0_0.getWaterAreaList(arg_19_0)
	return arg_19_0._waterAreaMo and arg_19_0._waterAreaMo:findeArea() or {}
end

function var_0_0.getSelectWaterResourcePointList(arg_20_0)
	return arg_20_0:getWaterAreaList()[arg_20_0._selectAreaId]
end

function var_0_0.getSelectAreaId(arg_21_0)
	return arg_21_0._selectAreaId
end

function var_0_0.getRecordChangeWaterType(arg_22_0)
	return arg_22_0._changeWaterTypeDict
end

function var_0_0.hasChangedWaterType(arg_23_0)
	local var_23_0 = arg_23_0:getRecordChangeWaterType()

	return var_23_0 and next(var_23_0)
end

function var_0_0.isUnlockWaterReform(arg_24_0, arg_24_1)
	local var_24_0 = true
	local var_24_1 = RoomConfig.instance:getWaterReformItemId(arg_24_1)

	if var_24_1 and var_24_1 ~= 0 then
		var_24_0 = ItemModel.instance:getItemCount(var_24_1) > 0
	end

	return var_24_0
end

function var_0_0.isUnlockBlockColor(arg_25_0, arg_25_1)
	local var_25_0 = true

	if arg_25_1 ~= var_0_0.InitBlockColor then
		local var_25_1 = RoomConfig.instance:getBlockColorReformVoucherId(arg_25_1)

		if var_25_1 and var_25_1 ~= 0 then
			var_25_0 = UnlockVoucherModel.instance:getVoucher(var_25_1) and true or false
		end
	end

	return var_25_0
end

function var_0_0.isUnlockAllBlockColor(arg_26_0)
	local var_26_0 = RoomConfig.instance:getBlockColorReformList()

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if not arg_26_0:isUnlockBlockColor(iter_26_1) then
			return false
		end
	end

	return true
end

function var_0_0.getBlockColorReformSelectMode(arg_27_0)
	return arg_27_0._blockColorReformSelectMode or RoomEnum.BlockColorReformSelectMode.Single
end

function var_0_0.hasSelectedBlock(arg_28_0)
	local var_28_0 = false

	if arg_28_0._selectedBlockDict then
		var_28_0 = next(arg_28_0._selectedBlockDict) and true or false
	end

	return var_28_0
end

function var_0_0.getSelectedBlocks(arg_29_0)
	return arg_29_0._selectedBlockDict
end

function var_0_0.getRecordChangeBlockColor(arg_30_0)
	return arg_30_0._changeBlockColorDict
end

function var_0_0.hasChangedBlockColor(arg_31_0)
	local var_31_0 = arg_31_0:getRecordChangeBlockColor()

	return var_31_0 and next(var_31_0)
end

function var_0_0.getChangedBlockColorCount(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = 0
	local var_32_1 = arg_32_0:getRecordChangeBlockColor()

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		if (not arg_32_2 or iter_32_1 ~= arg_32_2) and (not arg_32_1 or iter_32_1 == arg_32_1) then
			var_32_0 = var_32_0 + 1
		end
	end

	return var_32_0
end

function var_0_0.getBlockPermanentInfo(arg_33_0, arg_33_1)
	return arg_33_0._blockPermanentInfoDict and arg_33_0._blockPermanentInfoDict[arg_33_1] or var_0_0.InitBlockColor
end

function var_0_0.setWaterReform(arg_34_0, arg_34_1)
	arg_34_0._isWaterReform = arg_34_1 == true
end

function var_0_0.setReformMode(arg_35_0, arg_35_1)
	arg_35_0._reformMode = arg_35_1
end

function var_0_0.setSelectWaterArea(arg_36_0, arg_36_1)
	arg_36_0._selectAreaId = arg_36_1
end

function var_0_0.recordChangeWaterType(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_1 or not arg_37_2 then
		return
	end

	if not arg_37_0._changeWaterTypeDict then
		arg_37_0:clearChangeWaterTypeDict()
	end

	arg_37_0._changeWaterTypeDict[arg_37_1] = arg_37_2
end

function var_0_0.setBlockColorReformSelectMode(arg_38_0, arg_38_1)
	arg_38_0._blockColorReformSelectMode = arg_38_1
end

function var_0_0.setBlockSelectedByList(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_3 then
		arg_39_0._selectedBlockDict = {}
	end

	if arg_39_1 then
		for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
			arg_39_0:setBlockSelected(iter_39_1, arg_39_2)
		end
	end
end

function var_0_0.setBlockSelected(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_0._selectedBlockDict then
		arg_40_0._selectedBlockDict = {}
	end

	if arg_40_2 then
		arg_40_0._selectedBlockDict[arg_40_1] = true
	else
		arg_40_0._selectedBlockDict[arg_40_1] = nil
	end
end

function var_0_0.recordChangeBlockColor(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_1 or not arg_41_2 then
		return
	end

	if not arg_41_0._changeBlockColorDict then
		arg_41_0:clearChangeBlockColorDict()
	end

	arg_41_0._changeBlockColorDict[arg_41_1] = arg_41_2
end

function var_0_0.setBlockPermanentInfo(arg_42_0, arg_42_1)
	if not arg_42_1 then
		return
	end

	if not arg_42_0._blockPermanentInfoDict then
		arg_42_0._blockPermanentInfoDict = {}
	end

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		arg_42_0._blockPermanentInfoDict[iter_42_1.blockId] = iter_42_1.color
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
