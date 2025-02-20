module("modules.logic.room.utils.RoomResourceHelper", package.seeall)

return {
	getResourcePointAreaMODict = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = nil
		slot5 = true

		if slot1 and #slot1 > 0 then
			slot5 = false
			slot4 = {
				[slot10] = true
			}

			for slot9, slot10 in ipairs(slot1) do
				-- Nothing
			end
		end

		for slot10, slot11 in pairs(slot0 or RoomMapBlockModel.instance:getBlockMODict()) do
			for slot15, slot16 in pairs(slot11) do
				for slot20 = 0, 6 do
					slot21 = slot16:getResourceId(slot20)

					for slot26, slot27 in ipairs(slot2 and {
						slot21
					} or uv0.getPlaceResIds(slot21, slot20, slot10, slot15)) do
						if slot5 or slot4[slot27] then
							if not slot3[slot27] then
								slot28 = RoomMapResorcePointAreaMO.New()

								slot28:init(slot27, slot27)

								slot3[slot27] = slot28
							end

							slot28:addResPoint(ResourcePoint(HexPoint(slot10, slot15), slot20))
						end
					end
				end
			end
		end

		return slot3
	end,
	getAllResourceAreas = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = {}
		slot5 = {}
		slot6 = {}

		for slot10, slot11 in pairs(slot0 or RoomMapBlockModel.instance:getBlockMODict()) do
			for slot15, slot16 in pairs(slot11) do
				for slot20 = 0, 6 do
					slot25 = slot10
					slot26 = slot15

					for slot25, slot26 in ipairs(uv0._getResourceIds(slot16, slot20, slot25, slot26)) do
						if not uv0._getFromClosePointDict(slot3, ResourcePoint(HexPoint(slot10, slot15), slot20), slot26) then
							slot28, slot29 = uv0.getResourceArea(slot0, {
								slot27
							}, slot26, slot3, slot1, slot2)

							if #slot28 > 0 then
								table.insert(slot4, slot28)
								table.insert(slot5, slot26)
								table.insert(slot6, slot29)
							end
						end
					end
				end
			end
		end

		return slot4, slot5, slot6
	end,
	getResourceArea = function (slot0, slot1, slot2, slot3, slot4, slot5)
		slot0 = slot0 or RoomMapBlockModel.instance:getBlockMODict()
		slot3 = slot3 or {}

		if slot2 == RoomResourceEnum.ResourceId.None then
			return {}, {}
		end

		slot8 = {}

		for slot12, slot13 in ipairs(slot1) do
			if not uv0._getFromClosePointDict(slot3, slot13, slot2) then
				if slot0[slot13.x] and slot0[slot13.x][slot13.y] and (slot14.blockState == RoomBlockEnum.BlockState.Map or slot4 and slot14.blockState == RoomBlockEnum.BlockState.Temp or slot14.blockState == RoomBlockEnum.BlockState.Inventory) and slot14:getResourceId(slot13.direction) == slot2 then
					table.insert(slot6, slot13)
					table.insert(slot8, slot13)
				end

				uv0._addToClosePointDict(slot3, slot13, slot2)
			end
		end

		while #slot8 > 0 do
			slot9 = {}

			for slot13, slot14 in ipairs(slot8) do
				slot20 = slot4
				slot21 = slot5
				slot15, slot16 = uv0._getConnectResourcePoints(slot0, slot14, slot2, slot20, slot21)

				for slot20, slot21 in ipairs(slot16) do
					table.insert(slot7, slot21)
				end

				for slot20, slot21 in ipairs(slot15) do
					if not uv0._getFromClosePointDict(slot3, slot21, slot2) then
						table.insert(slot6, slot21)
						table.insert(slot9, slot21)
					end

					uv0._addToClosePointDict(slot3, slot21, slot2)
				end
			end

			slot8 = slot9
		end

		return slot6, slot7
	end,
	_getConnectResourcePoints = function (slot0, slot1, slot2, slot3, slot4)
		slot0 = slot0 or RoomMapBlockModel.instance:getBlockMODict()

		if not slot0[slot1.x] or not slot0[slot1.x][slot1.y] or slot7.blockState ~= RoomBlockEnum.BlockState.Map and (not slot3 or slot7.blockState ~= RoomBlockEnum.BlockState.Temp) and slot7.blockState ~= RoomBlockEnum.BlockState.Inventory then
			return {}, {}
		end

		slot8 = nil

		for slot12, slot13 in ipairs((not slot4 or slot1:GetConnectsAll()) and slot1:GetConnects()) do
			if slot0[slot13.x] and slot0[slot13.x][slot13.y] and (slot14.blockState == RoomBlockEnum.BlockState.Map or slot3 and slot14.blockState == RoomBlockEnum.BlockState.Temp or slot14.blockState == RoomBlockEnum.BlockState.Inventory) then
				if uv0._isCanConnect(slot14, slot13.direction, slot2, slot13.x, slot13.y) then
					table.insert(slot5, slot13)
				end
			elseif not slot14 or slot14.blockState == RoomBlockEnum.BlockState.Water then
				table.insert(slot6, slot13)
			end
		end

		return slot5, slot6
	end,
	getPlaceResIds = function (slot0, slot1, slot2, slot3)
		if RoomMapBuildingModel.instance:getBuildingParam(slot2, slot3) and slot4.isCrossload and slot4.replacResPoins then
			slot5 = {}

			for slot10, slot11 in pairs(slot4.replacResPoins) do
				if not tabletool.indexOf(slot5, slot11[RoomRotateHelper.rotateDirection(slot1, -slot4.blockRotate)] or slot0) then
					table.insert(slot5, slot12)
				end
			end

			if #slot5 < 1 then
				table.insert(slot5, slot0)
			end

			return slot5
		end

		return {
			slot0
		}
	end,
	_getResourceIds = function (slot0, slot1, slot2, slot3)
		return uv0.getPlaceResIds(slot0:getResourceId(slot1), slot1, slot2, slot3)
	end,
	_isCanConnect = function (slot0, slot1, slot2, slot3, slot4)
		if tabletool.indexOf(uv0.getPlaceResIds(slot0:getResourceId(slot1), slot1, slot3, slot4), slot2) then
			return true
		end

		return false
	end,
	_addToClosePointDict = function (slot0, slot1, slot2)
		slot0[slot1.x] = slot0[slot1.x] or {}
		slot0[slot1.x][slot1.y] = slot0[slot1.x][slot1.y] or {}
		slot0[slot1.x][slot1.y][slot1.direction] = slot0[slot1.x][slot1.y][slot1.direction] or {}
		slot0[slot1.x][slot1.y][slot1.direction][slot2] = true
	end,
	_getFromClosePointDict = function (slot0, slot1, slot2)
		return slot0[slot1.x] and slot0[slot1.x][slot1.y] and slot0[slot1.x][slot1.y][slot1.direction] and slot0[slot1.x][slot1.y][slot1.direction][slot2]
	end
}
