module("modules.logic.weekwalk_2.model.WeekWalk_2Model", package.seeall)

local var_0_0 = class("WeekWalk_2Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._weekWalkInfo = nil
	arg_2_0._weekWalkSettleInfo = nil
	arg_2_0._isWin = nil
end

function var_0_0.initFightSettleInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._isWin = arg_3_1 == 1
	arg_3_0._resultCupInfos = GameUtil.rpcInfosToMap(arg_3_2, WeekwalkVer2CupInfoMO, "index")
end

function var_0_0.isWin(arg_4_0)
	return arg_4_0._isWin
end

function var_0_0.getResultCupInfos(arg_5_0)
	return arg_5_0._resultCupInfos
end

function var_0_0.initSettleInfo(arg_6_0, arg_6_1)
	local var_6_0 = WeekwalkVer2SettleInfoMO.New()

	var_6_0:init(arg_6_1)

	arg_6_0._weekWalkSettleInfo = var_6_0
end

function var_0_0.getSettleInfo(arg_7_0)
	return arg_7_0._weekWalkSettleInfo
end

function var_0_0.clearSettleInfo(arg_8_0)
	arg_8_0._weekWalkSettleInfo = nil
end

function var_0_0.updateInfo(arg_9_0, arg_9_1)
	arg_9_0:initInfo(arg_9_1)
end

function var_0_0.initInfo(arg_10_0, arg_10_1)
	local var_10_0 = WeekwalkVer2InfoMO.New()

	callWithCatch(function()
		var_10_0:init(arg_10_1)
	end)

	arg_10_0._weekWalkInfo = var_10_0
end

function var_0_0.getInfo(arg_12_0)
	return arg_12_0._weekWalkInfo
end

function var_0_0.getTimeId(arg_13_0)
	return arg_13_0._weekWalkInfo and arg_13_0._weekWalkInfo.timeId
end

function var_0_0.getLayerInfo(arg_14_0, arg_14_1)
	return arg_14_0._weekWalkInfo and arg_14_0._weekWalkInfo:getLayerInfo(arg_14_1)
end

function var_0_0.getLayerInfoByLayerIndex(arg_15_0, arg_15_1)
	return arg_15_0._weekWalkInfo and arg_15_0._weekWalkInfo:getLayerInfoByLayerIndex(arg_15_1)
end

function var_0_0.setBattleElementId(arg_16_0, arg_16_1)
	arg_16_0._battleElementId = arg_16_1
end

function var_0_0.getBattleElementId(arg_17_0)
	return arg_17_0._battleElementId
end

function var_0_0.setCurMapId(arg_18_0, arg_18_1)
	arg_18_0._curMapId = arg_18_1
end

function var_0_0.getCurMapId(arg_19_0)
	return arg_19_0._curMapId
end

function var_0_0.getCurMapInfo(arg_20_0)
	return arg_20_0:getLayerInfo(arg_20_0._curMapId)
end

function var_0_0.getBattleInfo(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getLayerInfo(arg_21_1)

	return var_21_0 and var_21_0:getBattleInfoByBattleId(arg_21_2)
end

function var_0_0.getBattleInfoByLayerAndIndex(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._weekWalkInfo and arg_22_0._weekWalkInfo:getLayerInfoByLayerIndex(arg_22_1)

	return var_22_0 and var_22_0:getBattleInfoByIndex(arg_22_2)
end

function var_0_0.getBattleInfoByIdAndIndex(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0._weekWalkInfo and arg_23_0._weekWalkInfo:getLayerInfo(arg_23_1)

	return var_23_0 and var_23_0:getBattleInfoByIndex(arg_23_2)
end

function var_0_0.getCurMapHeroCd(arg_24_0, arg_24_1)
	return arg_24_0:getHeroCd(arg_24_0._curMapId, arg_24_1)
end

function var_0_0.getHeroCd(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:getLayerInfo(arg_25_1)

	return var_25_0 and var_25_0:heroInCD(arg_25_2) and 1 or 0
end

function var_0_0.getFightParam(arg_26_0)
	local var_26_0 = arg_26_0:getBattleElementId()
	local var_26_1 = arg_26_0:getCurMapId()
	local var_26_2 = {
		elementId = var_26_0,
		layerId = var_26_1
	}
	local var_26_3 = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()

	if var_26_3 then
		var_26_2.chooseSkillIds = {
			var_26_3
		}
	end

	return cjson.encode(var_26_2)
end

function var_0_0.setFinishMapId(arg_27_0, arg_27_1)
	arg_27_0._curFinishMapId = arg_27_1
end

function var_0_0.getFinishMapId(arg_28_0)
	return arg_28_0._curFinishMapId
end

var_0_0.instance = var_0_0.New()

return var_0_0
