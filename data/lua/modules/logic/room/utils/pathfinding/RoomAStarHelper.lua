module("modules.logic.room.utils.pathfinding.RoomAStarHelper", package.seeall)

return {
	_walkableTagCondition = nil,
	walkableTag = function (slot0, slot1)
		if not uv0._walkableTagCondition then
			uv0._walkableTagCondition = {
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

		if uv0._walkableTagCondition[slot0] and tabletool.indexOf(slot2, slot1) then
			return true
		end

		return false
	end,
	resourcePoint2HollowHexPoint = function (slot0)
		slot1 = slot0.x * 3

		if slot0.direction == 1 then
			slot2 = slot0.y * 3 - 1
		elseif slot3 == 2 then
			slot1 = slot1 + 1
			slot2 = slot2 - 1
		elseif slot3 == 3 then
			slot1 = slot1 + 1
		elseif slot3 == 4 then
			slot2 = slot2 + 1
		elseif slot3 == 5 then
			slot1 = slot1 - 1
			slot2 = slot2 + 1
		elseif slot3 == 6 then
			slot1 = slot1 - 1
		end

		return HexPoint(slot1, slot2)
	end,
	hollowHexPoint2ResourcePoint = function (slot0)
		slot1 = math.floor(slot0.q / 3)
		slot2 = math.floor(slot0.r / 3)
		slot3 = 0

		if RoomRotateHelper.getMod(slot0.q, 3) == 0 then
			if RoomRotateHelper.getMod(slot0.r, 3) == 1 then
				slot3 = 4
			elseif slot5 == 2 then
				slot2 = slot2 + 1
				slot3 = 1
			end
		elseif slot4 == 1 then
			if slot5 == 0 then
				slot3 = 3
			elseif slot5 == 1 then
				return nil
			elseif slot5 == 2 then
				slot2 = slot2 + 1
				slot3 = 2
			end
		elseif slot4 == 2 then
			if slot5 == 0 then
				slot1 = slot1 + 1
				slot3 = 6
			elseif slot5 == 1 then
				slot1 = slot1 + 1
				slot3 = 5
			elseif slot5 == 2 then
				return nil
			end
		end

		return ResourcePoint(HexPoint(slot1, slot2), slot3)
	end,
	heuristic = function (slot0, slot1)
		return HexPoint.Distance(uv0.resourcePoint2HollowHexPoint(slot0), uv0.resourcePoint2HollowHexPoint(slot1))
	end
}
