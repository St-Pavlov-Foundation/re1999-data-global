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

function var_0_0.getBpEndTime(arg_6_0)
	return arg_6_0.endTime or 0
end

function var_0_0.updateScore(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.score = arg_7_1
	arg_7_0.weeklyScore = arg_7_2
end

function var_0_0.updatePayStatus(arg_8_0, arg_8_1)
	arg_8_0.payStatus = arg_8_1
end

function var_0_0.onBuyLevel(arg_9_0, arg_9_1)
	arg_9_0.score = arg_9_1
end

function var_0_0.buildChargeFlow(arg_10_0)
	if not arg_10_0._chargeFlow then
		arg_10_0._chargeFlow = BpChargeFlow.New()
	end

	arg_10_0._chargeFlow:registerDoneListener(arg_10_0.clearFlow, arg_10_0)
	arg_10_0._chargeFlow:buildFlow()
end

function var_0_0.isInFlow(arg_11_0)
	return arg_11_0._chargeFlow and true or false
end

function var_0_0.clearFlow(arg_12_0)
	if arg_12_0._chargeFlow then
		arg_12_0._chargeFlow:onDestroyInternal()

		arg_12_0._chargeFlow = nil
	end
end

function var_0_0.isWeeklyScoreFull(arg_13_0)
	return (arg_13_0.weeklyScore or 0) >= arg_13_0:getWeeklyMaxScore()
end

function var_0_0.getBpChargeLeftSec(arg_14_0)
	local var_14_0 = lua_bp.configDict[var_0_0.instance.id]

	if not var_14_0 then
		return
	end

	local var_14_1 = StoreConfig.instance:getChargeGoodsConfig(var_14_0.chargeId1)

	if not var_14_1 then
		return
	end

	if type(var_14_1.offlineTime) == "number" then
		return var_14_1.offlineTime - ServerTime.now()
	end
end

function var_0_0.isBpChargeEnd(arg_15_0)
	local var_15_0 = arg_15_0:getBpChargeLeftSec()

	if var_15_0 and var_15_0 < 0 then
		return true
	else
		return false
	end
end

function var_0_0.checkLevelUp(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = BpConfig.instance:getLevelScore(arg_16_0.id)

	return math.floor(arg_16_1 / var_16_0) > math.floor((arg_16_2 or arg_16_0.score) / var_16_0)
end

function var_0_0.getBpLv(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or arg_17_0.score or 0

	local var_17_0 = BpConfig.instance:getLevelScore(arg_17_0.id)

	return math.floor(arg_17_1 / var_17_0)
end

function var_0_0.isShowExpUp(arg_18_0)
	local var_18_0 = BpConfig.instance:getBpCO(arg_18_0.id or 0)

	if not var_18_0 then
		return false
	end

	return var_18_0 and var_18_0.expUpShow or false
end

function var_0_0.getWeeklyMaxScore(arg_19_0)
	local var_19_0 = CommonConfig.instance:getConstNum(ConstEnum.BpWeeklyMaxScore)
	local var_19_1 = BpConfig.instance:getBpCO(arg_19_0.id or 0)

	if not var_19_1 then
		return var_19_0
	end

	local var_19_2 = 1000 + (var_19_1.weekLimitTimes or 0)

	if var_19_2 > 1000 then
		var_19_0 = math.floor(var_19_2 * var_19_0 / 1000)
	end

	return var_19_0
end

function var_0_0.checkShowPayBonusTip(arg_20_0, arg_20_1)
	if arg_20_0:isEnd() or arg_20_0.payStatus ~= BpEnum.PayStatus.NotPay then
		return false
	end

	local var_20_0 = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.BpShowBonusLvs), "#")

	if not var_20_0 or not var_20_0[1] then
		return false
	end

	local var_20_1 = arg_20_0:getBpLv()

	if var_20_1 < var_20_0[1] then
		return false
	end

	local var_20_2 = arg_20_0.id or 0
	local var_20_3 = BpConfig.instance:getBpCO(var_20_2)
	local var_20_4 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.BpShowPayBonusTip .. var_20_2, "")
	local var_20_5 = false
	local var_20_6 = string.splitToNumber(var_20_4, "#") or {}
	local var_20_7 = TimeUtil.stringToTimestamp(var_20_3.showBonusDate) + ServerTime.clientToServerOffset()

	if ServerTime.now() - var_20_7 >= 0 and not tabletool.indexOf(var_20_6, -1) then
		table.insert(var_20_6, -1)

		var_20_5 = true
	end

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1 <= var_20_1 and not tabletool.indexOf(var_20_6, iter_20_1) then
			table.insert(var_20_6, iter_20_1)

			var_20_5 = true
		end
	end

	if var_20_5 then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.BpShowPayBonusTip .. var_20_2, table.concat(var_20_6, "#"))
	end

	return var_20_5
end

function var_0_0.isMaxLevel(arg_21_0)
	local var_21_0 = BpConfig.instance:getLevelScore(arg_21_0.id)

	return math.floor(arg_21_0.score / var_21_0) >= #BpConfig.instance:getBonusCOList(arg_21_0.id)
end

var_0_0.instance = var_0_0.New()

return var_0_0
