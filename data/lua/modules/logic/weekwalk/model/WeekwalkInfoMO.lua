module("modules.logic.weekwalk.model.WeekwalkInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.time = arg_1_1.time
	arg_1_0.endTime = arg_1_1.endTime
	arg_1_0.maxLayer = arg_1_1.maxLayer
	arg_1_0.issueId = arg_1_1.issueId
	arg_1_0.isPopDeepRule = arg_1_1.isPopDeepRule
	arg_1_0.isOpenDeep = arg_1_1.isOpenDeep
	arg_1_0.isPopShallowSettle = arg_1_1.isPopShallowSettle
	arg_1_0.isPopDeepSettle = arg_1_1.isPopDeepSettle
	arg_1_0.deepProgress = arg_1_1.deepProgress
	arg_1_0._mapInfos = {}
	arg_1_0._mapInfosMap = {}

	if arg_1_1.mapInfo then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.mapInfo) do
			local var_1_0 = MapInfoMO.New()

			var_1_0:init(iter_1_1)

			arg_1_0._mapInfosMap[iter_1_1.id] = var_1_0

			table.insert(arg_1_0._mapInfos, var_1_0)
		end
	end

	table.sort(arg_1_0._mapInfos, var_0_0._sort)
end

function var_0_0._sort(arg_2_0, arg_2_1)
	return arg_2_0.id < arg_2_1.id
end

function var_0_0.getMapInfos(arg_3_0)
	return arg_3_0._mapInfos
end

function var_0_0.getNotFinishedMap(arg_4_0)
	local var_4_0 = #arg_4_0._mapInfos

	return arg_4_0._mapInfos[var_4_0], var_4_0
end

function var_0_0.getNameIndexByBattleId(arg_5_0, arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._mapInfos) do
		if iter_5_1:getBattleInfo(arg_5_1) then
			var_5_0 = iter_5_1

			break
		end
	end

	if not var_5_0 then
		return
	end

	for iter_5_2, iter_5_3 in ipairs(lua_weekwalk.configList) do
		if iter_5_3.id == var_5_0.id then
			return lua_weekwalk_scene.configDict[var_5_0.sceneId].battleName, iter_5_3.layer
		end
	end
end

function var_0_0.getMapInfo(arg_6_0, arg_6_1)
	return arg_6_0._mapInfosMap[arg_6_1]
end

function var_0_0.getMapInfoByLayer(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._mapInfos) do
		if iter_7_1:getLayer() == arg_7_1 then
			return iter_7_1
		end
	end
end

return var_0_0
