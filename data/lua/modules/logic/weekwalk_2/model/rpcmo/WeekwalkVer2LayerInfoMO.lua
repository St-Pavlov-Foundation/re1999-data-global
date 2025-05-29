module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2LayerInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2LayerInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.sceneId = arg_1_1.sceneId
	arg_1_0.allPass = arg_1_1.allPass
	arg_1_0.finished = arg_1_1.finished
	arg_1_0.unlock = arg_1_1.unlock
	arg_1_0.showFinished = arg_1_1.showFinished
	arg_1_0.battleInfos, arg_1_0.battleInfoElementMap = GameUtil.rpcInfosToListAndMap(arg_1_1.battleInfos, WeekwalkVer2BattleInfoMO, "elementId")
	arg_1_0.elementInfos = GameUtil.rpcInfosToMap(arg_1_1.elementInfos, WeekwalkVer2ElementInfoMO, "index")
	arg_1_0.battleIds = {}
	arg_1_0.battleIndex = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.elementInfos) do
		local var_1_0 = arg_1_0:getBattleInfoByIndex(iter_1_1.index)

		var_1_0:setIndex(iter_1_1.index)

		arg_1_0.battleIds[iter_1_1.index] = var_1_0.battleId
		arg_1_0.battleIndex[var_1_0.battleId] = iter_1_1.index
	end

	table.sort(arg_1_0.battleInfos, function(arg_2_0, arg_2_1)
		return (arg_1_0.battleIndex[arg_2_0.battleId] or 0) < (arg_1_0.battleIndex[arg_2_1.battleId] or 0)
	end)

	arg_1_0.config = lua_weekwalk_ver2.configDict[arg_1_0.id]
	arg_1_0.sceneConfig = lua_weekwalk_ver2_scene.configDict[arg_1_0.config.sceneId]
end

function var_0_0.getBattleInfo(arg_3_0, arg_3_1)
	return arg_3_0:getBattleInfoByIndex(arg_3_1)
end

function var_0_0.getBattleInfoByIndex(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.elementInfos[arg_4_1]
	local var_4_1 = var_4_0 and var_4_0.elementId

	return var_4_1 and arg_4_0.battleInfoElementMap[var_4_1]
end

function var_0_0.getBattleInfoByBattleId(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.battleInfos) do
		if iter_5_1.battleId == arg_5_1 then
			return iter_5_1
		end
	end
end

function var_0_0.getLayer(arg_6_0)
	return arg_6_0.config.layer
end

function var_0_0.getChooseSkillNum(arg_7_0)
	return arg_7_0.config.chooseSkillNum
end

function var_0_0.getHasStarIndex(arg_8_0)
	for iter_8_0 = #arg_8_0.battleInfos, 1, -1 do
		if arg_8_0.battleInfos[iter_8_0].star > 0 then
			return iter_8_0
		end
	end

	return 0
end

function var_0_0.heroInCD(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.battleInfos) do
		if iter_9_1:heroInCD(arg_9_1) then
			return true
		end
	end
end

return var_0_0
