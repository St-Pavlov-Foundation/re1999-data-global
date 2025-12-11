module("modules.logic.room.utils.RoomLayoutHelper", package.seeall)

local var_0_0 = {
	tipLayoutAnchor = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
		local var_1_0 = recthelper.rectToRelativeAnchorPos(arg_1_2, arg_1_1)
		local var_1_1 = var_1_0.x
		local var_1_2 = var_1_0.y
		local var_1_3 = recthelper.getWidth(arg_1_1)
		local var_1_4 = recthelper.getHeight(arg_1_1)
		local var_1_5 = var_1_3 * 0.5
		local var_1_6 = var_1_4 * 0.5
		local var_1_7 = recthelper.getWidth(arg_1_0)
		local var_1_8 = recthelper.getHeight(arg_1_0)
		local var_1_9 = var_1_7 * 0.5
		local var_1_10 = var_1_8 * 0.5
		local var_1_11 = 0

		if arg_1_4 and arg_1_4 > 0 and var_1_10 < var_1_6 then
			if var_1_2 > 0 then
				var_1_11 = var_1_2 + arg_1_4 - var_1_10
			else
				var_1_11 = var_1_2 + var_1_10 - arg_1_4
			end

			local var_1_12 = var_1_6 - var_1_10

			if var_1_12 <= var_1_11 then
				var_1_11 = var_1_12
			elseif var_1_11 <= -var_1_12 then
				var_1_11 = -var_1_12
			end
		end

		if var_1_5 >= var_1_1 + var_1_7 + arg_1_3 then
			transformhelper.setLocalPos(arg_1_0, var_1_1 + arg_1_3 + var_1_9, var_1_11, 0)
		else
			transformhelper.setLocalPos(arg_1_0, var_1_1 - arg_1_3 - var_1_9, var_1_11, 0)
		end
	end,
	findBlockInfos = function(arg_2_0, arg_2_1)
		local var_2_0 = {}
		local var_2_1 = {}

		if not arg_2_0 then
			return var_2_0, var_2_1
		end

		local var_2_2 = RoomConfig.instance
		local var_2_3 = arg_2_1 == true

		for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
			local var_2_4 = not var_2_2:getInitBlock(iter_2_1.blockId) and var_2_2:getBlock(iter_2_1.blockId)

			if var_2_4 then
				local var_2_5 = var_2_4.packageId

				if var_2_3 and RoomBlockPackageEnum.ID.RoleBirthday == var_2_5 then
					table.insert(var_2_1, iter_2_1.blockId)
				elseif not var_2_0[var_2_5] then
					var_2_0[var_2_5] = 1
				else
					var_2_0[var_2_5] = var_2_0[var_2_5] + 1
				end
			end
		end

		return var_2_0, var_2_1
	end,
	findbuildingInfos = function(arg_3_0)
		local var_3_0 = {}

		if not arg_3_0 then
			return var_3_0
		end

		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			local var_3_1 = iter_3_1.defineId

			if not var_3_0[var_3_1] then
				var_3_0[var_3_1] = 1
			else
				var_3_0[var_3_1] = var_3_0[var_3_1] + 1
			end
		end

		return var_3_0
	end
}

function var_0_0.createInfoByObInfo(arg_4_0)
	local var_4_0 = {
		infos = {},
		buildingInfos = {}
	}

	tabletool.addValues(var_4_0.infos, arg_4_0.infos)
	tabletool.addValues(var_4_0.buildingInfos, arg_4_0.buildingInfos)

	local var_4_1, var_4_2 = var_0_0.sunDegreeInfos(var_4_0.infos, var_4_0.buildingInfos)

	var_4_0.buildingDegree = var_4_1
	var_4_0.blockCount = var_4_2
	var_4_0.changeColorCount = arg_4_0.changeColorCount

	return var_4_0
end

function var_0_0.sunDegreeInfos(arg_5_0, arg_5_1)
	local var_5_0 = RoomBlockEnum.InitBlockDegreeValue
	local var_5_1 = 0
	local var_5_2 = RoomConfig.instance

	if arg_5_0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
			if not var_5_2:getInitBlock(iter_5_1.blockId) then
				var_5_1 = var_5_1 + 1

				local var_5_3 = var_5_2:getPackageConfigByBlockId(iter_5_1.blockId)

				if var_5_3 then
					var_5_0 = var_5_0 + var_5_3.blockBuildDegree
				end
			end
		end
	end

	if arg_5_1 then
		for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
			local var_5_4 = var_5_2:getBuildingConfig(iter_5_3.defineId)

			if var_5_4 then
				var_5_0 = var_5_0 + var_5_4.buildDegree
			end
		end
	end

	return var_5_0, var_5_1
end

function var_0_0.comparePlanInfo(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3, var_6_4 = var_0_0.findBlockInfos(arg_6_0.infos)
	local var_6_5 = var_0_0.findbuildingInfos(arg_6_0.buildingInfos)
	local var_6_6

	if arg_6_1 ~= false then
		var_6_6 = {}
	end

	local var_6_7 = var_0_0._checkNeedNum

	for iter_6_0, iter_6_1 in pairs(var_6_3) do
		var_6_0 = var_6_0 + var_6_7(MaterialEnum.MaterialType.BlockPackage, iter_6_0, 1, var_6_6)
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_4) do
		var_6_1 = var_6_1 + var_6_7(MaterialEnum.MaterialType.SpecialBlock, iter_6_3, 1, var_6_6)
	end

	for iter_6_4, iter_6_5 in pairs(var_6_5) do
		var_6_2 = var_6_2 + var_6_7(MaterialEnum.MaterialType.Building, iter_6_4, iter_6_5, var_6_6)
	end

	return var_6_0, var_6_1, var_6_2, var_6_6
end

function var_0_0._checkNeedNum(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 < 1 then
		return 0
	end

	local var_7_0 = ItemModel.instance
	local var_7_1 = var_7_0:getItemQuantity(arg_7_0, arg_7_1) or 0
	local var_7_2 = math.max(var_7_1, 0)

	if var_7_2 < arg_7_2 then
		if arg_7_3 then
			local var_7_3 = var_7_0:getItemConfig(arg_7_0, arg_7_1)

			if var_7_3 then
				table.insert(arg_7_3, var_7_3.name)
			else
				table.insert(arg_7_3, arg_7_0 .. ":" .. arg_7_1)
			end
		end

		return arg_7_2 - var_7_2
	end

	return 0
end

function var_0_0.connStrList(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0
	local var_8_1 = #arg_8_0

	arg_8_3 = arg_8_3 or var_8_1

	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		if iter_8_0 == 1 then
			var_8_0 = iter_8_1
		elseif iter_8_0 == var_8_1 and iter_8_0 > 1 then
			var_8_0 = var_8_0 .. arg_8_2 .. iter_8_1
		elseif arg_8_3 < iter_8_0 then
			var_8_0 = var_8_0 .. "..."

			break
		else
			var_8_0 = var_8_0 .. arg_8_1 .. iter_8_1
		end
	end

	return var_8_0
end

function var_0_0.checkVisitParamCoppare(arg_9_0)
	if arg_9_0 and arg_9_0.isCompareInfo == true then
		return true
	end

	return false
end

function var_0_0.findHasBlockBuildingInfos(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = var_0_0.findHasBlockInfos(arg_10_0)
	local var_10_2 = var_0_0.findHasBuildingInfos(arg_10_1, var_10_1)

	return var_10_0, var_10_2
end

function var_0_0.findHasBlockInfos(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}

	if not arg_11_0 then
		return var_11_0, var_11_1
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		if var_0_0.isHasBlockById(iter_11_1.blockId) then
			table.insert(var_11_0, iter_11_1)
		else
			table.insert(var_11_1, iter_11_1)
		end
	end

	return var_11_0, var_11_1
end

function var_0_0.findHasBuildingInfos(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = {}

	if not arg_12_0 then
		return var_12_0, var_12_1
	end

	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
		local var_12_3 = iter_12_1.defineId
		local var_12_4 = var_12_2[var_12_3] or 0

		if var_12_4 < RoomModel.instance:getBuildingCount(var_12_3) and not var_0_0._isInRemoveBlock(iter_12_1, arg_12_1) then
			var_12_2[var_12_3] = var_12_4 + 1

			table.insert(var_12_0, iter_12_1)
		else
			table.insert(var_12_1, iter_12_1)
		end
	end

	return var_12_0, var_12_1
end

function var_0_0._isInRemoveBlock(arg_13_0, arg_13_1)
	if not arg_13_1 or #arg_13_1 < 1 then
		return false
	end

	local var_13_0 = HexPoint(arg_13_0.x, arg_13_0.y)
	local var_13_1 = RoomBuildingHelper.getOccupyDict(arg_13_0.defineId, var_13_0, arg_13_0.rotate, arg_13_0.uid)

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if var_13_1[iter_13_1.x] and var_13_1[iter_13_1.x][iter_13_1.y] then
			return true
		end
	end

	return false
end

function var_0_0.isHasBlockById(arg_14_0)
	local var_14_0 = RoomConfig.instance

	if var_14_0:getInitBlock(arg_14_0) then
		return true
	end

	local var_14_1 = var_14_0:getBlock(arg_14_0)

	if var_14_1 then
		local var_14_2 = 1

		if RoomBlockPackageEnum.ID.RoleBirthday == var_14_1.packageId then
			var_14_2 = var_0_0._checkNeedNum(MaterialEnum.MaterialType.SpecialBlock, arg_14_0, 1)
		else
			var_14_2 = var_0_0._checkNeedNum(MaterialEnum.MaterialType.BlockPackage, var_14_1.packageId, 1)
		end

		if var_14_2 == 0 then
			return true
		end
	end

	return false
end

return var_0_0
