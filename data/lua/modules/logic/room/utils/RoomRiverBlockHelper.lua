module("modules.logic.room.utils.RoomRiverBlockHelper", package.seeall)

local var_0_0 = {}

var_0_0.TypeToFunction = nil

function var_0_0._getFunctionByType(arg_1_0)
	if not var_0_0.TypeToFunction then
		var_0_0.TypeToFunction = {
			[RoomDistributionEnum.DistributionType.C1TA] = var_0_0._getRiverBlockType_C1TA,
			[RoomDistributionEnum.DistributionType.C2TA] = var_0_0._getRiverBlockType_C2TA,
			[RoomDistributionEnum.DistributionType.C2TB] = var_0_0._getRiverBlockType_C2TB,
			[RoomDistributionEnum.DistributionType.C2TC] = var_0_0._getRiverBlockType_C2TC,
			[RoomDistributionEnum.DistributionType.C3TA] = var_0_0._getRiverBlockType_C3TA,
			[RoomDistributionEnum.DistributionType.C3TB] = var_0_0._getRiverBlockType_C3TB,
			[RoomDistributionEnum.DistributionType.C3TC] = var_0_0._getRiverBlockType_C3TC,
			[RoomDistributionEnum.DistributionType.C3TD] = var_0_0._getRiverBlockType_C3TD,
			[RoomDistributionEnum.DistributionType.C4TA] = var_0_0._getRiverBlockType_C4TA,
			[RoomDistributionEnum.DistributionType.C4TB] = var_0_0._getRiverBlockType_C4TB,
			[RoomDistributionEnum.DistributionType.C4TC] = var_0_0._getRiverBlockType_C4TC,
			[RoomDistributionEnum.DistributionType.C5TA] = var_0_0._getRiverBlockType_C5TA,
			[RoomDistributionEnum.DistributionType.C6TA] = var_0_0._getRiverBlockType_C6TA
		}
	end

	return var_0_0.TypeToFunction[arg_1_0]
end

function var_0_0.getRiverBlockTypeByMO(arg_2_0)
	local var_2_0 = {}

	for iter_2_0 = 1, 6 do
		table.insert(var_2_0, arg_2_0:getResourceId(iter_2_0, false, true))
	end

	local var_2_1 = {}

	if arg_2_0:isInMap() then
		for iter_2_1 = 1, 6 do
			local var_2_2 = arg_2_0.hexPoint:getNeighbor(iter_2_1)
			local var_2_3 = RoomMapBlockModel.instance:getBlockMO(var_2_2.x, var_2_2.y)

			if var_2_3 then
				var_2_1[iter_2_1] = {}

				for iter_2_2 = 1, 6 do
					table.insert(var_2_1[iter_2_1], var_2_3:getResourceId(iter_2_2, false, true))
				end
			end
		end
	end

	local var_2_4 = arg_2_0:getDefineBlockType()
	local var_2_5 = arg_2_0:getDefineWaterType()

	return var_0_0.getRiverBlockType(var_2_0, var_2_1, arg_2_0:getRotate(), var_2_4, var_2_5)
end

function var_0_0.getRiverBlockType(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = {}
	local var_3_3 = 0

	for iter_3_0 = 1, 6 do
		local var_3_4 = arg_3_0[iter_3_0] == RoomResourceEnum.ResourceId.River

		if var_3_4 then
			var_3_3 = var_3_3 + 1
		end

		table.insert(var_3_0, var_3_4)
	end

	for iter_3_1 = 1, 6 do
		local var_3_5 = arg_3_1[iter_3_1]

		if var_3_5 then
			local var_3_6 = true
			local var_3_7 = RoomRotateHelper.oppositeDirection(iter_3_1)

			for iter_3_2 = 1, 6 do
				local var_3_8 = var_3_5[iter_3_2] == RoomResourceEnum.ResourceId.River or var_3_5[iter_3_2] == RoomResourceEnum.ResourceId.Empty

				if not var_3_8 then
					var_3_6 = false
				end

				if iter_3_2 == var_3_7 then
					table.insert(var_3_1, var_3_8)
				end
			end

			table.insert(var_3_2, var_3_6)
		else
			table.insert(var_3_1, true)
			table.insert(var_3_2, true)
		end
	end

	if var_3_3 > 0 then
		local var_3_9 = RoomDistributionEnum.CountToTypeList[var_3_3]

		for iter_3_3, iter_3_4 in ipairs(var_3_9) do
			local var_3_10, var_3_11 = RoomDistributionHelper.matchType(iter_3_4, var_3_0, arg_3_2)

			if var_3_10 then
				local var_3_12, var_3_13 = var_0_0._getFunctionByType(iter_3_4)(var_3_0, var_3_1, var_3_2)
				local var_3_14
				local var_3_15
				local var_3_16
				local var_3_17

				var_3_13 = var_3_13 or 0

				if var_3_12 then
					var_3_16, var_3_17 = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, var_3_12, arg_3_4)
					var_3_14, var_3_15 = RoomResHelper.getMapRiverFloorResPath(var_3_12, arg_3_3)
				end

				local var_3_18 = RoomRotateHelper.rotateRotate(var_3_11, -arg_3_2)
				local var_3_19 = RoomRotateHelper.rotateRotate(var_3_18, var_3_13)

				return var_3_16, var_3_19, var_3_14, var_3_17, var_3_15
			end
		end
	end
end

function var_0_0._getRiverX(arg_4_0, arg_4_1)
	return not arg_4_1 and arg_4_0 .. "x" or arg_4_0
end

function var_0_0._getRiverBlockType_C1TA(arg_5_0, arg_5_1, arg_5_2)
	return RoomRiverEnum.RiverBlockType["4000"], -1
end

function var_0_0._getRiverBlockType_C2TA(arg_6_0, arg_6_1, arg_6_2)
	return RoomRiverEnum.RiverBlockType["4002"], -1
end

function var_0_0._getRiverBlockType_C2TB(arg_7_0, arg_7_1, arg_7_2)
	return RoomRiverEnum.RiverBlockType["4003"], -1
end

function var_0_0._getRiverBlockType_C2TC(arg_8_0, arg_8_1, arg_8_2)
	return RoomRiverEnum.RiverBlockType["4001"], -1
end

function var_0_0._getRiverBlockType_C3TA(arg_9_0, arg_9_1, arg_9_2)
	return RoomRiverEnum.RiverBlockType["4004"], 0
end

function var_0_0._getRiverBlockType_C3TB(arg_10_0, arg_10_1, arg_10_2)
	return RoomRiverEnum.RiverBlockType["4006"], 0
end

function var_0_0._getRiverBlockType_C3TC(arg_11_0, arg_11_1, arg_11_2)
	return RoomRiverEnum.RiverBlockType["4005"], -1
end

function var_0_0._getRiverBlockType_C3TD(arg_12_0, arg_12_1, arg_12_2)
	return RoomRiverEnum.RiverBlockType["4007"], -1
end

function var_0_0._getRiverBlockType_C4TA(arg_13_0, arg_13_1, arg_13_2)
	return RoomRiverEnum.RiverBlockType["4008"], 1
end

function var_0_0._getRiverBlockType_C4TB(arg_14_0, arg_14_1, arg_14_2)
	return RoomRiverEnum.RiverBlockType["4009"], 0
end

function var_0_0._getRiverBlockType_C4TC(arg_15_0, arg_15_1, arg_15_2)
	return RoomRiverEnum.RiverBlockType["4010"], -1
end

function var_0_0._getRiverBlockType_C5TA(arg_16_0, arg_16_1, arg_16_2)
	return RoomRiverEnum.RiverBlockType["4011"], -1
end

function var_0_0._getRiverBlockType_C6TA(arg_17_0, arg_17_1, arg_17_2)
	return nil
end

return var_0_0
