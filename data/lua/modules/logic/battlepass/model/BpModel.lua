module("modules.logic.battlepass.model.BpModel", package.seeall)

local var_0_0 = class("BpModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.preStatus = nil
	arg_1_0.animProcess = 0
	arg_1_0.animData = nil
	arg_1_0.isViewLoading = nil
	arg_1_0.lockLevelUpShow = false
	arg_1_0.cacheBonus = nil
	arg_1_0.firstShowSp = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._hasGetInfo = nil
	arg_2_0.firstShow = nil
	arg_2_0.firstShowSp = nil
	arg_2_0.lockAlertBonus = nil

	arg_2_0:onInit()
end

function var_0_0.onGetInfo(arg_3_0, arg_3_1)
	arg_3_0._hasGetInfo = true
	arg_3_0.id = arg_3_1.id
	arg_3_0.score = arg_3_1.score
	arg_3_0.payStatus = arg_3_1.payStatus
	arg_3_0.startTime = arg_3_1.startTime
	arg_3_0.endTime = arg_3_1.endTime
	arg_3_0.weeklyScore = arg_3_1.weeklyScore
	arg_3_0.firstShow = arg_3_1.firstShow
	arg_3_0.firstShowSp = arg_3_1.spFirstShow
end

function var_0_0.hasGetInfo(arg_4_0)
	return arg_4_0._hasGetInfo
end

function var_0_0.isEnd(arg_5_0)
	if not arg_5_0._hasGetInfo or arg_5_0.endTime == 0 then
		return true
	end

	return false
end

function var_0_0.updateScore(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.score = arg_6_1
	arg_6_0.weeklyScore = arg_6_2
end

function var_0_0.updatePayStatus(arg_7_0, arg_7_1)
	arg_7_0.payStatus = arg_7_1
end

function var_0_0.onBuyLevel(arg_8_0, arg_8_1)
	arg_8_0.score = arg_8_1
end

function var_0_0.buildChargeFlow(arg_9_0)
	if not arg_9_0._chargeFlow then
		arg_9_0._chargeFlow = BpChargeFlow.New()
	end

	arg_9_0._chargeFlow:registerDoneListener(arg_9_0.clearFlow, arg_9_0)
	arg_9_0._chargeFlow:buildFlow()
end

function var_0_0.isInFlow(arg_10_0)
	return arg_10_0._chargeFlow and true or false
end

function var_0_0.clearFlow(arg_11_0)
	if arg_11_0._chargeFlow then
		arg_11_0._chargeFlow:onDestroyInternal()

		arg_11_0._chargeFlow = nil
	end
end

function var_0_0.isWeeklyScoreFull(arg_12_0)
	return (arg_12_0.weeklyScore or 0) >= var_0_0.instance:getWeeklyMaxScore()
end

function var_0_0.getBpChargeLeftSec(arg_13_0)
	local var_13_0 = lua_bp.configDict[var_0_0.instance.id]

	if not var_13_0 then
		return
	end

	local var_13_1 = StoreConfig.instance:getChargeGoodsConfig(var_13_0.chargeId1)

	if not var_13_1 then
		return
	end

	if type(var_13_1.offlineTime) == "number" then
		return var_13_1.offlineTime - ServerTime.now()
	end
end

function var_0_0.isBpChargeEnd(arg_14_0)
	local var_14_0 = arg_14_0:getBpChargeLeftSec()

	if var_14_0 and var_14_0 < 0 then
		return true
	else
		return false
	end
end

function var_0_0.checkLevelUp(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = BpConfig.instance:getLevelScore(arg_15_0.id)

	return math.floor(arg_15_1 / var_15_0) > math.floor((arg_15_2 or arg_15_0.score) / var_15_0)
end

function var_0_0.getBpLv(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or arg_16_0.score or 0

	local var_16_0 = BpConfig.instance:getLevelScore(arg_16_0.id)

	return math.floor(arg_16_1 / var_16_0)
end

function var_0_0.isShowExpUp(arg_17_0)
	local var_17_0 = BpConfig.instance:getBpCO(arg_17_0.id or 0)

	if not var_17_0 then
		return false
	end

	return var_17_0 and var_17_0.expUpShow or false
end

function var_0_0.getWeeklyMaxScore(arg_18_0)
	local var_18_0 = CommonConfig.instance:getConstNum(ConstEnum.BpWeeklyMaxScore)
	local var_18_1 = BpConfig.instance:getBpCO(arg_18_0.id or 0)

	if not var_18_1 then
		return var_18_0
	end

	local var_18_2 = 1000 + (var_18_1.weekLimitTimes or 0)

	if var_18_2 > 1000 then
		var_18_0 = math.floor(var_18_2 * var_18_0 / 1000)
	end

	return var_18_0
end

function var_0_0.checkShowPayBonusTip(arg_19_0, arg_19_1)
	if arg_19_0:isEnd() or arg_19_0.payStatus ~= BpEnum.PayStatus.NotPay then
		return false
	end

	local var_19_0 = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.BpShowBonusLvs), "#")

	if not var_19_0 or not var_19_0[1] then
		return false
	end

	local var_19_1 = arg_19_0:getBpLv()

	if var_19_1 < var_19_0[1] then
		return false
	end

	local var_19_2 = arg_19_0.id or 0
	local var_19_3 = BpConfig.instance:getBpCO(var_19_2)
	local var_19_4 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.BpShowPayBonusTip .. var_19_2, "")
	local var_19_5 = false
	local var_19_6 = string.splitToNumber(var_19_4, "#") or {}
	local var_19_7 = TimeUtil.stringToTimestamp(var_19_3.showBonusDate) + ServerTime.clientToServerOffset()

	if ServerTime.now() - var_19_7 >= 0 and not tabletool.indexOf(var_19_6, -1) then
		table.insert(var_19_6, -1)

		var_19_5 = true
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1 <= var_19_1 and not tabletool.indexOf(var_19_6, iter_19_1) then
			table.insert(var_19_6, iter_19_1)

			var_19_5 = true
		end
	end

	if var_19_5 then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.BpShowPayBonusTip .. var_19_2, table.concat(var_19_6, "#"))
	end

	return var_19_5
end

var_0_0.instance = var_0_0.New()

return var_0_0
