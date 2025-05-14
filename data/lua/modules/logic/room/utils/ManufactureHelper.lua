module("modules.logic.room.utils.ManufactureHelper", package.seeall)

local var_0_0 = {
	__EMPTY__TABLE = {}
}

function var_0_0.findItemIdListByBUid(arg_1_0)
	local var_1_0 = ManufactureModel.instance:getManufactureMOById(arg_1_0)

	if not var_1_0 then
		return var_0_0.__EMPTY__TABLE
	end

	local var_1_1 = {}
	local var_1_2 = var_1_0:getAllUnlockedSlotMOList()

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		local var_1_3 = iter_1_1:getSlotState()

		if var_1_3 == RoomManufactureEnum.SlotState.Running or var_1_3 == RoomManufactureEnum.SlotState.Wait or var_1_3 == RoomManufactureEnum.SlotState.Stop or var_1_3 == RoomManufactureEnum.SlotState.Complete then
			local var_1_4 = iter_1_1:getSlotManufactureItemId()
			local var_1_5 = ManufactureConfig.instance:getItemId(var_1_4)

			if not tabletool.indexOf(var_1_1, var_1_5) then
				table.insert(var_1_1, var_1_5)
			end
		end
	end

	return var_1_1
end

function var_0_0.findLuckyItemIdListByBUid(arg_2_0)
	local var_2_0, var_2_1 = var_0_0.findLuckyItemParamByBUid(arg_2_0)

	if not var_2_0 and not var_2_1 then
		return var_0_0.__EMPTY__TABLE
	end

	local var_2_2 = var_0_0.findItemIdListByBUid(arg_2_0)

	if var_2_0 then
		return var_2_2
	end

	for iter_2_0 = #var_2_2, 1, -1 do
		local var_2_3 = var_2_2[iter_2_0]

		if not var_2_1 or not var_2_1[var_2_3] then
			table.remove(var_2_2, 1)
		end
	end

	return var_2_2
end

function var_0_0.findLuckyItemParamByBUid(arg_3_0)
	local var_3_0 = false
	local var_3_1
	local var_3_2 = RoomMapBuildingModel.instance:getBuildingMOById(arg_3_0)
	local var_3_3 = CritterHelper.getWorkCritterMOListByBuid(arg_3_0)

	if not var_3_2 or not var_3_3 or #var_3_3 < 1 then
		return var_3_0, var_3_1
	end

	local var_3_4 = var_3_2.buildingId
	local var_3_5 = CritterConfig.instance
	local var_3_6 = ManufactureCritterListModel.instance

	for iter_3_0 = 1, #var_3_3 do
		local var_3_7 = var_3_3[iter_3_0]
		local var_3_8 = var_3_6:getPreviewAttrInfo(var_3_7:getId(), var_3_4, false)

		if var_3_8 and var_3_8.skillTags and #var_3_8.skillTags > 0 then
			local var_3_9 = var_3_8.skillTags

			for iter_3_1 = 1, #var_3_9 do
				local var_3_10 = var_3_5:getCritterTagCfg(var_3_9[iter_3_1])

				if var_3_10 and var_3_10.luckyItemType == RoomManufactureEnum.LuckyItemType.All then
					var_3_0 = true

					return var_3_0, var_3_1
				elseif var_3_10 and var_3_10.luckyItemType == RoomManufactureEnum.LuckyItemType.ItemId and not string.nilorempty(var_3_10.luckyItemIds) then
					local var_3_11 = string.splitToNumber(var_3_10.luckyItemIds)

					if var_3_11 then
						for iter_3_2, iter_3_3 in ipairs(var_3_11) do
							var_3_1 = var_3_1 or {}
							var_3_1[iter_3_3] = true
						end
					end
				end
			end
		end
	end

	return var_3_0, var_3_1
end

return var_0_0
