module("modules.logic.meilanni.model.MeilanniModel", package.seeall)

local var_0_0 = class("MeilanniModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clear()
end

function var_0_0._clear(arg_3_0)
	arg_3_0._mapInfoList = {}
	arg_3_0._curMapId = nil
end

function var_0_0.setCurMapId(arg_4_0, arg_4_1)
	arg_4_0._curMapId = arg_4_1
end

function var_0_0.getCurMapId(arg_5_0)
	return arg_5_0._curMapId
end

function var_0_0.setBattleElementId(arg_6_0, arg_6_1)
	arg_6_0._battleElementId = arg_6_1
end

function var_0_0.getBattleElementId(arg_7_0)
	return arg_7_0._battleElementId
end

function var_0_0.updateMapList(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0:updateMapInfo(iter_8_1)
	end
end

function var_0_0.updateMapInfo(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._mapInfoList[arg_9_1.mapId] or MeilanniMapInfoMO.New()

	var_9_0:init(arg_9_1)

	arg_9_0._mapInfoList[arg_9_1.mapId] = var_9_0
end

function var_0_0.updateMapExcludeRules(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._mapInfoList[arg_10_1.mapId]

	if var_10_0 then
		var_10_0:updateExcludeRules(arg_10_1)
	end
end

function var_0_0.getMapInfo(arg_11_0, arg_11_1)
	return arg_11_0._mapInfoList[arg_11_1]
end

function var_0_0.getMapHighestScore(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._mapInfoList[arg_12_1]

	return var_12_0 and var_12_0.highestScore or 0
end

function var_0_0.updateEpisodeInfo(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.mapId
	local var_13_1 = arg_13_0:getMapInfo(var_13_0)

	if var_13_1 then
		var_13_1:updateEpisodeInfo(arg_13_1)
	end
end

function var_0_0.getEventInfo(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getMapInfo(arg_14_1)

	return var_14_0 and var_14_0:getEventInfo(arg_14_2)
end

function var_0_0.getMapIdByBattleId(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._mapInfoList) do
		if iter_15_1:getEpisodeByBattleId(arg_15_1) then
			return iter_15_1.mapId
		end
	end
end

function var_0_0.setDialogItemFadeIndex(arg_16_0, arg_16_1)
	arg_16_0._dialogItemFadeIndex = arg_16_1
end

function var_0_0.getDialogItemFadeIndex(arg_17_0)
	if arg_17_0._dialogItemFadeIndex and arg_17_0._dialogItemFadeIndex >= 0 then
		arg_17_0._dialogItemFadeIndex = arg_17_0._dialogItemFadeIndex + 1
	end

	return arg_17_0._dialogItemFadeIndex
end

function var_0_0.setStatResult(arg_18_0, arg_18_1)
	arg_18_0.statResult = arg_18_1
end

function var_0_0.getStatResult(arg_19_0)
	return arg_19_0.statResult
end

var_0_0.instance = var_0_0.New()

return var_0_0
