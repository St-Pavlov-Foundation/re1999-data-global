module("modules.logic.weekwalk.model.WeekwalkElementInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkElementInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.elementId = arg_1_1.elementId
	arg_1_0.isFinish = arg_1_1.isFinish
	arg_1_0.index = arg_1_1.index
	arg_1_0.historylist = arg_1_1.historylist
	arg_1_0.visible = arg_1_1.visible
	arg_1_0.config = WeekWalkConfig.instance:getElementConfig(arg_1_0.elementId)

	if not arg_1_0.config then
		logError(string.format("WeekwalkElementInfoMO no config id:%s", arg_1_0.elementId))

		return
	end

	arg_1_0.typeList = string.splitToNumber(arg_1_0.config.type, "#")
	arg_1_0.paramList = string.split(arg_1_0.config.param, "|")
end

function var_0_0.getRes(arg_2_0)
	if arg_2_0._mapInfo:getLayer() >= WeekWalkEnum.FirstDeepLayer and arg_2_0.config.roundId ~= 0 then
		local var_2_0 = arg_2_0._mapInfo:getMapConfig()
		local var_2_1 = arg_2_0.config.roundId == WeekWalkEnum.OneDeepLayerFirstBattle and var_2_0.resIdFront or var_2_0.resIdRear

		if var_2_1 > 0 then
			local var_2_2 = lua_weekwalk_element_res.configDict[var_2_1]

			if var_2_2 then
				return var_2_2.res
			end
		end
	end

	return arg_2_0.config.res
end

function var_0_0.setMapInfo(arg_3_0, arg_3_1)
	arg_3_0._mapInfo = arg_3_1
end

function var_0_0.isAvailable(arg_4_0)
	return not arg_4_0.isFinish and arg_4_0.visible
end

function var_0_0.updateHistoryList(arg_5_0, arg_5_1)
	arg_5_0.historylist = arg_5_1
end

function var_0_0.getType(arg_6_0)
	return arg_6_0.typeList[arg_6_0.index + 1]
end

function var_0_0.getNextType(arg_7_0)
	return arg_7_0.typeList[arg_7_0.index + 2]
end

function var_0_0.getParam(arg_8_0)
	return arg_8_0.paramList[arg_8_0.index + 1]
end

function var_0_0.getPrevParam(arg_9_0)
	return arg_9_0.paramList[arg_9_0.index]
end

function var_0_0.getBattleId(arg_10_0)
	return arg_10_0:_getBattleId()
end

function var_0_0._getBattleId(arg_11_0)
	if arg_11_0._mapInfo:getLayer() >= WeekWalkEnum.FirstDeepLayer and arg_11_0.config.roundId ~= 0 then
		local var_11_0 = arg_11_0._mapInfo:getMapConfig()
		local var_11_1 = arg_11_0.config.roundId == WeekWalkEnum.OneDeepLayerFirstBattle and var_11_0.fightIdFront or var_11_0.fightIdRear

		if arg_11_0:_checkBattleId(var_11_1, true) then
			return var_11_1
		end
	end

	local var_11_2 = arg_11_0:getParam()

	return (tonumber(var_11_2))
end

function var_0_0._checkBattleId(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 and arg_12_1 > 0 then
		if not arg_12_0._mapInfo:getBattleInfo(arg_12_1) then
			logError(string.format("WeekwalkElementInfoMO no battleInfo mapId:%s elementId:%s battleId:%s isFromMap:%s", arg_12_0._mapInfo.id, arg_12_0.elementId, arg_12_1, arg_12_2))

			return false
		end

		return true
	end
end

function var_0_0.getConfigBattleId(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.typeList) do
		if iter_13_1 == WeekWalkEnum.ElementType.Battle then
			local var_13_0 = arg_13_0.paramList[iter_13_0]

			return tonumber(var_13_0)
		end
	end
end

function var_0_0._isBattleElement(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.typeList) do
		if iter_14_1 == WeekWalkEnum.ElementType.Battle then
			return true
		end
	end
end

return var_0_0
