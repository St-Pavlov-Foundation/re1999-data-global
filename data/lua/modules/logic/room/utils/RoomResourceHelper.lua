module("modules.logic.room.utils.RoomResourceHelper", package.seeall)

local var_0_0 = {}

function var_0_0.getResourcePointAreaMODict(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}
	local var_1_1
	local var_1_2 = true

	if arg_1_1 and #arg_1_1 > 0 then
		var_1_2 = false
		var_1_1 = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
			var_1_1[iter_1_1] = true
		end
	end

	local var_1_3 = arg_1_0 or RoomMapBlockModel.instance:getBlockMODict()

	for iter_1_2, iter_1_3 in pairs(var_1_3) do
		for iter_1_4, iter_1_5 in pairs(iter_1_3) do
			for iter_1_6 = 0, 6 do
				local var_1_4 = iter_1_5:getResourceId(iter_1_6)
				local var_1_5 = arg_1_2 and {
					var_1_4
				} or var_0_0.getPlaceResIds(var_1_4, iter_1_6, iter_1_2, iter_1_4)

				for iter_1_7, iter_1_8 in ipairs(var_1_5) do
					if var_1_2 or var_1_1[iter_1_8] then
						local var_1_6 = var_1_0[iter_1_8]

						if not var_1_6 then
							var_1_6 = RoomMapResorcePointAreaMO.New()

							var_1_6:init(iter_1_8, iter_1_8)

							var_1_0[iter_1_8] = var_1_6
						end

						local var_1_7 = ResourcePoint(HexPoint(iter_1_2, iter_1_4), iter_1_6)

						var_1_6:addResPoint(var_1_7)
					end
				end
			end
		end
	end

	return var_1_0
end

function var_0_0.getAllResourceAreas(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0 = arg_2_0 or RoomMapBlockModel.instance:getBlockMODict()

	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = {}
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			for iter_2_4 = 0, 6 do
				local var_2_4 = var_0_0._getResourceIds(iter_2_3, iter_2_4, iter_2_0, iter_2_2)

				for iter_2_5, iter_2_6 in ipairs(var_2_4) do
					local var_2_5 = ResourcePoint(HexPoint(iter_2_0, iter_2_2), iter_2_4)

					if not var_0_0._getFromClosePointDict(var_2_0, var_2_5, iter_2_6) then
						local var_2_6, var_2_7 = var_0_0.getResourceArea(arg_2_0, {
							var_2_5
						}, iter_2_6, var_2_0, arg_2_1, arg_2_2)

						if #var_2_6 > 0 then
							table.insert(var_2_1, var_2_6)
							table.insert(var_2_2, iter_2_6)
							table.insert(var_2_3, var_2_7)
						end
					end
				end
			end
		end
	end

	return var_2_1, var_2_2, var_2_3
end

function var_0_0.getResourceArea(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0 = arg_3_0 or RoomMapBlockModel.instance:getBlockMODict()

	local var_3_0 = {}
	local var_3_1 = {}

	arg_3_3 = arg_3_3 or {}

	if arg_3_2 == RoomResourceEnum.ResourceId.None then
		return var_3_0, var_3_1
	end

	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if not var_0_0._getFromClosePointDict(arg_3_3, iter_3_1, arg_3_2) then
			local var_3_3 = arg_3_0[iter_3_1.x] and arg_3_0[iter_3_1.x][iter_3_1.y]

			if var_3_3 and (var_3_3.blockState == RoomBlockEnum.BlockState.Map or arg_3_4 and var_3_3.blockState == RoomBlockEnum.BlockState.Temp or var_3_3.blockState == RoomBlockEnum.BlockState.Inventory) and var_3_3:getResourceId(iter_3_1.direction) == arg_3_2 then
				table.insert(var_3_0, iter_3_1)
				table.insert(var_3_2, iter_3_1)
			end

			var_0_0._addToClosePointDict(arg_3_3, iter_3_1, arg_3_2)
		end
	end

	while #var_3_2 > 0 do
		local var_3_4 = {}

		for iter_3_2, iter_3_3 in ipairs(var_3_2) do
			local var_3_5, var_3_6 = var_0_0._getConnectResourcePoints(arg_3_0, iter_3_3, arg_3_2, arg_3_4, arg_3_5)

			for iter_3_4, iter_3_5 in ipairs(var_3_6) do
				table.insert(var_3_1, iter_3_5)
			end

			for iter_3_6, iter_3_7 in ipairs(var_3_5) do
				if not var_0_0._getFromClosePointDict(arg_3_3, iter_3_7, arg_3_2) then
					table.insert(var_3_0, iter_3_7)
					table.insert(var_3_4, iter_3_7)
				end

				var_0_0._addToClosePointDict(arg_3_3, iter_3_7, arg_3_2)
			end
		end

		var_3_2 = var_3_4
	end

	return var_3_0, var_3_1
end

function var_0_0._getConnectResourcePoints(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0 = arg_4_0 or RoomMapBlockModel.instance:getBlockMODict()

	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = arg_4_0[arg_4_1.x] and arg_4_0[arg_4_1.x][arg_4_1.y]

	if not var_4_2 or var_4_2.blockState ~= RoomBlockEnum.BlockState.Map and (not arg_4_3 or var_4_2.blockState ~= RoomBlockEnum.BlockState.Temp) and var_4_2.blockState ~= RoomBlockEnum.BlockState.Inventory then
		return var_4_0, var_4_1
	end

	local var_4_3

	if arg_4_4 then
		var_4_3 = arg_4_1:GetConnectsAll()
	else
		var_4_3 = arg_4_1:GetConnects()
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		local var_4_4 = arg_4_0[iter_4_1.x] and arg_4_0[iter_4_1.x][iter_4_1.y]

		if var_4_4 and (var_4_4.blockState == RoomBlockEnum.BlockState.Map or arg_4_3 and var_4_4.blockState == RoomBlockEnum.BlockState.Temp or var_4_4.blockState == RoomBlockEnum.BlockState.Inventory) then
			if var_0_0._isCanConnect(var_4_4, iter_4_1.direction, arg_4_2, iter_4_1.x, iter_4_1.y) then
				table.insert(var_4_0, iter_4_1)
			end
		elseif not var_4_4 or var_4_4.blockState == RoomBlockEnum.BlockState.Water then
			table.insert(var_4_1, iter_4_1)
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.getPlaceResIds(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = RoomMapBuildingModel.instance:getBuildingParam(arg_5_2, arg_5_3)

	if var_5_0 and var_5_0.isCrossload and var_5_0.replacResPoins then
		local var_5_1 = {}
		local var_5_2 = RoomRotateHelper.rotateDirection(arg_5_1, -var_5_0.blockRotate)

		for iter_5_0, iter_5_1 in pairs(var_5_0.replacResPoins) do
			local var_5_3 = iter_5_1[var_5_2] or arg_5_0

			if not tabletool.indexOf(var_5_1, var_5_3) then
				table.insert(var_5_1, var_5_3)
			end
		end

		if #var_5_1 < 1 then
			table.insert(var_5_1, arg_5_0)
		end

		return var_5_1
	end

	return {
		arg_5_0
	}
end

function var_0_0._getResourceIds(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:getResourceId(arg_6_1)

	return var_0_0.getPlaceResIds(var_6_0, arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0._isCanConnect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0:getResourceId(arg_7_1)
	local var_7_1 = var_0_0.getPlaceResIds(var_7_0, arg_7_1, arg_7_3, arg_7_4)

	if tabletool.indexOf(var_7_1, arg_7_2) then
		return true
	end

	return false
end

function var_0_0._addToClosePointDict(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0[arg_8_1.x] = arg_8_0[arg_8_1.x] or {}
	arg_8_0[arg_8_1.x][arg_8_1.y] = arg_8_0[arg_8_1.x][arg_8_1.y] or {}
	arg_8_0[arg_8_1.x][arg_8_1.y][arg_8_1.direction] = arg_8_0[arg_8_1.x][arg_8_1.y][arg_8_1.direction] or {}
	arg_8_0[arg_8_1.x][arg_8_1.y][arg_8_1.direction][arg_8_2] = true
end

function var_0_0._getFromClosePointDict(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0[arg_9_1.x] and arg_9_0[arg_9_1.x][arg_9_1.y] and arg_9_0[arg_9_1.x][arg_9_1.y][arg_9_1.direction] and arg_9_0[arg_9_1.x][arg_9_1.y][arg_9_1.direction][arg_9_2]
end

return var_0_0
