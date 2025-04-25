module("modules.logic.room.utils.ManufactureHelper", package.seeall)

return {
	__EMPTY__TABLE = {},
	findItemIdListByBUid = function (slot0)
		if not ManufactureModel.instance:getManufactureMOById(slot0) then
			return uv0.__EMPTY__TABLE
		end

		slot2 = {}

		for slot7, slot8 in ipairs(slot1:getAllUnlockedSlotMOList()) do
			if (slot8:getSlotState() == RoomManufactureEnum.SlotState.Running or slot9 == RoomManufactureEnum.SlotState.Wait or slot9 == RoomManufactureEnum.SlotState.Stop or slot9 == RoomManufactureEnum.SlotState.Complete) and not tabletool.indexOf(slot2, ManufactureConfig.instance:getItemId(slot8:getSlotManufactureItemId())) then
				table.insert(slot2, slot11)
			end
		end

		return slot2
	end,
	findLuckyItemIdListByBUid = function (slot0)
		slot1, slot2 = uv0.findLuckyItemParamByBUid(slot0)

		if not slot1 and not slot2 then
			return uv0.__EMPTY__TABLE
		end

		slot3 = uv0.findItemIdListByBUid(slot0)

		if slot1 then
			return slot3
		end

		for slot7 = #slot3, 1, -1 do
			if not slot2 or not slot2[slot3[slot7]] then
				table.remove(slot3, 1)
			end
		end

		return slot3
	end,
	findLuckyItemParamByBUid = function (slot0)
		slot4 = CritterHelper.getWorkCritterMOListByBuid(slot0)

		if not RoomMapBuildingModel.instance:getBuildingMOById(slot0) or not slot4 or #slot4 < 1 then
			return false, nil
		end

		slot6 = CritterConfig.instance

		for slot11 = 1, #slot4 do
			if ManufactureCritterListModel.instance:getPreviewAttrInfo(slot4[slot11]:getId(), slot3.buildingId, false) and slot13.skillTags and #slot13.skillTags > 0 then
				for slot18 = 1, #slot13.skillTags do
					if slot6:getCritterTagCfg(slot14[slot18]) and slot19.luckyItemType == RoomManufactureEnum.LuckyItemType.All then
						return true, slot2
					elseif slot19 and slot19.luckyItemType == RoomManufactureEnum.LuckyItemType.ItemId and not string.nilorempty(slot19.luckyItemIds) and string.splitToNumber(slot19.luckyItemIds) then
						for slot24, slot25 in ipairs(slot20) do
							(slot2 or {})[slot25] = true
						end
					end
				end
			end
		end

		return slot1, slot2
	end
}
