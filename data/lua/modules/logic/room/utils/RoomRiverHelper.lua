module("modules.logic.room.utils.RoomRiverHelper", package.seeall)

local var_0_0 = {
	_neighborMODict = {},
	_neighborLinkResIdDict = {}
}

function var_0_0.getRiverTypeDictByMO(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}
	local var_1_2 = {}

	if not arg_1_0:isFullWater() then
		return var_1_0, var_1_1, var_1_2
	end

	if not arg_1_0:isInMapBlock() or var_0_0._isNotLink(arg_1_0) then
		local var_1_3 = arg_1_0:getDefineBlockType()

		for iter_1_0 = 1, 6 do
			var_1_0[iter_1_0] = RoomRiverEnum.LakeOutLinkType.NoLink
			var_1_1[iter_1_0] = var_1_3
		end

		return var_1_0, var_1_1
	end

	local var_1_4 = var_0_0._neighborMODict
	local var_1_5 = var_0_0._neighborLinkResIdDict
	local var_1_6 = RoomMapBlockModel.instance
	local var_1_7 = arg_1_0.hexPoint

	for iter_1_1 = 1, 6 do
		local var_1_8 = HexPoint.directions[iter_1_1]
		local var_1_9 = var_1_6:getBlockMO(var_1_7.x + var_1_8.x, var_1_7.y + var_1_8.y)

		if var_1_9 and var_1_9:isInMapBlock() and not var_0_0._isNotLink(var_1_9) then
			var_1_4[iter_1_1] = var_1_9
			var_1_5[iter_1_1] = var_1_9:getResourceId(RoomRotateHelper.rotateDirection(iter_1_1, 3), false, true)
		else
			var_1_4[iter_1_1] = nil
			var_1_5[iter_1_1] = nil
		end
	end

	local var_1_10 = arg_1_0:getDefineBlockType()

	for iter_1_2 = 1, 6 do
		local var_1_11, var_1_12, var_1_13 = var_0_0._getRiverTypeByDirection(arg_1_0, iter_1_2, var_1_4, var_1_5)

		var_1_0[iter_1_2] = var_1_11
		var_1_1[iter_1_2] = var_1_12 or var_1_10
		var_1_2[iter_1_2] = var_1_13
	end

	return var_1_0, var_1_1, var_1_2
end

function var_0_0._isNotLink(arg_2_0)
	if arg_2_0 then
		local var_2_0 = arg_2_0:getBlockDefineCfg()

		return var_2_0 and var_2_0.waterLink == 1
	end

	return false
end

function var_0_0._getRiverTypeByDirection(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0:getResourceId(arg_3_1, false, true) ~= RoomResourceEnum.ResourceId.River or not arg_3_0:isInMapBlock() then
		return RoomRiverEnum.LakeOutLinkType.NoLink
	end

	local var_3_0 = arg_3_2[arg_3_1]
	local var_3_1 = arg_3_3[arg_3_1]

	if var_3_0 then
		if var_3_1 ~= RoomResourceEnum.ResourceId.River then
			return RoomRiverEnum.LakeOutLinkType.Floor, var_3_0:getDefineBlockType()
		end

		if not var_3_0:isFullWater() then
			return RoomRiverEnum.LakeOutLinkType.River, var_3_0:getDefineBlockType()
		end
	end

	local var_3_2 = RoomRotateHelper.rotateDirection(arg_3_1, 1)
	local var_3_3 = RoomRotateHelper.rotateDirection(arg_3_1, -1)
	local var_3_4 = arg_3_2[var_3_2]
	local var_3_5 = arg_3_2[var_3_3]
	local var_3_6 = arg_3_3[var_3_2]
	local var_3_7 = arg_3_3[var_3_3]
	local var_3_8 = RoomResourceEnum.ResourceId.River
	local var_3_9 = RoomResourceEnum.ResourceId.River
	local var_3_10 = var_0_0._checkSideFloor(var_3_8, var_3_4, var_3_6)
	local var_3_11 = var_0_0._checkSideFloor(var_3_9, var_3_5, var_3_7)

	if not var_3_10 and not var_3_11 then
		return RoomRiverEnum.LakeOutLinkType.NoLink
	end

	if var_3_10 and not var_3_11 then
		return RoomRiverEnum.LakeOutLinkType.Left, var_3_4:getDefineBlockType()
	end

	if not var_3_10 and var_3_11 then
		return RoomRiverEnum.LakeOutLinkType.Right, var_3_5:getDefineBlockType()
	end

	local var_3_12 = var_3_4:getDefineBlockType()
	local var_3_13 = var_3_5:getDefineBlockType()

	return RoomRiverEnum.LakeOutLinkType.RightLeft, var_3_13, var_3_12
end

function var_0_0._checkSideFloor(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0 ~= RoomResourceEnum.ResourceId.River or not arg_4_1 or arg_4_1:isFullWater() and arg_4_2 == RoomResourceEnum.ResourceId.River then
		return false
	end

	return true
end

return var_0_0
