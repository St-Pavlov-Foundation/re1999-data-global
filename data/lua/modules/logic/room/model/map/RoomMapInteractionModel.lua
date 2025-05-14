module("modules.logic.room.model.map.RoomMapInteractionModel", package.seeall)

local var_0_0 = class("RoomMapInteractionModel", BaseModel)

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

function var_0_0.init(arg_4_0)
	arg_4_0:clear()
end

function var_0_0._clearData(arg_5_0)
	arg_5_0._buildingInteraction = {}
	arg_5_0._buildingHexpointIndexDic = {}

	if arg_5_0._builidngInteractionModel then
		arg_5_0._builidngInteractionModel:clear()
	else
		arg_5_0._builidngInteractionModel = BaseModel.New()
	end
end

function var_0_0.initInteraction(arg_6_0)
	arg_6_0:_clearData()

	local var_6_0 = RoomConfig.instance:getCharacterInteractionConfigList()

	arg_6_0.hexPointRanges = HexPoint.Zero:getInRanges(2)

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = var_6_0[iter_6_0]

		if var_6_1.behaviour == RoomCharacterEnum.InteractionType.Building then
			arg_6_0:_addInteractionBuilding(var_6_1)
		end
	end
end

function var_0_0.getBuildingRangeIndexList(arg_7_0, arg_7_1)
	return arg_7_0._buildingHexpointIndexDic[arg_7_1]
end

function var_0_0._addInteractionBuilding(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:_getBuildingMOListByBuildingId(arg_8_1.buildingId)

	if var_8_0 and #var_8_0 > 0 then
		local var_8_1 = {}

		arg_8_0._buildingInteraction[arg_8_1.id] = var_8_1

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			table.insert(var_8_1, iter_8_1.id)

			if not arg_8_0._buildingHexpointIndexDic[iter_8_1.id] then
				arg_8_0._buildingHexpointIndexDic[iter_8_1.id] = arg_8_0:_getBuildingRangeIndex(iter_8_1.buildingId, iter_8_1.hexPoint, iter_8_1.rotate, arg_8_0.hexPointRanges)
			end
		end

		local var_8_2 = RoomInteractionMO.New()

		var_8_2:init(arg_8_1.id, arg_8_1.id, var_8_1)
		arg_8_0._builidngInteractionModel:addAtLast(var_8_2)
	end
end

function var_0_0._getBuildingMOListByBuildingId(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = RoomMapBuildingModel.instance:getList()

	for iter_9_0 = 1, #var_9_1 do
		local var_9_2 = var_9_1[iter_9_0]

		if var_9_2.buildingId == arg_9_1 then
			table.insert(var_9_0, var_9_2)
		end
	end

	return var_9_0
end

function var_0_0._getBuildingRangeIndex(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = {}
	local var_10_1 = RoomResourceModel.instance
	local var_10_2 = RoomBuildingHelper.getOccupyDict(arg_10_1, arg_10_2, arg_10_3)

	for iter_10_0, iter_10_1 in pairs(var_10_2) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			for iter_10_4 = 1, #arg_10_4 do
				local var_10_3 = arg_10_4[iter_10_4]
				local var_10_4 = iter_10_0 + var_10_3.x
				local var_10_5 = var_10_3.y + iter_10_2
				local var_10_6 = var_10_1:getIndexByXY(var_10_4, var_10_5)

				if not tabletool.indexOf(var_10_0, var_10_6) then
					table.insert(var_10_0, var_10_6)
				end
			end
		end
	end

	return var_10_0
end

function var_0_0.getBuildingInteractionMOList(arg_11_0)
	return arg_11_0._builidngInteractionModel:getList()
end

function var_0_0.getBuildingInteractionMO(arg_12_0, arg_12_1)
	return arg_12_0._builidngInteractionModel:getById(arg_12_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
