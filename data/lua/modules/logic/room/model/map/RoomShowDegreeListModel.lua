module("modules.logic.room.model.map.RoomShowDegreeListModel", package.seeall)

local var_0_0 = class("RoomShowDegreeListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.setShowDegreeList(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = {
		count = 0,
		degree = 0
	}
	local var_3_3 = -1001
	local var_3_4 = arg_3_0:getById(var_3_3) or RoomShowDegreeMO.New()

	var_3_4:init(var_3_3, 1)
	table.insert(var_3_0, var_3_4)

	local var_3_5 = RoomMapBlockModel.instance:getFullBlockMOList()
	local var_3_6 = RoomConfig.instance

	for iter_3_0, iter_3_1 in ipairs(var_3_5) do
		if iter_3_1.blockState == RoomBlockEnum.BlockState.Map or iter_3_1.blockState == RoomBlockEnum.BlockState.Revert or arg_3_1 and iter_3_1.blockState == RoomBlockEnum.BlockState.Temp then
			local var_3_7 = var_3_6:getPackageConfigByBlockId(iter_3_1.blockId)
			local var_3_8 = var_3_7 and var_3_7.blockBuildDegree or 0

			var_3_4.degree = var_3_4.degree + var_3_8
			var_3_4.count = var_3_4.count + (var_3_7 and 1 or 0)
		end
	end

	var_3_4.degree = var_3_4.degree + RoomBlockEnum.InitBlockDegreeValue

	local var_3_9 = RoomMapBuildingModel.instance:getList()

	for iter_3_2, iter_3_3 in ipairs(var_3_9) do
		if iter_3_3.buildingState == RoomBuildingEnum.BuildingState.Map or iter_3_3.buildingState == RoomBuildingEnum.BuildingState.Revert or arg_3_1 and iter_3_3.buildingState == RoomBuildingEnum.BuildingState.Temp then
			local var_3_10 = var_3_1[iter_3_3.buildingId]

			if not var_3_10 then
				var_3_10 = arg_3_0:getById(iter_3_3.buildingId) or RoomShowDegreeMO.New()

				var_3_10:init(iter_3_3.buildingId, 2, iter_3_3.config.name)

				var_3_1[iter_3_3.buildingId] = var_3_10

				table.insert(var_3_0, var_3_10)
			end

			var_3_10.count = var_3_10.count + 1
			var_3_10.degree = var_3_10.degree + iter_3_3.config.buildDegree
		end
	end

	table.sort(var_3_0, arg_3_0._sortFunction)
	arg_3_0:setList(var_3_0)
end

function var_0_0._sortFunction(arg_4_0, arg_4_1)
	if arg_4_0.degreeType ~= arg_4_1.degreeType then
		return arg_4_0.degreeType < arg_4_1.degreeType
	end

	if arg_4_0.degree ~= arg_4_1.degree then
		return arg_4_0.degree > arg_4_1.degree
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
