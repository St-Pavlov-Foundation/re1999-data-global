module("modules.logic.versionactivity2_2.act169.model.SummonNewCustomPickViewModel", package.seeall)

local var_0_0 = class("SummonNewCustomPickViewModel", BaseModel)

var_0_0.DEFAULT_HERO_ID = 0
var_0_0.MAX_SELECT_COUNT = 1

function var_0_0.onInit(arg_1_0)
	arg_1_0._activityMoDic = {}
	arg_1_0._showFx = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._activityMoDic = {}
	arg_2_0._showFx = {}
end

function var_0_0.onGetInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:setReward(arg_3_1, arg_3_2)
end

function var_0_0.getHaveFirstDayLogin(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getDaliyLoginKey(arg_4_1)

	return TimeUtil.getDayFirstLoginRed(var_4_0)
end

function var_0_0.setHaveFirstDayLogin(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getDaliyLoginKey(arg_5_1)

	TimeUtil.setDayFirstLoginRed(var_5_0)
end

function var_0_0.getDaliyLoginKey(arg_6_0, arg_6_1)
	return PlayerPrefsKey.Version2_2SummonNewCustomPatFace .. tostring(arg_6_1)
end

function var_0_0.setCurActId(arg_7_0, arg_7_1)
	arg_7_0._actId = arg_7_1

	SummonNewCustomPickChoiceController.instance:onSelectActivity(arg_7_1)
end

function var_0_0.getCurActId(arg_8_0)
	return arg_8_0._actId
end

function var_0_0.setReward(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getActivityInfo(arg_9_1)

	if var_9_0 then
		var_9_0.heroId = arg_9_2
	end

	local var_9_1 = SummonNewCustomPickViewMo.New(arg_9_1, arg_9_2)

	arg_9_0._activityMoDic[arg_9_1] = var_9_1
end

function var_0_0.setSelect(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getActivityInfo(arg_10_1)

	if not var_10_0 then
		return
	end

	if arg_10_0:isSelect(var_10_0) then
		return
	end

	var_10_0.selectId = arg_10_2
end

function var_0_0.getMaxSelectCount(arg_11_0)
	return arg_11_0.MAX_SELECT_COUNT
end

function var_0_0.getSummonPickScope(arg_12_0, arg_12_1)
	return SummonNewCustomPickViewConfig.instance:getSummonConfigById(arg_12_1).heroIds
end

function var_0_0.getSummonInfo(arg_13_0, arg_13_1)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(arg_13_1)
end

function var_0_0.isSelect(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getActivityInfo(arg_14_1)

	if var_14_0 == nil then
		return false
	end

	return arg_14_0:isMoSelect(var_14_0)
end

function var_0_0.isActivityOpen(arg_15_0, arg_15_1)
	local var_15_0 = ServerTime.now() * 1000

	if not arg_15_1 or not ActivityModel.instance:isActOnLine(arg_15_1) then
		return false
	end

	if var_15_0 < ActivityModel.instance:getActStartTime(arg_15_1) then
		return false
	end

	if var_15_0 >= ActivityModel.instance:getActEndTime(arg_15_1) then
		return false
	end

	return true
end

function var_0_0.isMoSelect(arg_16_0, arg_16_1)
	return arg_16_1.activityId ~= var_0_0.DEFAULT_HERO_ID
end

function var_0_0.isNewbiePoolExist(arg_17_0)
	return SummonMainModel.instance:getNewbiePoolExist()
end

function var_0_0.isGetReward(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getActivityInfo(arg_18_1)

	if var_18_0 == nil then
		return false
	end

	return var_18_0.heroId ~= arg_18_0.DEFAULT_HERO_ID
end

function var_0_0.getActivityInfo(arg_19_0, arg_19_1)
	return arg_19_0._activityMoDic[arg_19_1]
end

function var_0_0.setGetRewardFxState(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._showFx[arg_20_1] = arg_20_2
end

function var_0_0.getGetRewardFxState(arg_21_0, arg_21_1)
	return arg_21_0._showFx[arg_21_1] and true or false
end

var_0_0.instance = var_0_0.New()

return var_0_0
