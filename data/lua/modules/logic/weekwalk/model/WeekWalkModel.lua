module("modules.logic.weekwalk.model.WeekWalkModel", package.seeall)

local var_0_0 = class("WeekWalkModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._battleElementId = nil
	arg_2_0._weekWalkInfo = nil
	arg_2_0._curFinishMapId = nil
end

function var_0_0.isShallowLayer(arg_3_0)
	return arg_3_0 and arg_3_0 <= 10
end

function var_0_0.isShallowMap(arg_4_0)
	return arg_4_0 and WeekWalkEnum.ShallowMapIds[arg_4_0]
end

function var_0_0.setFinishMapId(arg_5_0, arg_5_1)
	arg_5_0._curFinishMapId = arg_5_1
end

function var_0_0.getFinishMapId(arg_6_0)
	return arg_6_0._curFinishMapId
end

function var_0_0.setCurMapId(arg_7_0, arg_7_1)
	arg_7_0._curMapId = arg_7_1
end

function var_0_0.getCurMapId(arg_8_0)
	return arg_8_0._curMapId
end

function var_0_0.getCurMapConfig(arg_9_0)
	return (WeekWalkConfig.instance:getMapConfig(arg_9_0._curMapId))
end

function var_0_0.getCurMapIsFinish(arg_10_0)
	return arg_10_0:getCurMapInfo().isFinish > 0
end

function var_0_0.getCurMapInfo(arg_11_0)
	return arg_11_0:getMapInfo(arg_11_0._curMapId)
end

function var_0_0.getOldOrNewCurMapInfo(arg_12_0)
	return arg_12_0._oldInfo and arg_12_0._oldInfo:getMapInfo(arg_12_0._curMapId) or arg_12_0:getCurMapInfo()
end

function var_0_0.getMapInfo(arg_13_0, arg_13_1)
	return arg_13_0._weekWalkInfo and arg_13_0._weekWalkInfo:getMapInfo(arg_13_1)
end

function var_0_0.setBattleElementId(arg_14_0, arg_14_1)
	arg_14_0._battleElementId = arg_14_1
end

function var_0_0.getBattleElementId(arg_15_0)
	return arg_15_0._battleElementId
end

function var_0_0.infoNeedUpdate(arg_16_0)
	return arg_16_0._oldInfo
end

function var_0_0.updateHeroHpInfo(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._weekWalkInfo:updateHeroHpInfo(arg_17_1, arg_17_2)
end

function var_0_0.updateInfo(arg_18_0, arg_18_1)
	arg_18_0:initInfo(arg_18_1)
end

function var_0_0.initInfo(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = WeekwalkInfoMO.New()

	var_19_0:init(arg_19_1)

	arg_19_0._weekWalkInfo = var_19_0
end

function var_0_0.getInfo(arg_20_0)
	return arg_20_0._weekWalkInfo
end

function var_0_0.addOldInfo(arg_21_0)
	if not arg_21_0._curMapId or var_0_0.isShallowMap(arg_21_0._curMapId) then
		return
	end

	arg_21_0._oldInfo = arg_21_0._weekWalkInfo
end

function var_0_0.clearOldInfo(arg_22_0)
	arg_22_0._oldInfo = nil
end

function var_0_0.getMaxLayerId(arg_23_0)
	return arg_23_0._weekWalkInfo.maxLayer
end

function var_0_0.getOldOrNewElementInfos(arg_24_0, arg_24_1)
	if arg_24_0._oldInfo then
		local var_24_0 = arg_24_0._oldInfo and arg_24_0._oldInfo:getMapInfo(arg_24_1)

		if var_24_0 then
			return var_24_0.elementInfos
		end
	end

	return arg_24_0:getElementInfos(arg_24_1)
end

function var_0_0.getElementInfos(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getMapInfo(arg_25_1)

	return var_25_0 and var_25_0.elementInfos
end

function var_0_0.getElementInfo(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:getMapInfo(arg_26_1)

	return var_26_0 and var_26_0:getElementInfo(arg_26_2)
end

function var_0_0.getBattleInfo(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:getMapInfo(arg_27_1)

	return var_27_0 and var_27_0:getBattleInfo(arg_27_2)
end

function var_0_0.getBattleInfoByLayerAndIndex(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0._weekWalkInfo and arg_28_0._weekWalkInfo:getMapInfoByLayer(arg_28_1)

	return var_28_0 and var_28_0:getBattleInfoByIndex(arg_28_2)
end

function var_0_0.getCurMapHeroCd(arg_29_0, arg_29_1)
	return arg_29_0:getHeroCd(arg_29_0._curMapId, arg_29_1)
end

function var_0_0.getHeroCd(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0:getMapInfo(arg_30_1)

	return var_30_0 and var_30_0:getHeroCd(arg_30_2) or 0
end

function var_0_0.setSkipShowSettlementView(arg_31_0, arg_31_1)
	arg_31_0._skipShowSettlementView = arg_31_1
end

function var_0_0.getSkipShowSettlementView(arg_32_0)
	return arg_32_0._skipShowSettlementView
end

var_0_0.instance = var_0_0.New()

return var_0_0
