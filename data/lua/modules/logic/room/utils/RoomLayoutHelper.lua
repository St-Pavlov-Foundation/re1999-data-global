module("modules.logic.room.utils.RoomLayoutHelper", package.seeall)

return {
	tipLayoutAnchor = function (slot0, slot1, slot2, slot3, slot4)
		slot5 = recthelper.rectToRelativeAnchorPos(slot2, slot1)
		slot6 = slot5.x
		slot7 = slot5.y
		slot10 = recthelper.getWidth(slot1) * 0.5
		slot11 = recthelper.getHeight(slot1) * 0.5
		slot14 = recthelper.getWidth(slot0) * 0.5
		slot15 = recthelper.getHeight(slot0) * 0.5
		slot16 = 0

		if slot4 and slot4 > 0 and slot15 < slot11 then
			if (slot7 > 0 and slot7 + slot4 - slot15 or slot7 + slot15 - slot4) >= slot11 - slot15 then
				slot16 = slot17
			elseif slot16 <= -slot17 then
				slot16 = -slot17
			end
		end

		if slot10 >= slot6 + slot12 + slot3 then
			transformhelper.setLocalPos(slot0, slot6 + slot3 + slot14, slot16, 0)
		else
			transformhelper.setLocalPos(slot0, slot6 - slot3 - slot14, slot16, 0)
		end
	end,
	findBlockInfos = function (slot0, slot1)
		if not slot0 then
			return {}, {}
		end

		slot4 = RoomConfig.instance

		for slot9, slot10 in ipairs(slot0) do
			if not slot4:getInitBlock(slot10.blockId) and slot4:getBlock(slot10.blockId) then
				if slot1 == true and RoomBlockPackageEnum.ID.RoleBirthday == slot11.packageId then
					table.insert(slot3, slot10.blockId)
				elseif not slot2[slot12] then
					slot2[slot12] = 1
				else
					slot2[slot12] = slot2[slot12] + 1
				end
			end
		end

		return slot2, slot3
	end,
	findbuildingInfos = function (slot0)
		if not slot0 then
			return {}
		end

		for slot5, slot6 in ipairs(slot0) do
			if not slot1[slot6.defineId] then
				slot1[slot7] = 1
			else
				slot1[slot7] = slot1[slot7] + 1
			end
		end

		return slot1
	end,
	createInfoByObInfo = function (slot0)
		slot1 = {
			infos = {},
			buildingInfos = {}
		}

		tabletool.addValues(slot1.infos, slot0.infos)
		tabletool.addValues(slot1.buildingInfos, slot0.buildingInfos)

		slot1.buildingDegree, slot1.blockCount = uv0.sunDegreeInfos(slot1.infos, slot1.buildingInfos)

		return slot1
	end,
	sunDegreeInfos = function (slot0, slot1)
		slot2 = RoomBlockEnum.InitBlockDegreeValue
		slot3 = 0
		slot4 = RoomConfig.instance

		if slot0 then
			for slot8, slot9 in ipairs(slot0) do
				if not slot4:getInitBlock(slot9.blockId) then
					slot3 = slot3 + 1

					if slot4:getPackageConfigByBlockId(slot9.blockId) then
						slot2 = slot2 + slot10.blockBuildDegree
					end
				end
			end
		end

		if slot1 then
			for slot8, slot9 in ipairs(slot1) do
				if slot4:getBuildingConfig(slot9.defineId) then
					slot2 = slot2 + slot10.buildDegree
				end
			end
		end

		return slot2, slot3
	end,
	comparePlanInfo = function (slot0, slot1)
		slot2 = 0
		slot3 = 0
		slot4 = 0
		slot5, slot6 = uv0.findBlockInfos(slot0.infos)
		slot7 = uv0.findbuildingInfos(slot0.buildingInfos)
		slot8 = nil

		if slot1 ~= false then
			slot8 = {}
		end

		for slot13, slot14 in pairs(slot5) do
			slot2 = slot2 + uv0._checkNeedNum(MaterialEnum.MaterialType.BlockPackage, slot13, 1, slot8)
		end

		for slot13, slot14 in ipairs(slot6) do
			slot3 = slot3 + slot9(MaterialEnum.MaterialType.SpecialBlock, slot14, 1, slot8)
		end

		for slot13, slot14 in pairs(slot7) do
			slot4 = slot4 + slot9(MaterialEnum.MaterialType.Building, slot13, slot14, slot8)
		end

		return slot2, slot3, slot4, slot8
	end,
	_checkNeedNum = function (slot0, slot1, slot2, slot3)
		if slot2 < 1 then
			return 0
		end

		if math.max(ItemModel.instance:getItemQuantity(slot0, slot1) or 0, 0) < slot2 then
			if slot3 then
				if slot4:getItemConfig(slot0, slot1) then
					table.insert(slot3, slot6.name)
				else
					table.insert(slot3, slot0 .. ":" .. slot1)
				end
			end

			return slot2 - slot5
		end

		return 0
	end,
	connStrList = function (slot0, slot1, slot2, slot3)
		slot4 = nil
		slot3 = slot3 or #slot0

		for slot9, slot10 in ipairs(slot0) do
			if slot9 == 1 then
				slot4 = slot10
			elseif slot9 == slot5 and slot9 > 1 then
				slot4 = slot4 .. slot2 .. slot10
			elseif slot3 < slot9 then
				slot4 = slot4 .. "..."

				break
			else
				slot4 = slot4 .. slot1 .. slot10
			end
		end

		return slot4
	end,
	checkVisitParamCoppare = function (slot0)
		if slot0 and slot0.isCompareInfo == true then
			return true
		end

		return false
	end,
	findHasBlockBuildingInfos = function (slot0, slot1)
		slot2, slot3 = uv0.findHasBlockInfos(slot0)

		return slot2, uv0.findHasBuildingInfos(slot1, slot3)
	end,
	findHasBlockInfos = function (slot0)
		if not slot0 then
			return {}, {}
		end

		for slot6, slot7 in ipairs(slot0) do
			if uv0.isHasBlockById(slot7.blockId) then
				table.insert(slot1, slot7)
			else
				table.insert(slot2, slot7)
			end
		end

		return slot1, slot2
	end,
	findHasBuildingInfos = function (slot0, slot1)
		if not slot0 then
			return {}, {}
		end

		slot4 = {}

		for slot8, slot9 in ipairs(slot0) do
			if (slot4[slot9.defineId] or 0) < RoomModel.instance:getBuildingCount(slot10) and not uv0._isInRemoveBlock(slot9, slot1) then
				slot4[slot10] = slot11 + 1

				table.insert(slot2, slot9)
			else
				table.insert(slot3, slot9)
			end
		end

		return slot2, slot3
	end,
	_isInRemoveBlock = function (slot0, slot1)
		if not slot1 or #slot1 < 1 then
			return false
		end

		slot7 = slot0.rotate
		slot8 = slot0.uid
		slot3 = RoomBuildingHelper.getOccupyDict(slot0.defineId, HexPoint(slot0.x, slot0.y), slot7, slot8)

		for slot7, slot8 in ipairs(slot1) do
			if slot3[slot8.x] and slot3[slot8.x][slot8.y] then
				return true
			end
		end

		return false
	end,
	isHasBlockById = function (slot0)
		if RoomConfig.instance:getInitBlock(slot0) then
			return true
		end

		if slot1:getBlock(slot0) then
			slot3 = 1

			if ((RoomBlockPackageEnum.ID.RoleBirthday ~= slot2.packageId or uv0._checkNeedNum(MaterialEnum.MaterialType.SpecialBlock, slot0, 1)) and uv0._checkNeedNum(MaterialEnum.MaterialType.BlockPackage, slot2.packageId, 1)) == 0 then
				return true
			end
		end

		return false
	end
}
