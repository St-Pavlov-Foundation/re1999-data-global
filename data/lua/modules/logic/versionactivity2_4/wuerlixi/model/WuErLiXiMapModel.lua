module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapModel", package.seeall)

slot0 = class("WuErLiXiMapModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._mapDict = {}
	slot0._curMapId = 0
	slot0._curSelectNode = {}
	slot0._unlockElements = {}
end

function slot0._initUnlockElements(slot0)
	slot0._unlockElements = string.splitToNumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.WuErLiXiUnlockUnits, ""), "#") or {}
end

function slot0.initMap(slot0, slot1)
	if not slot0._mapDict[slot1 or slot0._curMapId] then
		slot0._mapDict[slot1] = WuErLiXiMapMo.New()
	end

	slot0._mapDict[slot1]:init(WuErLiXiConfig.instance:getMapCo(slot1))
end

function slot0.resetMap(slot0, slot1)
	slot0:initMap(slot1 or slot0._curMapId)
end

function slot0.getMap(slot0, slot1)
	if not slot0._mapDict[slot1 or slot0._curMapId] then
		slot0:initMap(slot1)
	end

	return slot0._mapDict[slot1]
end

function slot0.setCurMapId(slot0, slot1)
	slot0._curMapId = slot1
end

function slot0.getCurMapId(slot0)
	return slot0._curMapId
end

function slot0.getMapLimitActUnits(slot0, slot1)
	return slot0._mapDict[slot1 or slot0._curMapId].actUnitDict
end

function slot0.getMapNodes(slot0, slot1)
	return slot0._mapDict[slot1 or slot0._curMapId].nodeDict
end

function slot0.getMapLineCount(slot0, slot1)
	return slot0._mapDict[slot1 or slot0._curMapId].lineCount
end

function slot0.getMapRowCount(slot0, slot1)
	return slot0._mapDict[slot1 or slot0._curMapId].rowCount
end

function slot0.setUnitDir(slot0, slot1, slot2, slot3)
	if not slot1:getNodeUnit() then
		return
	end

	slot5 = slot0:getMapNodes()

	if slot4.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if slot2 == WuErLiXiEnum.Dir.Up or slot2 == WuErLiXiEnum.Dir.Down then
			if slot5[slot1.y][slot1.x - 1] then
				if slot5[slot1.y][slot1.x - 1]:getNodeUnit() then
					return
				end
			else
				return
			end

			if slot5[slot1.y][slot1.x + 1] then
				if slot5[slot1.y][slot1.x + 1]:getNodeUnit() then
					return
				end
			else
				return
			end
		else
			if slot5[slot1.y - 1] then
				if slot5[slot1.y - 1][slot1.x]:getNodeUnit() then
					return
				end
			else
				return
			end

			if slot5[slot1.y + 1] then
				if slot5[slot1.y + 1][slot1.x]:getNodeUnit() then
					return
				end
			else
				return
			end
		end
	end

	if slot4.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if slot3 == WuErLiXiEnum.Dir.Up or slot3 == WuErLiXiEnum.Dir.Down then
			if slot5[slot1.y][slot1.x - 1] then
				slot5[slot1.y][slot1.x - 1]:clearUnit()
				slot0:clearNodesRay(slot5[slot1.y][slot1.x - 1], slot5[slot1.y][slot1.x - 1].id, slot1:getUnitSignalOutDir(), true)
			end

			if slot5[slot1.y][slot1.x + 1] then
				slot5[slot1.y][slot1.x + 1]:clearUnit()
				slot0:clearNodesRay(slot5[slot1.y][slot1.x + 1], slot5[slot1.y][slot1.x + 1].id, slot1:getUnitSignalOutDir(), true)
			end
		else
			if slot5[slot1.y - 1] then
				slot5[slot1.y - 1][slot1.x]:clearUnit()
				slot0:clearNodesRay(slot5[slot1.y - 1][slot1.x], slot5[slot1.y - 1][slot1.x].id, slot1:getUnitSignalOutDir(), true)
			end

			if slot5[slot1.y + 1] then
				slot5[slot1.y + 1][slot1.x]:clearUnit()
				slot0:clearNodesRay(slot5[slot1.y + 1][slot1.x], slot5[slot1.y + 1][slot1.x].id, slot1:getUnitSignalOutDir(), true)
			end
		end
	end

	if not slot1:getNodeRay() then
		slot1:setDir(slot2)
		slot0:setNodeUnitByUnitMo(slot1, slot4)

		return
	end

	if slot4.unitType ~= WuErLiXiEnum.UnitType.Key then
		slot0:clearNodesRay(slot1, slot1.id, slot1:getUnitSignalOutDir(), true)
	end

	slot1:setDir(slot2, slot6.rayDir)
	slot0:setNodeUnitByUnitMo(slot1, slot4)
end

function slot0.clearNodeUnit(slot0, slot1, slot2)
	if not slot1:getNodeUnit() then
		return
	end

	slot4 = nil

	for slot9, slot10 in pairs(slot0:getMapNodes()) do
		for slot14, slot15 in pairs(slot10) do
			slot17 = slot15:getNodeRay()

			if slot15:getNodeUnit() and slot16.x == slot3.x and slot16.y == slot3.y then
				if slot16.unitType == WuErLiXiEnum.UnitType.Key and not slot2 then
					slot0:setSwitchActive(slot16.id, false)
				end

				slot0:clearNodesRay(slot15, slot15.id, slot1:getUnitSignalOutDir(), true)

				if slot17 then
					slot4 = slot17
				end
			end
		end
	end

	for slot9, slot10 in pairs(slot5) do
		for slot14, slot15 in pairs(slot10) do
			if slot15:getNodeUnit() and slot16.x == slot3.x and slot16.y == slot3.y then
				slot5[slot15.y][slot15.x]:clearUnit()
			end
		end
	end

	if slot4 then
		slot0:fillNodeRay(slot5[slot4.rayId % 100][math.floor(slot4.rayId / 100)], slot4.rayType, slot4.rayDir, true, slot4.rayParent)
	end
end

function slot0.setNodeUnitByUnitMo(slot0, slot1, slot2, slot3)
	slot4 = slot0:getMapNodes()

	table.insert({}, slot1)

	if slot2.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if slot2.dir == WuErLiXiEnum.Dir.Up or slot2.dir == WuErLiXiEnum.Dir.Down then
			table.insert(slot5, slot4[slot1.y][slot1.x - 1])
			table.insert(slot5, slot4[slot1.y][slot1.x + 1])
		else
			table.insert(slot5, slot4[slot1.y - 1][slot1.x])
			table.insert(slot5, slot4[slot1.y + 1][slot1.x])
		end
	end

	for slot9, slot10 in pairs(slot5) do
		if slot10:getNodeRay() then
			if slot2.unitType == WuErLiXiEnum.UnitType.Key and not slot3 then
				slot0:setSwitchActive(slot2.id, slot11.rayType == slot11.rayType == WuErLiXiEnum.RayType.SwitchSignal)
			end

			slot0:clearNodesRay(slot10, slot11.rayId, slot11.rayDir, false)
		end

		slot10:setUnitByUnitMo(slot2, slot1.x, slot1.y)
	end
end

function slot0.setNodeUnitByActUnitMo(slot0, slot1, slot2)
	slot3 = slot0:getMapNodes()

	table.insert({}, slot1)

	if slot2.type == WuErLiXiEnum.UnitType.SignalMulti then
		if slot2.dir == WuErLiXiEnum.Dir.Up or slot2.dir == WuErLiXiEnum.Dir.Down then
			table.insert(slot4, slot3[slot1.y][slot1.x - 1])
			table.insert(slot4, slot3[slot1.y][slot1.x + 1])
		else
			table.insert(slot4, slot3[slot1.y - 1][slot1.x])
			table.insert(slot4, slot3[slot1.y + 1][slot1.x])
		end
	end

	for slot8, slot9 in pairs(slot4) do
		if slot9:getNodeRay() then
			if slot2.type == WuErLiXiEnum.UnitType.Key then
				slot0:setSwitchActive(slot2.id, slot10.rayType == WuErLiXiEnum.RayType.SwitchSignal)
			end

			slot0:clearNodesRay(slot9, slot10.rayId, slot10.rayDir, false)
		end

		slot9:setUnitByActUnitMo(slot2, slot1.x, slot1.y)
	end
end

function slot0.setMapData(slot0)
	slot1 = slot0:getMapNodes()
	slot2 = slot0:getMapLineCount()

	for slot7 = 1, slot0:getMapRowCount() do
		for slot11 = 1, slot2 do
			if slot1[slot11][slot7]:getNodeUnit() then
				if slot12.unitType == WuErLiXiEnum.UnitType.SignalStart then
					slot0:setMapSignalData(slot1[slot11][slot7], WuErLiXiEnum.RayType.NormalSignal)
				elseif slot12.unitType == WuErLiXiEnum.UnitType.KeyStart then
					slot0:setMapSignalData(slot1[slot11][slot7], WuErLiXiEnum.RayType.SwitchSignal)
				end
			end
		end
	end
end

function slot0.setMapSignalData(slot0, slot1, slot2)
	if not slot1:getNodeUnit() then
		return
	end

	if not slot3:getUnitSignalOutDir() then
		return
	end

	slot10 = slot4

	slot0:setUnitActive(slot1, true, slot2, slot10)

	for slot10, slot11 in pairs(slot3:getUnitSignals(slot4)) do
		slot0:fillNodeRay(slot0:getMapNodes()[slot11[2]][slot11[1]], slot2, slot3:getUnitSignalOutDir())
	end
end

function slot0.fillNodeRay(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0:getMapNodes()
	slot7 = slot0:getMapLineCount()
	slot8 = slot0:getMapRowCount()

	if slot3 == WuErLiXiEnum.Dir.Up then
		if slot1.y > 1 then
			for slot12 = slot1.y - 1, 1, -1 do
				if not slot6[slot12][slot1.x]:couldSetRay(slot2) then
					return
				end

				if slot6[slot12][slot1.x]:getNodeUnit() then
					if slot14.unitType ~= WuErLiXiEnum.UnitType.Switch or not slot14:isUnitActive() then
						slot0:setUnitActive(slot6[slot12][slot1.x], true, slot2, slot3)

						if slot6[slot12][slot1.x]:isUnitActive(slot3) then
							slot20 = slot3
							slot21 = slot5

							slot6[slot12][slot1.x]:setNodeRay(slot1.id, slot2, slot20, slot21)
							slot6[slot12][slot1.x]:setUnitOutDirByRayDir(slot3)

							for slot20, slot21 in pairs(slot14:getUnitSignals(slot3)) do
								slot0:fillNodeRay(slot6[slot12][slot21[1]], slot2, slot14:getUnitSignalOutDir(), false, slot1.id)
							end

							if slot14.unitType == WuErLiXiEnum.UnitType.Key then
								slot0:setSwitchActive(slot14.id, true)
							end
						end

						return
					elseif slot14.unitType == WuErLiXiEnum.UnitType.Switch then
						slot0:setUnitActive(slot6[slot12][slot1.x], true, slot2, slot3)
					end
				end

				if not slot6[slot12][slot1.x]:getNodeRay() then
					slot6[slot12][slot1.x]:setNodeRay(slot1.id, slot2, slot3, slot5)
				elseif slot3 == WuErLiXiHelper.getOppositeDir(slot15.rayDir) then
					return
				elseif slot15.rayId == slot1.id then
					slot6[slot12][slot1.x]:setNodeRay(slot1.id, slot2, slot3, slot5)
				else
					slot16 = slot1.y - slot12
					slot17 = math.abs(slot1.x + slot12 - slot15.rayId % 100 - math.floor(slot15.rayId / 100))

					if ServerTime.now() - slot15.rayTime > 0.1 then
						return
					end

					if slot16 < slot17 then
						if slot0:isRayParent(slot15.rayId, slot1.id) then
							return
						end

						slot0:clearNodesRay(slot6[slot12][slot1.x], slot15.rayId, slot15.rayDir, false)
						slot6[slot12][slot1.x]:setNodeRay(slot1.id, slot2, slot3, slot5)
						slot6[slot12][slot1.x]:setUnitOutDirByRayDir(slot3)
					elseif slot16 == slot17 then
						slot0:clearNodesRay(slot6[slot12][slot1.x], slot1.id, slot15.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif slot3 == WuErLiXiEnum.Dir.Down then
		if slot1.y < slot7 then
			for slot12 = slot1.y + 1, slot7 do
				if not slot6[slot12][slot1.x]:couldSetRay(slot2) then
					return
				end

				if slot6[slot12][slot1.x]:getNodeUnit() and (slot14.unitType ~= WuErLiXiEnum.UnitType.Switch or not slot14:isUnitActive()) then
					slot0:setUnitActive(slot6[slot12][slot1.x], true, slot2, slot3)

					if slot6[slot12][slot1.x]:isUnitActive(slot3) then
						slot20 = slot3
						slot21 = slot5

						slot6[slot12][slot1.x]:setNodeRay(slot1.id, slot2, slot20, slot21)
						slot6[slot12][slot1.x]:setUnitOutDirByRayDir(slot3)

						for slot20, slot21 in pairs(slot14:getUnitSignals(slot3)) do
							slot0:fillNodeRay(slot6[slot12][slot21[1]], slot2, slot14:getUnitSignalOutDir(), false, slot1.id)
						end

						if slot14.unitType == WuErLiXiEnum.UnitType.Key then
							slot0:setSwitchActive(slot14.id, true)
						end
					end

					return
				end

				if not slot6[slot12][slot1.x]:getNodeRay() then
					slot6[slot12][slot1.x]:setNodeRay(slot1.id, slot2, slot3, slot5)
				elseif slot3 == WuErLiXiHelper.getOppositeDir(slot15.rayDir) then
					return
				elseif slot15.rayId == slot1.id then
					slot6[slot12][slot1.x]:setNodeRay(slot1.id, slot2, slot3, slot5)
				else
					slot16 = math.abs(slot1.y - slot12)
					slot17 = math.abs(slot1.x + slot12 - slot15.rayId % 100 - math.floor(slot15.rayId / 100))

					if ServerTime.now() - slot15.rayTime > 0.1 then
						return
					end

					if slot16 < slot17 then
						if slot0:isRayParent(slot15.rayId, slot1.id) then
							return
						end

						slot0:clearNodesRay(slot6[slot12][slot1.x], slot15.rayId, slot15.rayDir, false)
						slot6[slot12][slot1.x]:setNodeRay(slot1.id, slot2, slot3, slot5)
						slot6[slot12][slot1.x]:setUnitOutDirByRayDir(slot3)
					elseif slot16 == slot17 then
						slot0:clearNodesRay(slot6[slot12][slot1.x], slot1.id, slot15.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif slot3 == WuErLiXiEnum.Dir.Left then
		if slot1.x > 1 then
			for slot12 = slot1.x - 1, 1, -1 do
				if not slot6[slot1.y][slot12]:couldSetRay(slot2) then
					return
				end

				if slot6[slot1.y][slot12]:getNodeUnit() and (slot14.unitType ~= WuErLiXiEnum.UnitType.Switch or not slot14:isUnitActive()) then
					slot0:setUnitActive(slot6[slot1.y][slot12], true, slot2, slot3)

					if slot6[slot1.y][slot12]:isUnitActive(slot3) then
						slot20 = slot3
						slot21 = slot5

						slot6[slot1.y][slot12]:setNodeRay(slot1.id, slot2, slot20, slot21)
						slot6[slot1.y][slot12]:setUnitOutDirByRayDir(slot3)

						for slot20, slot21 in pairs(slot14:getUnitSignals(slot3)) do
							slot0:fillNodeRay(slot6[slot21[2]][slot12], slot2, slot14:getUnitSignalOutDir(), false, slot1.id)
						end

						if slot14.unitType == WuErLiXiEnum.UnitType.Key then
							slot0:setSwitchActive(slot14.id, true)
						end

						return
					end

					return
				end

				if not slot6[slot1.y][slot12]:getNodeRay() then
					slot6[slot1.y][slot12]:setNodeRay(slot1.id, slot2, slot3, slot5)
				elseif slot3 == WuErLiXiHelper.getOppositeDir(slot15.rayDir) then
					return
				elseif slot15.rayId == slot1.id then
					slot6[slot1.y][slot12]:setNodeRay(slot1.id, slot2, slot3, slot5)
				else
					slot16 = math.abs(slot1.x - slot12)
					slot17 = math.abs(slot12 + slot1.y - slot15.rayId % 100 - math.floor(slot15.rayId / 100))

					if ServerTime.now() - slot15.rayTime > 0.1 then
						return
					end

					if slot16 < slot17 then
						if slot0._curMapId == 105 and slot1.id == 902 and slot15.rayId == 409 then
							return
						end

						if slot0:isRayParent(slot15.rayId, slot1.id) then
							return
						end

						slot0:clearNodesRay(slot6[slot1.y][slot12], slot15.rayId, slot15.rayDir, false)
						slot6[slot1.y][slot12]:setNodeRay(slot1.id, slot2, slot3, slot5)
						slot6[slot1.y][slot12]:setUnitOutDirByRayDir(slot3)
					elseif slot16 == slot17 then
						slot0:clearNodesRay(slot6[slot1.y][slot12], slot1.id, slot15.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif slot3 == WuErLiXiEnum.Dir.Right and slot1.x < slot8 then
		for slot12 = slot1.x + 1, slot8 do
			if not slot6[slot1.y][slot12]:couldSetRay(slot2) then
				return
			end

			if slot6[slot1.y][slot12]:getNodeUnit() and (slot14.unitType ~= WuErLiXiEnum.UnitType.Switch or not slot14:isUnitActive()) then
				slot0:setUnitActive(slot6[slot1.y][slot12], true, slot2, slot3)

				if slot6[slot1.y][slot12]:isUnitActive(slot3) then
					slot20 = slot3
					slot21 = slot5

					slot6[slot1.y][slot12]:setNodeRay(slot1.id, slot2, slot20, slot21)
					slot6[slot1.y][slot12]:setUnitOutDirByRayDir(slot3)

					for slot20, slot21 in pairs(slot14:getUnitSignals(slot3)) do
						slot0:fillNodeRay(slot6[slot21[2]][slot12], slot2, slot14:getUnitSignalOutDir(), false, slot1.id)
					end

					if slot14.unitType == WuErLiXiEnum.UnitType.Key then
						slot0:setSwitchActive(slot14.id, true)
					end
				end

				return
			end

			if not slot6[slot1.y][slot12]:getNodeRay() then
				slot6[slot1.y][slot12]:setNodeRay(slot1.id, slot2, slot3, slot5)
			elseif slot3 == WuErLiXiHelper.getOppositeDir(slot15.rayDir) then
				return
			elseif slot15.rayId == slot1.id then
				slot6[slot1.y][slot12]:setNodeRay(slot1.id, slot2, slot3, slot5)
			else
				slot16 = math.abs(slot1.x - slot12)
				slot17 = math.abs(slot12 + slot1.y - slot15.rayId % 100 - math.floor(slot15.rayId / 100))

				if ServerTime.now() - slot15.rayTime > 0.1 then
					return
				end

				if slot16 < slot17 then
					if slot0:isRayParent(slot15.rayId, slot1.id) then
						return
					end

					slot0:clearNodesRay(slot6[slot1.y][slot12], slot15.rayId, slot15.rayDir, false)
					slot6[slot1.y][slot12]:setNodeRay(slot1.id, slot2, slot3, slot5)
					slot6[slot1.y][slot12]:setUnitOutDirByRayDir(slot3)
				elseif slot16 == slot17 then
					slot0:clearNodesRay(slot6[slot1.y][slot12], slot1.id, slot15.rayDir, false)

					return
				else
					return
				end
			end
		end
	end
end

function slot0.isRayParent(slot0, slot1, slot2)
	if not slot0:getMapNodes()[slot2 % 100][math.floor(slot2 / 100)]:getNodeUnit() then
		return false
	end

	if not slot3[slot6.y][slot6.x]:getNodeRay() then
		return false
	end

	if slot7.rayParent == slot1 then
		return true
	end

	if not slot7.rayParent or slot7.rayParent <= 0 then
		return false
	end

	if not slot3[slot7.rayParent % 100][math.floor(slot7.rayParent / 100)]:getNodeRay() then
		return false
	end

	return slot0:isRayParent(slot10.rayParent, slot7.rayParent)
end

function slot0.hasBlockRayUnit(slot0, slot1, slot2, slot3, slot4)
	if slot1.x == slot2.x and slot1.y == slot2.y then
		return false
	end

	if slot2:getNodeUnit() then
		return false
	end

	slot6 = slot0:getMapNodes()

	if slot4 == WuErLiXiEnum.Dir.Up then
		if slot1.x ~= slot2.x then
			return false
		end

		if slot1.y <= slot2.y then
			return false
		end

		for slot10 = slot1.y, slot2.y + 1, -1 do
			if slot6[slot10][slot1.x]:getNodeUnit() and (slot11.unitType ~= WuErLiXiEnum.UnitType.Switch or slot3 ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif slot4 == WuErLiXiEnum.Dir.Down then
		if slot1.x ~= slot2.x then
			return false
		end

		if slot2.y <= slot1.y then
			return false
		end

		for slot10 = slot1.y, slot2.y - 1 do
			if slot6[slot10][slot1.x]:getNodeUnit() and (slot11.unitType ~= WuErLiXiEnum.UnitType.Switch or slot3 ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif slot4 == WuErLiXiEnum.Dir.Left then
		if slot1.y ~= slot2.y then
			return false
		end

		if slot1.x <= slot2.x then
			return false
		end

		for slot10 = slot1.x, slot2.x + 1, -1 do
			if slot6[slot1.y][slot10]:getNodeUnit() and (slot11.unitType ~= WuErLiXiEnum.UnitType.Switch or slot3 ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif slot4 == WuErLiXiEnum.Dir.Right then
		if slot1.y ~= slot2.y then
			return false
		end

		if slot2.x <= slot1.x then
			return false
		end

		for slot10 = slot1.x, slot2.x - 1 do
			if slot6[slot1.y][slot10]:getNodeUnit() and (slot11.unitType ~= WuErLiXiEnum.UnitType.Switch or slot3 ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	end

	return false
end

function slot0.setUnitActive(slot0, slot1, slot2, slot3, slot4)
	if not slot1:getNodeUnit() then
		return
	end

	if slot2 and slot1:getNodeRay() then
		return
	end

	slot7 = slot0:getMapNodes()

	slot1:setUnitActive(slot2, slot3, slot4)

	if slot5.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if slot5.dir == WuErLiXiEnum.Dir.Up or slot5.dir == WuErLiXiEnum.Dir.Down then
			if slot7[slot1.y][slot1.x - 1] then
				slot7[slot1.y][slot1.x - 1]:setUnitActive(slot1:isUnitActive())
			end

			if slot7[slot1.y][slot1.x + 1] then
				slot7[slot1.y][slot1.x + 1]:setUnitActive(slot1:isUnitActive())
			end
		else
			if slot7[slot1.y - 1] then
				slot7[slot1.y - 1][slot1.x]:setUnitActive(slot1:isUnitActive())
			end

			if slot7[slot1.y + 1] then
				slot7[slot1.y + 1][slot1.x]:setUnitActive(slot1:isUnitActive())
			end
		end
	end
end

function slot0.setSwitchActive(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0:getMapNodes()) do
		for slot12, slot13 in pairs(slot8) do
			if slot13:getNodeUnit() and slot14.id == slot1 and slot14.unitType == WuErLiXiEnum.UnitType.Switch then
				if slot14:isUnitActive() == slot2 then
					return
				end

				slot14:setUnitActive(slot2)

				if slot2 then
					if slot3[slot13.y + 1] and slot3[slot13.y + 1][slot13.x] and slot3[slot13.y + 1][slot13.x]:getNodeRay() and slot15.rayDir == WuErLiXiEnum.Dir.Up then
						slot0:fillNodeRay(slot3[math.floor(slot15.rayId % 100)][math.floor(slot15.rayId / 100)], slot15.rayType, slot15.rayDir, true, slot15.rayParent)
					end

					if slot3[slot13.y - 1] and slot3[slot13.y - 1][slot13.x] and slot3[slot13.y - 1][slot13.x]:getNodeRay() and slot15.rayDir == WuErLiXiEnum.Dir.Down then
						slot0:fillNodeRay(slot3[math.floor(slot15.rayId % 100)][math.floor(slot15.rayId / 100)], slot15.rayType, slot15.rayDir, true, slot15.rayParent)
					end

					if slot3[slot13.y][slot13.x + 1] and slot3[slot13.y][slot13.x + 1]:getNodeRay() and slot15.rayDir == WuErLiXiEnum.Dir.Left then
						slot0:fillNodeRay(slot3[math.floor(slot15.rayId % 100)][math.floor(slot15.rayId / 100)], slot15.rayType, slot15.rayDir, true, slot15.rayParent)
					end

					if slot3[slot13.y][slot13.x - 1] and slot3[slot13.y][slot13.x - 1]:getNodeRay() and slot15.rayDir == WuErLiXiEnum.Dir.Right then
						slot0:fillNodeRay(slot3[math.floor(slot15.rayId % 100)][math.floor(slot15.rayId / 100)], slot15.rayType, slot15.rayDir, true, slot15.rayParent)
					end
				elseif slot13:getNodeRay() then
					slot0:clearNodesRay(slot13, slot15.rayId, slot15.rayDir, false)
				end
			end
		end
	end
end

function slot0.clearNodesRay(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:getMapNodes()
	slot6 = slot0:getMapLineCount()
	slot7 = slot0:getMapRowCount()
	slot8 = slot1:getNodeRay()
	slot9 = slot4 and 1 or 0

	if slot3 == WuErLiXiEnum.Dir.Up then
		if slot1.y - slot9 >= 1 then
			for slot13 = slot1.y - slot9, 1, -1 do
				slot15 = slot5[slot13][slot1.x]:getNodeRay()

				if slot5[slot13][slot1.x]:getNodeUnit() then
					if slot14.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						slot5[slot13][slot1.x]:clearNodeRay(slot2)
						slot0:setUnitActive(slot5[slot13][slot1.x], false)

						return
					end

					if slot8 then
						if slot8.rayType == WuErLiXiEnum.RayType.SwitchSignal and (slot14.unitType == WuErLiXiEnum.UnitType.Switch or slot14.unitType == WuErLiXiEnum.UnitType.Key) then
							slot0:setUnitActive(slot5[slot13][slot1.x], false)
							slot0:setSwitchActive(slot14.id, false)
						end
					elseif slot14.unitType == WuErLiXiEnum.UnitType.Switch or slot14.unitType == WuErLiXiEnum.UnitType.Key then
						slot0:setUnitActive(slot5[slot13][slot1.x], false)
						slot0:setSwitchActive(slot14.id, false)
					end

					if slot15 and slot15.rayId == slot2 then
						for slot20, slot21 in pairs(slot14:getUnitSignals(slot3)) do
							slot0:clearNodesRay(slot5[slot13][slot21[1]], slot5[slot13][slot21[1]].id, slot14:getUnitSignalOutDir(), true)
						end
					end
				end

				slot5[slot13][slot1.x]:clearNodeRay(slot2)
			end
		end
	elseif slot3 == WuErLiXiEnum.Dir.Down then
		if slot6 >= slot1.y + slot9 then
			for slot13 = slot1.y + slot9, slot6 do
				slot15 = slot5[slot13][slot1.x]:getNodeRay()

				if slot5[slot13][slot1.x]:getNodeUnit() then
					if slot14.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						slot5[slot13][slot1.x]:clearNodeRay(slot2)
						slot0:setUnitActive(slot5[slot13][slot1.x], false)

						return
					end

					if slot8 then
						if slot8.rayType == WuErLiXiEnum.RayType.SwitchSignal and (slot14.unitType == WuErLiXiEnum.UnitType.Switch or slot14.unitType == WuErLiXiEnum.UnitType.Key) then
							slot0:setUnitActive(slot5[slot13][slot1.x], false)
							slot0:setSwitchActive(slot14.id, false)
						end
					elseif slot14.unitType == WuErLiXiEnum.UnitType.Switch or slot14.unitType == WuErLiXiEnum.UnitType.Key then
						slot0:setUnitActive(slot5[slot13][slot1.x], false)
						slot0:setSwitchActive(slot14.id, false)
					end

					if slot15 and slot15.rayId == slot2 then
						for slot20, slot21 in pairs(slot14:getUnitSignals(slot3)) do
							slot0:clearNodesRay(slot5[slot13][slot21[1]], slot5[slot13][slot21[1]].id, slot14:getUnitSignalOutDir(), true)
						end
					end
				end

				slot5[slot13][slot1.x]:clearNodeRay(slot2)
			end
		end
	elseif slot3 == WuErLiXiEnum.Dir.Left then
		if slot1.x - slot9 >= 1 then
			for slot13 = slot1.x - slot9, 1, -1 do
				slot15 = slot5[slot1.y][slot13]:getNodeRay()

				if slot5[slot1.y][slot13]:getNodeUnit() then
					if slot14.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						slot5[slot1.y][slot13]:clearNodeRay(slot2)
						slot0:setUnitActive(slot5[slot1.y][slot13], false)

						return
					end

					if slot8 then
						if slot8.rayType == WuErLiXiEnum.RayType.SwitchSignal and (slot14.unitType == WuErLiXiEnum.UnitType.Switch or slot14.unitType == WuErLiXiEnum.UnitType.Key) then
							slot0:setUnitActive(slot5[slot1.y][slot13], false)
							slot0:setSwitchActive(slot14.id, false)
						end
					elseif slot14.unitType == WuErLiXiEnum.UnitType.Switch or slot14.unitType == WuErLiXiEnum.UnitType.Key then
						slot0:setUnitActive(slot5[slot1.y][slot13], false)
						slot0:setSwitchActive(slot14.id, false)
					end

					if slot15 and slot15.rayId == slot2 then
						for slot20, slot21 in pairs(slot14:getUnitSignals(slot3)) do
							slot0:clearNodesRay(slot5[slot21[2]][slot13], slot5[slot21[2]][slot13].id, slot14:getUnitSignalOutDir(), true)
						end
					end
				end

				slot5[slot1.y][slot13]:clearNodeRay(slot2)
			end
		end
	elseif slot3 == WuErLiXiEnum.Dir.Right and slot7 >= slot1.x + slot9 then
		for slot13 = slot1.x + slot9, slot7 do
			slot15 = slot5[slot1.y][slot13]:getNodeRay()

			if slot5[slot1.y][slot13]:getNodeUnit() then
				if slot14.unitType == WuErLiXiEnum.UnitType.SignalEnd then
					slot5[slot1.y][slot13]:clearNodeRay(slot2)
					slot0:setUnitActive(slot5[slot1.y][slot13], false)

					return
				end

				if slot8 then
					if slot8.rayType == WuErLiXiEnum.RayType.SwitchSignal and (slot14.unitType == WuErLiXiEnum.UnitType.Switch or slot14.unitType == WuErLiXiEnum.UnitType.Key) then
						slot0:setUnitActive(slot5[slot1.y][slot13], false)
						slot0:setSwitchActive(slot14.id, false)
					end
				elseif slot14.unitType == WuErLiXiEnum.UnitType.Switch or slot14.unitType == WuErLiXiEnum.UnitType.Key then
					slot0:setUnitActive(slot5[slot1.y][slot13], false)
					slot0:setSwitchActive(slot14.id, false)
				end

				if slot15 and slot15.rayId == slot2 then
					for slot20, slot21 in pairs(slot14:getUnitSignals(slot3)) do
						slot0:clearNodesRay(slot5[slot21[2]][slot13], slot5[slot21[2]][slot13].id, slot14:getUnitSignalOutDir(), true)
					end
				end
			end

			slot5[slot1.y][slot13]:clearNodeRay(slot2)
		end
	end
end

function slot0.getMapRays(slot0, slot1)
	slot0._signalDict = {}
	slot2 = slot0:getMapNodes(slot1)
	slot3 = slot0:getMapLineCount(slot1)

	function slot5(slot0, slot1, slot2)
		if not slot0:getNodeUnit() then
			return
		end

		if not slot0:getUnitSignalOutDir() then
			return
		end

		if slot4 == WuErLiXiEnum.Dir.Up then
			for slot9, slot10 in pairs(slot3:getUnitSignals(slot2)) do
				if slot10[2] > 1 then
					for slot14 = slot10[2] - 1, 1, -1 do
						slot15 = uv0[slot10[2]][slot10[1]].id

						if uv0[slot14][slot10[1]]:getNodeUnit() then
							if #slot16:getUnitSignals(slot3:getUnitSignalOutDir()) > 0 then
								if uv1._signalDict[slot10[1] .. "_" .. slot14] then
									uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14 + 1][slot10[1]])

									break
								end

								uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14][slot10[1]])
								uv2(uv0[slot14][slot10[1]], slot1, slot4)

								break
							elseif slot16:isUnitActive(slot3:getUnitSignalOutDir()) then
								if not slot16:isIgnoreSignal() then
									uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14][slot10[1]])

									break
								end
							else
								uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14 + 1][slot10[1]])

								break
							end
						end

						if not uv0[slot14][slot10[1]]:getNodeRay() or slot17.rayId ~= slot15 or slot17.rayType ~= slot1 then
							uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14 + 1][slot10[1]])

							break
						end

						if slot14 == 1 then
							uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[1][slot10[1]])
						end
					end
				end
			end
		elseif slot3.outDir == WuErLiXiEnum.Dir.Down then
			for slot9, slot10 in pairs(slot3:getUnitSignals(slot2)) do
				if slot10[2] < uv3 then
					for slot14 = slot10[2] + 1, uv3 do
						slot15 = uv0[slot10[2]][slot10[1]].id

						if uv0[slot14][slot10[1]]:getNodeUnit() then
							if #slot16:getUnitSignals(slot3:getUnitSignalOutDir()) > 0 then
								if uv1._signalDict[slot10[1] .. "_" .. slot14] then
									uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14 - 1][slot10[1]])

									break
								end

								uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14][slot10[1]])
								uv2(uv0[slot14][slot10[1]], slot1, slot4)

								break
							elseif slot16:isUnitActive(slot3:getUnitSignalOutDir()) then
								if not slot16:isIgnoreSignal() then
									uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14][slot10[1]])

									break
								end
							else
								uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14 - 1][slot10[1]])

								break
							end
						end

						if not uv0[slot14][slot10[1]]:getNodeRay() or slot17.rayId ~= slot15 or slot17.rayType ~= slot1 then
							uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot14 - 1][slot10[1]])

							break
						end

						if slot14 == uv3 then
							uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[uv3][slot10[1]])
						end
					end
				end
			end
		elseif slot3.outDir == WuErLiXiEnum.Dir.Left then
			for slot9, slot10 in pairs(slot3:getUnitSignals(slot2)) do
				if slot10[1] > 1 then
					for slot14 = slot10[1] - 1, 1, -1 do
						slot15 = uv0[slot10[2]][slot10[1]].id

						if uv0[slot10[2]][slot14]:getNodeUnit() then
							if #slot16:getUnitSignals(slot3:getUnitSignalOutDir()) > 0 then
								if uv1._signalDict[slot14 .. "_" .. slot10[2]] then
									uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14 + 1])

									break
								end

								uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14])
								uv2(uv0[slot10[2]][slot14], slot1, slot4)

								break
							elseif slot16:isUnitActive(slot3:getUnitSignalOutDir()) then
								if not slot16:isIgnoreSignal() then
									uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14])

									break
								end
							else
								uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14 + 1])

								break
							end
						end

						if not uv0[slot10[2]][slot14]:getNodeRay() or slot17.rayId ~= slot15 or slot17.rayType ~= slot1 then
							uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14 + 1])

							break
						end

						if slot14 == 1 then
							uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][1])
						end
					end
				end
			end
		elseif slot3.outDir == WuErLiXiEnum.Dir.Right then
			for slot9, slot10 in pairs(slot3:getUnitSignals(slot2)) do
				if slot10[1] < uv4 then
					for slot14 = slot10[1] + 1, uv4 do
						slot15 = uv0[slot10[2]][slot10[1]].id

						if uv0[slot10[2]][slot14]:getNodeUnit() then
							if #slot16:getUnitSignals(slot3:getUnitSignalOutDir()) > 0 then
								if uv1._signalDict[slot14 .. "_" .. slot10[2]] then
									uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14 - 1])

									break
								end

								uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14])
								uv2(uv0[slot10[2]][slot14], slot1, slot4)

								break
							elseif slot16:isUnitActive(slot3:getUnitSignalOutDir()) then
								if not slot16:isIgnoreSignal() then
									uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14])

									break
								end
							else
								uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14 - 1])

								break
							end
						end

						if not uv0[slot10[2]][slot14]:getNodeRay() or slot17.rayId ~= slot15 or slot17.rayType ~= slot1 then
							uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][slot14 - 1])

							break
						end

						if slot14 == uv4 then
							uv1:_addRayDict(slot15, slot1, slot4, uv0[slot10[2]][slot10[1]], uv0[slot10[2]][uv4])
						end
					end
				end
			end
		end
	end

	for slot9 = 1, slot0:getMapRowCount(slot1) do
		for slot13 = 1, slot3 do
			if slot2[slot13][slot9]:getNodeUnit() then
				if slot14.unitType == WuErLiXiEnum.UnitType.SignalStart then
					slot5(slot2[slot13][slot9], WuErLiXiEnum.RayType.NormalSignal)
				elseif slot14.unitType == WuErLiXiEnum.UnitType.KeyStart then
					slot5(slot2[slot13][slot9], WuErLiXiEnum.RayType.SwitchSignal)
				end
			end
		end
	end

	return slot0._signalDict
end

function slot0._addRayDict(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot4.x .. "_" .. slot4.y

	if slot4.x == slot5.x and slot4.y == slot5.y then
		slot0._signalDict[slot6] = nil

		return
	end

	if not slot0._signalDict[slot6] then
		slot0._signalDict[slot6] = WuErLiXiMapSignalItemMo.New()

		slot0._signalDict[slot6]:init(slot1, slot2, slot3, slot4, slot5)
	else
		slot0._signalDict[slot6]:reset(slot1, slot2, slot3, slot5)
	end
end

function slot0.isKeyActiveSelf(slot0, slot1, slot2)
	slot3 = slot0:getMapNodes()

	if slot2:getNodeRay() then
		if slot0:hasInteractActive(slot1, slot2) then
			return true
		end

		if slot0:isHasIngnoreUnit(slot3[slot4.rayId % 100][math.floor(slot4.rayId / 100)], slot2, slot1) then
			return true
		elseif slot4.rayParent and slot4.rayParent > 0 then
			slot11 = slot3[slot7][slot6]:getNodeUnit()

			return slot0:isHasIngnoreUnit(slot3[slot4.rayParent % 100][math.floor(slot4.rayParent / 100)], slot3[slot11.y][slot11.x], slot1)
		end
	end

	return false
end

function slot0.hasInteractActive(slot0, slot1, slot2)
	if not slot2:getNodeRay() then
		return false
	end

	for slot11, slot12 in pairs(slot0:getIgnoreUnits(slot0:getMapNodes()[slot3.rayId % 100][math.floor(slot3.rayId / 100)], slot2)) do
		if not slot0:getKeyNodeByUnitId(slot12):getNodeRay() then
			return false
		end

		for slot21, slot22 in pairs(slot0:getIgnoreUnits(slot4[slot14.rayId % 100][math.floor(slot14.rayId / 100)], slot13)) do
			if slot22 == slot1 then
				return true
			end
		end
	end

	return false
end

function slot0.getKeyNodeByUnitId(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getMapNodes()) do
		for slot11, slot12 in pairs(slot7) do
			if slot12:getNodeUnit() and slot13.unitType == WuErLiXiEnum.UnitType.Key and slot13.id == slot1 then
				return slot12
			end
		end
	end
end

function slot0.isKeyActive(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getMapNodes()) do
		for slot11, slot12 in pairs(slot7) do
			if slot12:getNodeUnit() and slot13.unitType == WuErLiXiEnum.UnitType.Key and slot13.id == slot1 then
				return slot13.isActive
			end
		end
	end

	return false
end

function slot0.getIgnoreUnits(slot0, slot1, slot2)
	slot4 = slot0:getMapNodes()

	function (slot0, slot1)
		if slot0.x == slot1.x then
			if slot0.y < slot1.y then
				for slot5 = slot0.y + 1, slot1.y - 1 do
					if uv0[slot5][slot0.x]:getNodeUnit() then
						table.insert(uv1, slot6.id)
					end
				end

				slot2 = slot0:getNodeUnit()
				slot4 = uv0[slot2.y][slot2.x]:getNodeRay()

				if slot2 and slot4 and slot4.rayId and slot4.rayId > 0 then
					uv2(uv0[slot4.rayId % 100][math.floor(slot4.rayId / 100)], slot3)
				end
			elseif slot1.y < slot0.y then
				for slot5 = slot0.y - 1, slot1.y + 1, -1 do
					if uv0[slot5][slot0.x]:getNodeUnit() then
						table.insert(uv1, slot6.id)
					end
				end

				slot2 = slot0:getNodeUnit()
				slot4 = uv0[slot2.y][slot2.x]:getNodeRay()

				if slot2 and slot4 and slot4.rayId and slot4.rayId > 0 then
					uv2(uv0[slot4.rayId % 100][math.floor(slot4.rayId / 100)], slot3)
				end
			end
		elseif slot0.y == slot1.y then
			if slot0.x < slot1.x then
				for slot5 = slot0.x + 1, slot1.x - 1 do
					if uv0[slot0.y][slot5]:getNodeUnit() then
						table.insert(uv1, slot6.id)
					end
				end

				slot2 = slot0:getNodeUnit()
				slot4 = uv0[slot2.y][slot2.x]:getNodeRay()

				if slot2 and slot4 and slot4.rayId and slot4.rayId > 0 then
					uv2(uv0[slot4.rayId % 100][math.floor(slot4.rayId / 100)], slot3)
				end
			elseif slot1.x < slot0.x then
				for slot5 = slot0.x - 1, slot1.x + 1, -1 do
					if uv0[slot0.y][slot5]:getNodeUnit() then
						table.insert(uv1, slot6.id)
					end
				end

				slot2 = slot0:getNodeUnit()
				slot4 = uv0[slot2.y][slot2.x]:getNodeRay()

				if slot2 and slot4 and slot4.rayId and slot4.rayId > 0 then
					uv2(uv0[slot4.rayId % 100][math.floor(slot4.rayId / 100)], slot3)
				end
			end
		end
	end(slot1, slot2)

	return {}
end

function slot0.isHasIngnoreUnit(slot0, slot1, slot2, slot3)
	slot4 = slot0:getMapNodes()

	if slot1.x == slot2.x then
		if slot1.y < slot2.y then
			for slot8 = slot1.y, slot2.y - 1 do
				if slot4[slot8][slot1.x]:getNodeUnit() and slot9.id == slot3 then
					return true
				end
			end
		elseif slot2.y < slot1.y then
			for slot8 = slot1.y, slot2.y + 1, -1 do
				if slot4[slot8][slot1.x]:getNodeUnit() and slot9.id == slot3 then
					return true
				end
			end
		end
	elseif slot1.y == slot2.y then
		if slot1.x < slot2.x then
			for slot8 = slot1.x, slot2.x - 1 do
				if slot4[slot1.y][slot8]:getNodeUnit() and slot9.id == slot3 then
					return true
				end
			end
		elseif slot2.x < slot1.x then
			for slot8 = slot1.x, slot2.x + 1, -1 do
				if slot4[slot1.y][slot8]:getNodeUnit() and slot9.id == slot3 then
					return true
				end
			end
		end
	end

	return false
end

function slot0.isNodeHasUnit(slot0, slot1)
	if slot1:getNodeUnit() then
		return true
	end

	return false
end

function slot0.isNodeHasInitUnit(slot0, slot1)
	if slot1:getNodeUnit() then
		return slot1.initUnit > 0
	end

	return false
end

function slot0.isAllSignalEndActive(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getMapNodes(slot1 or slot0._curMapId)) do
		for slot11, slot12 in pairs(slot7) do
			if slot12:getNodeUnit() and slot13.unitType == WuErLiXiEnum.UnitType.SignalEnd and (not slot13.isActive or not slot12:getNodeRay()) then
				return false
			end
		end
	end

	return true
end

function slot0.getLimitSelectUnitCount(slot0, slot1)
	slot2 = slot1.count

	for slot7, slot8 in pairs(slot0:getMapNodes(slot0._curMapId)) do
		for slot12, slot13 in pairs(slot8) do
			if slot13.initUnit == 0 and slot13.unit and slot13.unit.id == slot1.id and slot13.x == slot13.unit.x and slot13.y == slot13.unit.y then
				slot2 = slot2 - 1
			end
		end
	end

	return slot2
end

function slot0.getKeyAndSwitchTagById(slot0, slot1)
	slot3 = {
		"A",
		"B",
		"C",
		"D",
		"E",
		"F",
		"G",
		"H",
		"I",
		"J",
		"K",
		"L",
		"M",
		"N",
		"O",
		"B",
		"Q",
		"R",
		"S",
		"T",
		"U",
		"V",
		"W",
		"X",
		"Y",
		"Z"
	}
	slot4 = {}

	for slot8, slot9 in pairs(slot0:getMap(slot0._curMapId).nodeDict) do
		for slot13, slot14 in pairs(slot9) do
			if slot14.unit and (slot14.unit.unitType == WuErLiXiEnum.UnitType.Key or slot14.unit.unitType == WuErLiXiEnum.UnitType.Switch) then
				slot4[slot14.unit.id] = slot14.unit.id
			end
		end
	end

	for slot8, slot9 in pairs(slot2.actUnitDict) do
		if slot9.type == WuErLiXiEnum.UnitType.Key or slot9.type == WuErLiXiEnum.UnitType.Switch then
			slot4[slot9.id] = slot9.id
		end
	end

	slot5 = {}

	for slot9, slot10 in pairs(slot4) do
		table.insert(slot5, slot10)
	end

	table.sort(slot5)

	slot6 = 0

	for slot10, slot11 in ipairs(slot5) do
		if slot11 == slot1 then
			slot6 = slot10
		end
	end

	return slot6 == 0 and "" or slot3[slot6]
end

function slot0.isUnitActive(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getMap(slot0._curMapId).nodeDict) do
		for slot11, slot12 in pairs(slot7) do
			if slot12.unit and slot12.unit.id == slot1 then
				return slot12.unit.isActive
			end
		end
	end

	return false
end

function slot0.isSetDirEnable(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:getMapNodes()
	slot6 = slot0:getMapLineCount()

	if slot1 == WuErLiXiEnum.UnitType.SignalMulti then
		if slot2 == WuErLiXiEnum.Dir.Up or slot2 == WuErLiXiEnum.Dir.Down then
			if slot3 <= 1 or slot0:getMapRowCount() <= slot3 then
				return false
			end

			return not slot5[slot4][slot3 - 1].unit and not slot5[slot4][slot3 - 1].unit
		else
			if slot4 <= 1 or slot6 <= slot4 then
				return false
			end

			return not slot5[slot4 - 1][slot3].unit and not slot5[slot4 + 1][slot3].unit
		end
	end

	return true
end

function slot0.setCurSelectUnit(slot0, slot1, slot2)
	slot0._curSelectNode = {
		slot1,
		slot2
	}
end

function slot0.getCurSelectUnit(slot0)
	return slot0._curSelectNode
end

function slot0.clearSelectUnit(slot0)
	slot0._curSelectNode = {}
end

function slot0.getUnlockElements(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(WuErLiXiConfig.instance:getElementList()) do
		if slot7.episodeId == 0 or WuErLiXiModel.instance:isEpisodeUnlock(slot7.episodeId) then
			table.insert(slot1, slot7)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.sequence < slot1.sequence
	end)

	return slot1
end

function slot0.hasElementNew(slot0)
	return #slot0:getUnlockElements() > #slot0._unlockElements
end

function slot0.setReadNewElement(slot0)
	slot0._unlockElements = {}
	slot2 = ""

	if #slot0:getUnlockElements() > 0 then
		slot2 = tostring(slot1[1].id)

		table.insert(slot0._unlockElements, slot1[1].id)

		if #slot1 > 1 then
			for slot6 = 1, #slot1 do
				slot2 = slot2 .. "#" .. slot1[slot6].id

				table.insert(slot0._unlockElements, slot1[slot6].id)
			end
		end
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.WuErLiXiUnlockUnits, slot2)
end

function slot0.setMapStartTime(slot0)
	slot0._mapStartTime = ServerTime.now()
end

function slot0.getMapStartTime(slot0)
	return slot0._mapStartTime
end

function slot0.clearOperations(slot0)
	slot0._operations = {}
end

function slot0.addOperation(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	for slot11, slot12 in ipairs(slot0._operations) do
		slot7 = slot12.secs + slot0:getMapStartTime()
	end

	table.insert(slot0._operations, {
		step = #slot0._operations + 1,
		secs = ServerTime.now() - slot7,
		id = slot1,
		type = slot2,
		from_x = tostring(slot3),
		from_y = tostring(slot4),
		to_x = tostring(slot5),
		to_y = tostring(slot6)
	})
end

function slot0.getStatOperationInfos(slot0)
	return slot0._operations
end

function slot0.getStatMapInfos(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(slot0:getMapNodes()) do
		for slot11, slot12 in pairs(slot7) do
			if slot12:getNodeUnit() then
				table.insert(slot2, {
					id = slot13.id,
					x = slot12.x,
					y = slot12.y,
					type = slot13.unitType,
					dir = slot13.dir
				})
			end
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
