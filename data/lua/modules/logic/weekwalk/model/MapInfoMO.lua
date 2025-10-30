module("modules.logic.weekwalk.model.MapInfoMO", package.seeall)

local var_0_0 = pureTable("MapInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.sceneId = arg_1_1.sceneId
	arg_1_0.isFinish = arg_1_1.isFinish
	arg_1_0.isFinished = arg_1_1.isFinished
	arg_1_0.buffId = arg_1_1.buffId
	arg_1_0.isShowBuff = arg_1_1.isShowBuff
	arg_1_0.isShowFinished = arg_1_1.isShowFinished
	arg_1_0.isShowSelectCd = arg_1_1.isShowSelectCd

	if arg_1_0.id == 9477 then
		arg_1_0.sceneId = 17
	end

	arg_1_0.battleIds = {}
	arg_1_0.battleInfos = {}
	arg_1_0.battleInfoMap = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.battleInfos) do
		if not arg_1_0.battleInfoMap[iter_1_1.battleId] then
			local var_1_0 = BattleInfoMO.New()

			var_1_0:init(iter_1_1)
			var_1_0:setIndex(iter_1_0)
			table.insert(arg_1_0.battleIds, iter_1_1.battleId)
			table.insert(arg_1_0.battleInfos, var_1_0)

			arg_1_0.battleInfoMap[var_1_0.battleId] = var_1_0
		end
	end

	arg_1_0.elementInfos = {}
	arg_1_0.elementInfoMap = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.elementInfos) do
		local var_1_1 = WeekwalkElementInfoMO.New()

		var_1_1:init(iter_1_3)
		var_1_1:setMapInfo(arg_1_0)
		table.insert(arg_1_0.elementInfos, var_1_1)

		arg_1_0.elementInfoMap[var_1_1.elementId] = var_1_1
	end

	arg_1_0._heroInfos = {}
	arg_1_0._heroInfoList = {}

	if arg_1_1.heroInfos then
		for iter_1_4, iter_1_5 in ipairs(arg_1_1.heroInfos) do
			local var_1_2 = WeekwalkHeroInfoMO.New()

			var_1_2:init(iter_1_5)

			arg_1_0._heroInfos[iter_1_5.heroId] = var_1_2

			table.insert(arg_1_0._heroInfoList, var_1_2)
		end
	end

	arg_1_0._storyIds = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.storyIds) do
		arg_1_0._storyIds[iter_1_7] = iter_1_7
	end

	arg_1_0._mapConfig = WeekWalkConfig.instance:getMapConfig(arg_1_0.id)

	if arg_1_0._mapConfig then
		arg_1_0._typeConfig = lua_weekwalk_type.configDict[arg_1_0._mapConfig.type]
	end
end

function var_0_0.getBattleInfoByIndex(arg_2_0, arg_2_1)
	return arg_2_0.battleInfos[arg_2_1]
end

function var_0_0.getLayer(arg_3_0)
	return arg_3_0._mapConfig.layer
end

function var_0_0.getMapConfig(arg_4_0)
	return arg_4_0._mapConfig
end

function var_0_0.storyIsFinished(arg_5_0, arg_5_1)
	return arg_5_0._storyIds[arg_5_1]
end

function var_0_0.getElementInfo(arg_6_0, arg_6_1)
	return arg_6_0.elementInfoMap[arg_6_1]
end

function var_0_0.getBattleInfo(arg_7_0, arg_7_1)
	return arg_7_0.battleInfoMap[arg_7_1]
end

function var_0_0.getHasStarIndex(arg_8_0)
	for iter_8_0 = #arg_8_0.battleInfos, 1, -1 do
		if arg_8_0.battleInfos[iter_8_0].star > 0 then
			return iter_8_0
		end
	end

	return 0
end

function var_0_0.getStarInfo(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.battleInfos) do
		var_9_0 = var_9_0 + iter_9_1.maxStar
	end

	return var_9_0, #arg_9_0.battleInfos * arg_9_0._typeConfig.starNum
end

function var_0_0.getCurStarInfo(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.battleInfos) do
		var_10_0 = var_10_0 + iter_10_1.star
	end

	return var_10_0, #arg_10_0.battleInfos * arg_10_0._typeConfig.starNum
end

function var_0_0.getStarNumConfig(arg_11_0)
	return arg_11_0._typeConfig.starNum
end

function var_0_0.getNoStarBattleInfo(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.battleInfos) do
		if iter_12_1.star <= 0 then
			return iter_12_1
		end
	end
end

function var_0_0.getNoStarBattleIndex(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.battleInfos) do
		if iter_13_1.maxStar <= 0 then
			return iter_13_0
		end
	end

	return #arg_13_0.battleInfos
end

function var_0_0.getHeroInfoList(arg_14_0)
	return arg_14_0._heroInfoList
end

function var_0_0.getHeroCd(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._heroInfos[arg_15_1]

	return var_15_0 and var_15_0.cd or 0
end

function var_0_0.clearHeroCd(arg_16_0, arg_16_1)
	arg_16_0.isShowSelectCd = false

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		arg_16_0._heroInfos[iter_16_1] = nil
	end
end

return var_0_0
