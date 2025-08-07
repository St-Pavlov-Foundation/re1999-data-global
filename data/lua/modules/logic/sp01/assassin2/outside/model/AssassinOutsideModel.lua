module("modules.logic.sp01.assassin2.outside.model.AssassinOutsideModel", package.seeall)

local var_0_0 = class("AssassinOutsideModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	if arg_3_0._outsideMo then
		arg_3_0._outsideMo:clearData()
	end

	arg_3_0:setEnterFightQuest()
	arg_3_0:updateIsNeedPlayGetCoin()

	arg_3_0.playerCacheData = nil
end

function var_0_0.updateAllInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:updateIsNeedPlayGetCoin(arg_4_4)
	arg_4_0:getOutsideMo():updateAllInfo(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
end

function var_0_0.getAct195Id(arg_5_0)
	return VersionActivity2_9Enum.ActivityId.Outside
end

function var_0_0.isAct195Open(arg_6_0, arg_6_1)
	local var_6_0 = true
	local var_6_1
	local var_6_2

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.AssassinOutside) then
		var_6_1, var_6_2 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.AssassinOutside)
		var_6_0 = false
	else
		local var_6_3
		local var_6_4 = arg_6_0:getAct195Id()

		if ActivityModel.instance:getActivityInfo()[var_6_4] then
			var_6_3, var_6_1, var_6_2 = ActivityHelper.getActivityStatusAndToast(var_6_4)
		else
			var_6_1 = ToastEnum.ActivityEnd
		end

		var_6_0 = var_6_3 == ActivityEnum.ActivityStatus.Normal
	end

	if arg_6_1 and var_6_1 then
		GameFacade.showToast(var_6_1, var_6_2)
	end

	return var_6_0
end

function var_0_0.getOutsideMo(arg_7_0)
	if not arg_7_0._outsideMo then
		arg_7_0._outsideMo = AssassinOutsideMO.New()
	end

	return arg_7_0._outsideMo
end

function var_0_0.updateIsNeedPlayGetCoin(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getOutsideMo()
	local var_8_1 = var_8_0 and var_8_0:getCoinNum()

	if arg_8_1 and var_8_1 then
		arg_8_0._needPlayGetCoin = var_8_1 < arg_8_1
	else
		arg_8_0._needPlayGetCoin = nil
	end
end

function var_0_0.getIsNeedPlayGetCoin(arg_9_0)
	return arg_9_0._needPlayGetCoin
end

function var_0_0.saveCacheData(arg_10_0)
	if not arg_10_0.playerCacheData then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.AssassinOutsideDataKey, cjson.encode(arg_10_0.playerCacheData))
end

function var_0_0.unlockMapList(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getOutsideMo()

	if var_11_0 then
		var_11_0:unlockQuestMapByList(arg_11_1)
	end
end

function var_0_0.unlockQuestList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getOutsideMo()

	if var_12_0 then
		var_12_0:unlockQuestByList(arg_12_1)
	end
end

function var_0_0.finishQuest(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getOutsideMo()

	if var_13_0 then
		var_13_0:finishQuest(arg_13_1)
	end
end

function var_0_0.setEnterFightQuest(arg_14_0, arg_14_1)
	arg_14_0._enterFightQuest = arg_14_1
end

function var_0_0.getQuestMapStatus(arg_15_0, arg_15_1)
	return arg_15_0:getOutsideMo():getQuestMapStatus(arg_15_1)
end

function var_0_0.getQuestMapProgress(arg_16_0, arg_16_1)
	local var_16_0, var_16_1 = arg_16_0:getOutsideMo():getQuestMapProgress(arg_16_1)

	return var_16_0, var_16_1
end

function var_0_0.getQuestTypeProgressStr(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0:getOutsideMo():getQuestTypeProgressStr(arg_17_1, arg_17_2)
end

function var_0_0.getMapUnlockQuestIdList(arg_18_0, arg_18_1)
	return arg_18_0:getOutsideMo():getMapUnlockQuestIdList(arg_18_1)
end

function var_0_0.getMapFinishQuestIdList(arg_19_0, arg_19_1)
	return arg_19_0:getOutsideMo():getMapFinishQuestIdList(arg_19_1)
end

function var_0_0.isUnlockQuest(arg_20_0, arg_20_1)
	return arg_20_0:getOutsideMo():isUnlockQuest(arg_20_1)
end

function var_0_0.isFinishQuest(arg_21_0, arg_21_1)
	return arg_21_0:getOutsideMo():isFinishQuest(arg_21_1)
end

function var_0_0.getPlayerCacheData(arg_22_0)
	if not arg_22_0.playerCacheData then
		local var_22_0 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.AssassinOutsideDataKey, "")

		if not string.nilorempty(var_22_0) then
			arg_22_0.playerCacheData = cjson.decode(var_22_0)
		end

		arg_22_0.playerCacheData = arg_22_0.playerCacheData or {}
	end

	return arg_22_0.playerCacheData
end

function var_0_0.getCacheKeyData(arg_23_0, arg_23_1)
	local var_23_0 = false

	if arg_23_1 then
		local var_23_1 = arg_23_0:getPlayerCacheData()

		var_23_0 = var_23_1 and var_23_1[arg_23_1] or false
	end

	return var_23_0
end

function var_0_0.getProcessingQuest(arg_24_0)
	return arg_24_0:getOutsideMo():getProcessingQuest()
end

function var_0_0.getEnterFightQuest(arg_25_0)
	return arg_25_0._enterFightQuest
end

function var_0_0.getBuildingMapMo(arg_26_0)
	return arg_26_0:getOutsideMo():getBuildingMap()
end

function var_0_0.getBuildingMo(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getBuildingMapMo()

	return var_27_0 and var_27_0:getBuildingMo(arg_27_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
