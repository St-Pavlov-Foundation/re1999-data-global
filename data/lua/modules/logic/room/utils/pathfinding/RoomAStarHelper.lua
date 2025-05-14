module("modules.logic.room.utils.pathfinding.RoomAStarHelper", package.seeall)

local var_0_0 = {}

var_0_0._walkableTagCondition = nil

function var_0_0.walkableTag(arg_1_0, arg_1_1)
	if not var_0_0._walkableTagCondition then
		var_0_0._walkableTagCondition = {
			[RoomResourceEnum.ResourceId.Empty] = {
				RoomEnum.AStarLayerTag.Water,
				RoomEnum.AStarLayerTag.Default
			},
			[RoomResourceEnum.ResourceId.River] = {
				RoomEnum.AStarLayerTag.Water
			},
			[RoomResourceEnum.ResourceId.Road] = {
				RoomEnum.AStarLayerTag.Road
			},
			[RoomResourceEnum.ResourceId.Muddyway] = {
				RoomEnum.AStarLayerTag.Muddyway
			},
			[RoomResourceEnum.ResourceId.Railway] = {
				RoomEnum.AStarLayerTag.Railway
			},
			[RoomResourceEnum.ResourceId.Coast] = {
				RoomEnum.AStarLayerTag.Coast
			},
			[RoomResourceEnum.ResourceId.Road10] = {
				RoomEnum.AStarLayerTag.Road10,
				RoomEnum.AStarLayerTag.NoWalkRoad
			},
			[RoomResourceEnum.ResourceId.AirVehicle] = {
				RoomEnum.AStarLayerTag.AirVehicle,
				RoomEnum.AStarLayerTag.NoWalkRoad
			},
			[RoomResourceEnum.ResourceId.Road12] = {
				RoomEnum.AStarLayerTag.Road12,
				RoomEnum.AStarLayerTag.NoWalkRoad
			}
		}
	end

	local var_1_0 = var_0_0._walkableTagCondition[arg_1_0]

	if var_1_0 and tabletool.indexOf(var_1_0, arg_1_1) then
		return true
	end

	return false
end

function var_0_0.resourcePoint2HollowHexPoint(arg_2_0)
	local var_2_0 = arg_2_0.x * 3
	local var_2_1 = arg_2_0.y * 3
	local var_2_2 = arg_2_0.direction

	if var_2_2 == 1 then
		var_2_1 = var_2_1 - 1
	elseif var_2_2 == 2 then
		var_2_0 = var_2_0 + 1
		var_2_1 = var_2_1 - 1
	elseif var_2_2 == 3 then
		var_2_0 = var_2_0 + 1
	elseif var_2_2 == 4 then
		var_2_1 = var_2_1 + 1
	elseif var_2_2 == 5 then
		var_2_0 = var_2_0 - 1
		var_2_1 = var_2_1 + 1
	elseif var_2_2 == 6 then
		var_2_0 = var_2_0 - 1
	end

	return HexPoint(var_2_0, var_2_1)
end

function var_0_0.hollowHexPoint2ResourcePoint(arg_3_0)
	local var_3_0 = math.floor(arg_3_0.q / 3)
	local var_3_1 = math.floor(arg_3_0.r / 3)
	local var_3_2 = 0
	local var_3_3 = RoomRotateHelper.getMod(arg_3_0.q, 3)
	local var_3_4 = RoomRotateHelper.getMod(arg_3_0.r, 3)

	if var_3_3 == 0 then
		if var_3_4 == 1 then
			var_3_2 = 4
		elseif var_3_4 == 2 then
			var_3_1 = var_3_1 + 1
			var_3_2 = 1
		end
	elseif var_3_3 == 1 then
		if var_3_4 == 0 then
			var_3_2 = 3
		elseif var_3_4 == 1 then
			return nil
		elseif var_3_4 == 2 then
			var_3_1 = var_3_1 + 1
			var_3_2 = 2
		end
	elseif var_3_3 == 2 then
		if var_3_4 == 0 then
			var_3_0 = var_3_0 + 1
			var_3_2 = 6
		elseif var_3_4 == 1 then
			var_3_0 = var_3_0 + 1
			var_3_2 = 5
		elseif var_3_4 == 2 then
			return nil
		end
	end

	return ResourcePoint(HexPoint(var_3_0, var_3_1), var_3_2)
end

function var_0_0.heuristic(arg_4_0, arg_4_1)
	local var_4_0 = var_0_0.resourcePoint2HollowHexPoint(arg_4_0)
	local var_4_1 = var_0_0.resourcePoint2HollowHexPoint(arg_4_1)

	return (HexPoint.Distance(var_4_0, var_4_1))
end

return var_0_0
