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
	arg_1_0._mapInfoLayerMap = {}

	if arg_1_1.mapInfo then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.mapInfo) do
			local var_1_0 = MapInfoMO.New()

			var_1_0:init(iter_1_1)

			arg_1_0._mapInfosMap[iter_1_1.id] = var_1_0

			table.insert(arg_1_0._mapInfos, var_1_0)

			local var_1_1 = var_1_0:getLayer()

			if var_1_1 then
				if not arg_1_0._mapInfoLayerMap[var_1_1] then
					arg_1_0._mapInfoLayerMap[var_1_1] = var_1_0
				else
					logError("WeekwalkInfoMO init error,layer repeat:" .. tostring(var_1_1))
				end
			end
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

function var_0_0.getMapInfoLayer(arg_4_0)
	return arg_4_0._mapInfoLayerMap
end

function var_0_0.getNotFinishedMap(arg_5_0)
	local var_5_0 = #arg_5_0._mapInfos

	return arg_5_0._mapInfos[var_5_0], var_5_0
end

function var_0_0.getNameIndexByBattleId(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._mapInfos) do
		if iter_6_1:getBattleInfo(arg_6_1) then
			var_6_0 = iter_6_1

			break
		end
	end

	if not var_6_0 then
		return
	end

	for iter_6_2, iter_6_3 in ipairs(lua_weekwalk.configList) do
		if iter_6_3.id == var_6_0.id then
			return lua_weekwalk_scene.configDict[var_6_0.sceneId].battleName, iter_6_3.layer
		end
	end
end

function var_0_0.getMapInfo(arg_7_0, arg_7_1)
	return arg_7_0._mapInfosMap[arg_7_1]
end

function var_0_0.getMapInfoByLayer(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._mapInfos) do
		if iter_8_1:getLayer() == arg_8_1 then
			return iter_8_1
		end
	end
end

return var_0_0
