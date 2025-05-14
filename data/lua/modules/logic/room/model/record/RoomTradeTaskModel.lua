module("modules.logic.room.model.record.RoomTradeTaskModel", package.seeall)

local var_0_0 = class("RoomTradeTaskModel", BaseModel)

function var_0_0.onGetTradeTaskInfo(arg_1_0, arg_1_1)
	arg_1_0:onRefeshTaskMo(arg_1_1.infos)

	arg_1_0.hasGetSupportBonus = arg_1_1.hasGetSupportBonus or {}
	arg_1_0.canGetExtraBonus = arg_1_1.canGetExtraBonus

	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeTaskInfo)
end

function var_0_0.onRefeshTaskMo(arg_2_0, arg_2_1)
	if not arg_2_0._taskMos then
		arg_2_0._taskMos = {}
	end

	for iter_2_0 = 1, #arg_2_1 do
		local var_2_0 = arg_2_1[iter_2_0]
		local var_2_1 = var_2_0.id
		local var_2_2 = RoomTradeConfig.instance:getTaskCoById(var_2_1)

		if var_2_2 then
			local var_2_3 = var_2_2.tradeLevel
			local var_2_4 = arg_2_0._taskMos[var_2_3]

			if not var_2_4 then
				var_2_4 = {}
				arg_2_0._taskMos[var_2_3] = var_2_4
			end

			if not var_2_4[var_2_1] then
				var_2_4[var_2_1] = RoomTradeTaskMo.New()
			end

			var_2_4[var_2_1]:initMo(var_2_0, var_2_2)
		end
	end
end

function var_0_0.onReadNewTradeTask(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0:getTaskMo(iter_3_1):setNew(false)
	end

	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnReadNewTradeTaskReply)
end

function var_0_0.getTaskMaxLevel(arg_4_0)
	return RoomTradeConfig.instance:getTaskMaxLevel()
end

function var_0_0.getLevelTaskMo(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_0._taskMos then
		if arg_5_1 then
			if arg_5_0._taskMos[arg_5_1] then
				for iter_5_0, iter_5_1 in pairs(arg_5_0._taskMos[arg_5_1]) do
					if iter_5_1:isNormalTask() then
						table.insert(var_5_0, iter_5_1)
					end
				end
			end
		else
			for iter_5_2, iter_5_3 in pairs(arg_5_0._taskMos) do
				if iter_5_3 then
					for iter_5_4, iter_5_5 in pairs(iter_5_3) do
						if iter_5_5:isNormalTask() then
							table.insert(var_5_0, iter_5_5)
						end
					end
				end
			end
		end
	end

	return var_5_0
end

function var_0_0.getTaskMo(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._taskMos) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if iter_6_3.id == arg_6_1 then
				return iter_6_3
			end
		end
	end
end

function var_0_0.getFinishLevelTaskCount(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getLevelTaskMo(arg_7_1)

	if not var_7_0 then
		return 0
	end

	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1.hasFinish then
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_1
end

function var_0_0.getTaskReward(arg_8_0)
	return arg_8_0.hasGetSupportBonus
end

function var_0_0.getOpenSupportLevel(arg_9_0)
	return (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.LevelBonus))
end

function var_0_0.getOpenOrderLevel(arg_10_0)
	return (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.Order))
end

function var_0_0.getOpenCritterIncubateLevel(arg_11_0)
	return (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.CritterIncubate))
end

function var_0_0.getOpenBuildingLevelUpLevel(arg_12_0)
	return (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.BuildingLevelUp))
end

function var_0_0.onGetLevelBonus(arg_13_0, arg_13_1)
	if not LuaUtil.tableContains(arg_13_0.hasGetSupportBonus, arg_13_1) then
		table.insert(arg_13_0.hasGetSupportBonus, arg_13_1)
	end
end

function var_0_0.isCanLevelBonus(arg_14_0, arg_14_1)
	local var_14_0 = LuaUtil.tableContains(arg_14_0.hasGetSupportBonus, arg_14_1)

	return arg_14_0:getTaskFinishPointCount() >= RoomTradeConfig.instance:getSupportBonusById(arg_14_1).needTask, var_14_0
end

function var_0_0.getAllTaskRewards(arg_15_0)
	local var_15_0 = RoomTradeConfig.instance:getSupportBonusConfig()
	local var_15_1 = {}

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_2 = iter_15_1.bonus
			local var_15_3 = GameUtil.splitString2(var_15_2, true, "|", "#")

			var_15_1[iter_15_1.id] = var_15_3
		end
	end

	return var_15_1
end

function var_0_0.getTaskPointMaxCount(arg_16_0)
	local var_16_0 = RoomTradeConfig.instance:getSupportBonusConfig()
	local var_16_1 = 0
	local var_16_2 = 0

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			var_16_1 = math.max(var_16_1, iter_16_1.needTask)
			var_16_2 = var_16_2 + 1
		end
	end

	return var_16_1, var_16_2
end

function var_0_0.getTaskFinishPointCount(arg_17_0, arg_17_1)
	return #RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(arg_17_1, true)
end

function var_0_0.isCanLevelUp(arg_18_0)
	local var_18_0 = RoomTradeConfig.instance:getMaxLevel()
	local var_18_1 = ManufactureModel.instance:getTradeLevel()

	if var_18_0 <= var_18_1 then
		return false, var_18_1, true
	end

	local var_18_2, var_18_3 = arg_18_0:getLevelTaskCount(var_18_1)

	return var_18_3 <= var_18_2, var_18_1, false
end

function var_0_0.getLevelTaskCount(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getFinishLevelTaskCount(arg_19_1)
	local var_19_1 = RoomTradeConfig.instance:getLevelCo(arg_19_1 + 1)
	local var_19_2 = var_19_1 and var_19_1.levelUpNeedTask or 0

	return var_19_0, var_19_2
end

function var_0_0.getLevelUnlock(arg_20_0, arg_20_1)
	local var_20_0 = {}

	if arg_20_1 < 2 then
		return var_20_0
	end

	local var_20_1 = ManufactureConfig.instance:getAllLevelUnlockInfo(arg_20_1)

	if var_20_1 then
		local var_20_2 = var_20_1[RoomTradeEnum.LevelUnlock.NewBuilding]

		if var_20_2 then
			for iter_20_0, iter_20_1 in ipairs(var_20_2) do
				local var_20_3 = {
					type = RoomTradeEnum.LevelUnlock.NewBuilding,
					buildingId = iter_20_1
				}

				table.insert(var_20_0, var_20_3)
			end
		end

		local var_20_4 = var_20_1[RoomTradeEnum.LevelUnlock.BuildingMaxLevel]

		if var_20_4 then
			for iter_20_2, iter_20_3 in ipairs(var_20_4) do
				local var_20_5 = iter_20_3.groupId
				local var_20_6 = ManufactureConfig.instance:getBuildingIdsByGroup(var_20_5)

				for iter_20_4, iter_20_5 in ipairs(var_20_6) do
					local var_20_7 = {
						type = RoomTradeEnum.LevelUnlock.BuildingMaxLevel,
						buildingId = iter_20_5,
						num = {
							last = iter_20_3.Level - 1,
							cur = iter_20_3.Level
						}
					}

					table.insert(var_20_0, var_20_7)
				end
			end
		end
	end

	local var_20_8 = RoomTradeConfig.instance:getLevelCo(arg_20_1)
	local var_20_9 = RoomTradeConfig.instance:getLevelCo(arg_20_1 - 1)

	if var_20_8 then
		if not string.nilorempty(var_20_8.bonus) then
			local var_20_10 = string.split(var_20_8.bonus, "|")

			for iter_20_6, iter_20_7 in ipairs(var_20_10) do
				local var_20_11 = {
					type = RoomTradeEnum.LevelUnlock.GetBouns,
					bouns = iter_20_7
				}

				table.insert(var_20_0, var_20_11)
			end
		end

		if var_20_9 then
			if var_20_8.maxTrainSlotCount > var_20_9.maxTrainSlotCount then
				local var_20_12 = {
					type = RoomTradeEnum.LevelUnlock.TrainSlotCount,
					num = {
						last = var_20_9.maxTrainSlotCount,
						cur = var_20_8.maxTrainSlotCount
					}
				}

				table.insert(var_20_0, var_20_12)
			end

			if var_20_8.addBlockMax > var_20_9.addBlockMax then
				local var_20_13 = {
					type = RoomTradeEnum.LevelUnlock.BlockMax,
					num = {
						last = var_20_9.addBlockMax,
						cur = var_20_8.addBlockMax
					}
				}

				table.insert(var_20_0, var_20_13)
			end

			if var_20_8.trainsRoundCount > var_20_9.trainsRoundCount then
				local var_20_14 = {
					type = RoomTradeEnum.LevelUnlock.TrainsRoundCount
				}

				table.insert(var_20_0, var_20_14)
			end

			local var_20_15 = ManufactureConfig.instance:getTrainsBuildingCos()
			local var_20_16

			for iter_20_8, iter_20_9 in ipairs(var_20_15) do
				if var_20_16 then
					var_20_16 = math.min(var_20_16, iter_20_9.placeTradeLevel)
				else
					var_20_16 = iter_20_9.placeTradeLevel
				end
			end

			if arg_20_1 == var_20_16 then
				local var_20_17 = {
					type = RoomTradeEnum.LevelUnlock.TransportSystemOpen
				}

				table.insert(var_20_0, var_20_17)
			end
		end
	end

	if arg_20_1 == arg_20_0:getOpenSupportLevel() then
		local var_20_18 = {
			type = RoomTradeEnum.LevelUnlock.LevelBonus
		}

		table.insert(var_20_0, var_20_18)
	end

	if arg_20_1 == arg_20_0:getOpenOrderLevel() then
		local var_20_19 = {
			type = RoomTradeEnum.LevelUnlock.Order
		}

		table.insert(var_20_0, var_20_19)
	end

	if arg_20_1 == arg_20_0:getOpenCritterIncubateLevel() then
		local var_20_20 = {
			type = RoomTradeEnum.LevelUnlock.CritterIncubate
		}

		table.insert(var_20_0, var_20_20)
	end

	if arg_20_1 == arg_20_0:getOpenBuildingLevelUpLevel() then
		local var_20_21 = {
			type = RoomTradeEnum.LevelUnlock.BuildingLevelUp
		}

		table.insert(var_20_0, var_20_21)
	end

	table.sort(var_20_0, arg_20_0.sortLevelUnlock)

	return var_20_0
end

function var_0_0.sortLevelUnlock(arg_21_0, arg_21_1)
	if arg_21_0.type == arg_21_1.type then
		return
	end

	local var_21_0 = RoomTradeConfig.instance:getLevelUnlockCo(arg_21_0.type)
	local var_21_1 = RoomTradeConfig.instance:getLevelUnlockCo(arg_21_1.type)

	if var_21_0 and var_21_1 then
		return var_21_0.sort < var_21_1.sort
	end

	return arg_21_0.type < arg_21_1.type
end

function var_0_0.getBuildingTaskIcon(arg_22_0, arg_22_1)
	local var_22_0 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Building, arg_22_1)

	return var_22_0 and ResUrl.getRoomCritterIcon(var_22_0.icon)
end

function var_0_0.getCanGetExtraBonus(arg_23_0)
	return arg_23_0.canGetExtraBonus
end

function var_0_0.setCanGetExtraBonus(arg_24_0)
	arg_24_0.canGetExtraBonus = false
end

var_0_0.instance = var_0_0.New()

return var_0_0
