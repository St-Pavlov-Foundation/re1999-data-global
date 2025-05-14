module("modules.logic.versionactivity2_4.act181.model.Activity181Model", package.seeall)

local var_0_0 = class("Activity181Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._activityInfoDic = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._activityInfoDic = {}
end

function var_0_0.setActInfo(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_2 or not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_0._activityInfoDic[arg_3_1]

	if not var_3_0 then
		var_3_0 = Activity181MO.New()
		arg_3_0._activityInfoDic[arg_3_1] = var_3_0
	end

	var_3_0:setInfo(arg_3_2)
end

function var_0_0.getActivityInfo(arg_4_0, arg_4_1)
	return arg_4_0._activityInfoDic[arg_4_1]
end

function var_0_0.setBonusInfo(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 or not arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0:getActivityInfo(arg_5_1)

	if not var_5_0 then
		return
	end

	var_5_0:setBonusInfo(arg_5_2.pos, arg_5_2.id)
end

function var_0_0.setSPBonusInfo(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_0:getActivityInfo(arg_6_1)

	if not var_6_0 then
		return
	end

	var_6_0:setSPBonusInfo()
end

function var_0_0.addBonusTimes(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_0:getActivityInfo(arg_7_1)

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:getBonusTimes()

	var_7_0:setBonusTimes(var_7_1 + 1)
	Activity181Controller.instance:dispatchEvent(Activity181Event.BonusTimesChange, arg_7_1)
end

function var_0_0.isActivityInTime(arg_8_0, arg_8_1)
	local var_8_0 = ActivityModel.instance:getActMO(arg_8_1)

	if not var_8_0 then
		return false
	end

	if not var_8_0:isOpen() or var_8_0:isExpired() then
		return false
	end

	return true
end

function var_0_0.getHaveFirstDayLogin(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getDaliyLoginKey(arg_9_1)

	return TimeUtil.getDayFirstLoginRed(var_9_0)
end

function var_0_0.setHaveFirstDayLogin(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getDaliyLoginKey(arg_10_1)

	TimeUtil.setDayFirstLoginRed(var_10_0)
end

function var_0_0.getDaliyLoginKey(arg_11_0, arg_11_1)
	return PlayerPrefsKey.Version2_4_Act181FirstOpen .. tostring(arg_11_1)
end

function var_0_0.setPopUpPauseState(arg_12_0, arg_12_1)
	arg_12_0._popUpState = arg_12_1

	PopupController.instance:setPause("Activity181MainView_bonus", arg_12_1)
end

function var_0_0.getPopUpPauseState(arg_13_0)
	return arg_13_0._popUpState
end

var_0_0.instance = var_0_0.New()

return var_0_0
