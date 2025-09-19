module("modules.logic.versionactivity3_1.nationalgift.model.NationalGiftModel", package.seeall)

local var_0_0 = class("NationalGiftModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfoDict = {}
end

function var_0_0.setActInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1.activityId or VersionActivity3_1Enum.ActivityId.NationalGift

	if not arg_3_0._actInfoDict[var_3_0] then
		arg_3_0._actInfoDict[var_3_0] = NationalGiftMO.New()
	end

	if not arg_3_1 then
		return
	end

	arg_3_0._actInfoDict[var_3_0]:init(arg_3_1)
end

function var_0_0.setActActive(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or VersionActivity3_1Enum.ActivityId.NationalGift

	if arg_4_0._actInfoDict[arg_4_2] then
		arg_4_0._actInfoDict[arg_4_2]:updateActActive(arg_4_1)
	end
end

function var_0_0.updateBonusStatus(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_3 = arg_5_3 or VersionActivity3_1Enum.ActivityId.NationalGift

	if arg_5_0._actInfoDict[arg_5_3] then
		arg_5_0._actInfoDict[arg_5_3]:updateBonusStatus(arg_5_1, arg_5_2)
	end
end

function var_0_0.updateBonuses(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or VersionActivity3_1Enum.ActivityId.NationalGift

	if arg_6_0._actInfoDict[arg_6_2] then
		arg_6_0._actInfoDict[arg_6_2]:updateBonuses(arg_6_1)
	end
end

function var_0_0.isBonusActive(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or VersionActivity3_1Enum.ActivityId.NationalGift

	return arg_7_0._actInfoDict[arg_7_1] and arg_7_0._actInfoDict[arg_7_1].isActive
end

function var_0_0.getBonusList(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or VersionActivity3_1Enum.ActivityId.NationalGift

	return arg_8_0._actInfoDict[arg_8_1] and arg_8_0._actInfoDict[arg_8_1].bonuses
end

function var_0_0.getBonusEndTime(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or VersionActivity3_1Enum.ActivityId.NationalGift

	if not arg_9_0._actInfoDict[arg_9_1] then
		return 0
	end

	return tonumber(arg_9_0._actInfoDict[arg_9_1].endTime) / 1000
end

function var_0_0.getBuyEndTime(arg_10_0)
	local var_10_0 = arg_10_0:getNationalGiftStoreId()
	local var_10_1 = StoreConfig.instance:getChargeGoodsConfig(var_10_0)

	if not var_10_1 then
		return 0
	end

	if type(var_10_1.offlineTime) == "number" then
		return var_10_1.offlineTime / 1000
	else
		if string.nilorempty(var_10_1.offlineTime) then
			return 0
		end

		return (TimeUtil.stringToTimestamp(var_10_1.offlineTime))
	end

	return 0
end

function var_0_0.isBonusGet(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or VersionActivity3_1Enum.ActivityId.NationalGift

	return arg_11_0._actInfoDict[arg_11_2] and arg_11_0._actInfoDict[arg_11_2]:isBonusGet(arg_11_1)
end

function var_0_0.isBonusCouldGet(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or VersionActivity3_1Enum.ActivityId.NationalGift

	return arg_12_0._actInfoDict[arg_12_2] and arg_12_0._actInfoDict[arg_12_2]:isBonusCouldGet(arg_12_1)
end

function var_0_0.isGiftHasBuy(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or VersionActivity3_1Enum.ActivityId.NationalGift

	return arg_13_0._actInfoDict[arg_13_1] and arg_13_0._actInfoDict[arg_13_1].isActive
end

function var_0_0.getCurRewardDay(arg_14_0)
	local var_14_0 = 1
	local var_14_1 = arg_14_0:getBonusList()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1.status ~= NationalGiftEnum.Status.NoGet then
			var_14_0 = iter_14_0
		end
	end

	return var_14_0
end

function var_0_0.isNeedShowReddot(arg_15_0)
	return GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.BpOperActLvUpReddotShow, 0) > 0
end

function var_0_0.getNationalGiftStoreId(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or VersionActivity3_1Enum.ActivityId.NationalGift

	return NationalGiftConfig.instance:getBonusCo(1, arg_16_1).packsId
end

var_0_0.instance = var_0_0.New()

return var_0_0
