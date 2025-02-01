module("modules.logic.room.model.record.RoomTradeTaskModel", package.seeall)

slot0 = class("RoomTradeTaskModel", BaseModel)

function slot0.onGetTradeTaskInfo(slot0, slot1)
	slot0:onRefeshTaskMo(slot1.infos)

	slot0.hasGetSupportBonus = slot1.hasGetSupportBonus or {}
	slot0.canGetExtraBonus = slot1.canGetExtraBonus

	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeTaskInfo)
end

function slot0.onRefeshTaskMo(slot0, slot1)
	if not slot0._taskMos then
		slot0._taskMos = {}
	end

	for slot5 = 1, #slot1 do
		if RoomTradeConfig.instance:getTaskCoById(slot1[slot5].id) then
			if not slot0._taskMos[slot8.tradeLevel] then
				slot0._taskMos[slot9] = {}
			end

			if not slot10[slot7] then
				slot10[slot7] = RoomTradeTaskMo.New()
			end

			slot10[slot7]:initMo(slot6, slot8)
		end
	end
end

function slot0.onReadNewTradeTask(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:getTaskMo(slot6):setNew(false)
	end

	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnReadNewTradeTaskReply)
end

function slot0.getTaskMaxLevel(slot0)
	return RoomTradeConfig.instance:getTaskMaxLevel()
end

function slot0.getLevelTaskMo(slot0, slot1)
	slot2 = {}

	if slot0._taskMos then
		if slot1 then
			if slot0._taskMos[slot1] then
				for slot6, slot7 in pairs(slot0._taskMos[slot1]) do
					if slot7:isNormalTask() then
						table.insert(slot2, slot7)
					end
				end
			end
		else
			for slot6, slot7 in pairs(slot0._taskMos) do
				if slot7 then
					for slot11, slot12 in pairs(slot7) do
						if slot12:isNormalTask() then
							table.insert(slot2, slot12)
						end
					end
				end
			end
		end
	end

	return slot2
end

function slot0.getTaskMo(slot0, slot1)
	for slot5, slot6 in pairs(slot0._taskMos) do
		for slot10, slot11 in pairs(slot6) do
			if slot11.id == slot1 then
				return slot11
			end
		end
	end
end

function slot0.getFinishLevelTaskCount(slot0, slot1)
	if not slot0:getLevelTaskMo(slot1) then
		return 0
	end

	for slot7, slot8 in pairs(slot2) do
		if slot8.hasFinish then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0.getTaskReward(slot0)
	return slot0.hasGetSupportBonus
end

function slot0.getOpenSupportLevel(slot0)
	return ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.LevelBonus)
end

function slot0.getOpenOrderLevel(slot0)
	return ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.Order)
end

function slot0.getOpenCritterIncubateLevel(slot0)
	return ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.CritterIncubate)
end

function slot0.getOpenBuildingLevelUpLevel(slot0)
	return ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.BuildingLevelUp)
end

function slot0.onGetLevelBonus(slot0, slot1)
	if not LuaUtil.tableContains(slot0.hasGetSupportBonus, slot1) then
		table.insert(slot0.hasGetSupportBonus, slot1)
	end
end

function slot0.isCanLevelBonus(slot0, slot1)
	return RoomTradeConfig.instance:getSupportBonusById(slot1).needTask <= slot0:getTaskFinishPointCount(), LuaUtil.tableContains(slot0.hasGetSupportBonus, slot1)
end

function slot0.getAllTaskRewards(slot0)
	slot2 = {}

	if RoomTradeConfig.instance:getSupportBonusConfig() then
		for slot6, slot7 in ipairs(slot1) do
			slot2[slot7.id] = GameUtil.splitString2(slot7.bonus, true, "|", "#")
		end
	end

	return slot2
end

function slot0.getTaskPointMaxCount(slot0)
	slot2 = 0
	slot3 = 0

	if RoomTradeConfig.instance:getSupportBonusConfig() then
		for slot7, slot8 in ipairs(slot1) do
			slot2 = math.max(slot2, slot8.needTask)
			slot3 = slot3 + 1
		end
	end

	return slot2, slot3
end

function slot0.getTaskFinishPointCount(slot0, slot1)
	return #RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(slot1, true)
end

function slot0.isCanLevelUp(slot0)
	if RoomTradeConfig.instance:getMaxLevel() <= ManufactureModel.instance:getTradeLevel() then
		return false, slot2, true
	end

	slot3, slot4 = slot0:getLevelTaskCount(slot2)

	return slot4 <= slot3, slot2, false
end

function slot0.getLevelTaskCount(slot0, slot1)
	return slot0:getFinishLevelTaskCount(slot1), RoomTradeConfig.instance:getLevelCo(slot1 + 1) and slot3.levelUpNeedTask or 0
end

function slot0.getLevelUnlock(slot0, slot1)
	if slot1 < 2 then
		return {}
	end

	if ManufactureConfig.instance:getAllLevelUnlockInfo(slot1) then
		if slot3[RoomTradeEnum.LevelUnlock.NewBuilding] then
			for slot8, slot9 in ipairs(slot4) do
				table.insert(slot2, {
					type = RoomTradeEnum.LevelUnlock.NewBuilding,
					buildingId = slot9
				})
			end
		end

		if slot3[RoomTradeEnum.LevelUnlock.BuildingMaxLevel] then
			for slot9, slot10 in ipairs(slot5) do
				for slot16, slot17 in ipairs(ManufactureConfig.instance:getBuildingIdsByGroup(slot10.groupId)) do
					table.insert(slot2, {
						type = RoomTradeEnum.LevelUnlock.BuildingMaxLevel,
						buildingId = slot17,
						num = {
							last = slot10.Level - 1,
							cur = slot10.Level
						}
					})
				end
			end
		end
	end

	slot5 = RoomTradeConfig.instance:getLevelCo(slot1 - 1)

	if RoomTradeConfig.instance:getLevelCo(slot1) then
		if not string.nilorempty(slot4.bonus) then
			for slot10, slot11 in ipairs(string.split(slot4.bonus, "|")) do
				table.insert(slot2, {
					type = RoomTradeEnum.LevelUnlock.GetBouns,
					bouns = slot11
				})
			end
		end

		if slot5 then
			if slot5.maxTrainSlotCount < slot4.maxTrainSlotCount then
				table.insert(slot2, {
					type = RoomTradeEnum.LevelUnlock.TrainSlotCount,
					num = {
						last = slot5.maxTrainSlotCount,
						cur = slot4.maxTrainSlotCount
					}
				})
			end

			if slot5.addBlockMax < slot4.addBlockMax then
				table.insert(slot2, {
					type = RoomTradeEnum.LevelUnlock.BlockMax,
					num = {
						last = slot5.addBlockMax,
						cur = slot4.addBlockMax
					}
				})
			end

			if slot5.trainsRoundCount < slot4.trainsRoundCount then
				table.insert(slot2, {
					type = RoomTradeEnum.LevelUnlock.TrainsRoundCount
				})
			end

			slot7 = nil

			for slot11, slot12 in ipairs(ManufactureConfig.instance:getTrainsBuildingCos()) do
				slot7 = (not slot7 or math.min(slot7, slot12.placeTradeLevel)) and slot12.placeTradeLevel
			end

			if slot1 == slot7 then
				table.insert(slot2, {
					type = RoomTradeEnum.LevelUnlock.TransportSystemOpen
				})
			end
		end
	end

	if slot1 == slot0:getOpenSupportLevel() then
		table.insert(slot2, {
			type = RoomTradeEnum.LevelUnlock.LevelBonus
		})
	end

	if slot1 == slot0:getOpenOrderLevel() then
		table.insert(slot2, {
			type = RoomTradeEnum.LevelUnlock.Order
		})
	end

	if slot1 == slot0:getOpenCritterIncubateLevel() then
		table.insert(slot2, {
			type = RoomTradeEnum.LevelUnlock.CritterIncubate
		})
	end

	if slot1 == slot0:getOpenBuildingLevelUpLevel() then
		table.insert(slot2, {
			type = RoomTradeEnum.LevelUnlock.BuildingLevelUp
		})
	end

	table.sort(slot2, slot0.sortLevelUnlock)

	return slot2
end

function slot0.sortLevelUnlock(slot0, slot1)
	if slot0.type == slot1.type then
		return
	end

	slot3 = RoomTradeConfig.instance:getLevelUnlockCo(slot1.type)

	if RoomTradeConfig.instance:getLevelUnlockCo(slot0.type) and slot3 then
		return slot2.sort < slot3.sort
	end

	return slot0.type < slot1.type
end

function slot0.getBuildingTaskIcon(slot0, slot1)
	return ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Building, slot1) and ResUrl.getRoomCritterIcon(slot2.icon)
end

function slot0.getCanGetExtraBonus(slot0)
	return slot0.canGetExtraBonus
end

function slot0.setCanGetExtraBonus(slot0)
	slot0.canGetExtraBonus = false
end

slot0.instance = slot0.New()

return slot0
