module("modules.logic.room.model.map.RoomProductionLineMO", package.seeall)

local var_0_0 = pureTable("RoomProductionLineMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.config = RoomConfig.instance:getProductionLineConfig(arg_1_0.id)
	arg_1_0.finishCount = 0
	arg_1_0.reserve = arg_1_0.config.reserve
	arg_1_0.useReserve = 0
	arg_1_0.level = 0

	if arg_1_0.config.levelGroup > 0 then
		arg_1_0.levelGroupCO = RoomConfig.instance:getProductionLineLevelGroupIdConfig(arg_1_0.config.levelGroup)
	end

	arg_1_0:updateMaxLevel()
end

function var_0_0.updateMaxLevel(arg_2_0)
	local var_2_0 = RoomModel.instance:getRoomLevel()

	arg_2_0.maxLevel = 0
	arg_2_0.maxConfigLevel = 0

	if arg_2_0.config.levelGroup > 0 and arg_2_0.levelGroupCO then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.levelGroupCO) do
			if var_2_0 >= iter_2_1.needRoomLevel then
				arg_2_0.maxLevel = math.max(iter_2_1.id, arg_2_0.maxLevel)
			end

			arg_2_0.maxConfigLevel = math.max(iter_2_1.id, arg_2_0.maxConfigLevel)
		end
	end
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0.formulaId = arg_3_1.formulaId
	arg_3_0.finishCount = arg_3_1.finishCount or 0
	arg_3_0.nextFinishTime = arg_3_1.nextFinishTime
	arg_3_0.pauseTime = arg_3_1.pauseTime
	arg_3_0.reserve = arg_3_0.config.reserve
	arg_3_0.useReserve = 0

	arg_3_0:updateLevel(arg_3_1.level or 1)
end

function var_0_0.updateLevel(arg_4_0, arg_4_1)
	arg_4_0.level = arg_4_1

	if arg_4_0.config.levelGroup > 0 then
		arg_4_0.levelCO = RoomConfig.instance:getProductionLineLevelConfig(arg_4_0.config.levelGroup, arg_4_0.level)

		local var_4_0 = GameUtil.splitString2(arg_4_0.levelCO.effect, true)
		local var_4_1 = 0

		if var_4_0 then
			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				if iter_4_1[1] == RoomBuildingEnum.EffectType.Reserve then
					arg_4_0.reserve = arg_4_0.reserve + iter_4_1[2]
				elseif iter_4_1[1] == RoomBuildingEnum.EffectType.Time then
					var_4_1 = var_4_1 + iter_4_1[2]
				end
			end
		end

		arg_4_0.formulaCO = RoomConfig.instance:getFormulaConfig(arg_4_0.formulaId)

		if not arg_4_0.formulaCO then
			return
		end

		arg_4_0.useReserve = arg_4_0.formulaCO.costReserve * arg_4_0.finishCount

		local var_4_2 = math.max(0, 1000 - var_4_1)

		arg_4_0.costTime = math.floor(arg_4_0.formulaCO.costTime * var_4_2 / 1000)
		arg_4_0.produceSpeed = string.splitToNumber(arg_4_0.formulaCO.produce, "#")[3]

		local var_4_3 = arg_4_0.reserve - (arg_4_0.useReserve + arg_4_0.formulaCO.costReserve)

		arg_4_0.allFinishTime = arg_4_0.nextFinishTime

		if var_4_3 > 0 then
			arg_4_0.allFinishTime = arg_4_0.allFinishTime + math.ceil(var_4_3 / arg_4_0.formulaCO.costReserve) * arg_4_0.costTime
		elseif var_4_3 < 0 then
			arg_4_0.allFinishTime = 0
		end
	end
end

function var_0_0.isCanGain(arg_5_0)
	return arg_5_0.useReserve > 0
end

function var_0_0.isLock(arg_6_0)
	return arg_6_0.level == 0
end

function var_0_0.isRoomLevelUnLockNext(arg_7_0)
	local var_7_0 = RoomModel.instance:getRoomLevel()

	return arg_7_0.config.needRoomLevel == var_7_0 + 1
end

function var_0_0.isPause(arg_8_0)
	return arg_8_0.pauseTime and arg_8_0.pauseTime > 0
end

function var_0_0.getReservePer(arg_9_0)
	local var_9_0 = arg_9_0.useReserve / arg_9_0.reserve
	local var_9_1 = math.min(1, var_9_0)
	local var_9_2 = 0

	if var_9_1 ~= 0 then
		var_9_2 = math.max(1, math.floor(var_9_1 * 100))
	end

	return var_9_1, var_9_2
end

function var_0_0.isFull(arg_10_0)
	return arg_10_0.useReserve >= arg_10_0.reserve
end

function var_0_0.isIdle(arg_11_0)
	return not arg_11_0.formulaId or arg_11_0.formulaId <= 0
end

function var_0_0.getGathericon(arg_12_0)
	local var_12_0 = arg_12_0.formulaId
	local var_12_1 = RoomProductionHelper.getFormulaProduceItem(var_12_0)

	if var_12_1 then
		local var_12_2

		if var_12_1.type == MaterialEnum.MaterialType.Currency then
			local var_12_3 = CurrencyConfig.instance:getCurrencyCo(var_12_1.id).icon

			var_12_2 = ResUrl.getCurrencyItemIcon(var_12_3 .. "_room")
		else
			var_12_2 = ResUrl.getCurrencyItemIcon(var_12_1.id .. "_room")
		end

		return var_12_2
	end
end

return var_0_0
