module("modules.logic.sp01.assassinChase.model.AssassinChaseInfoMo", package.seeall)

local var_0_0 = pureTable("AssassinChaseInfoMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.activityId = arg_1_1
	arg_1_0.hasChosenDirection = arg_1_2
	arg_1_0.chosenInfo = arg_1_3
	arg_1_0.optionDirections = arg_1_4

	local var_1_0 = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.ChangeDirectionTimeLimit)

	arg_1_0.nextDayChangeOffset = (tonumber(var_1_0.value) or 0) * TimeUtil.OneHourSecond

	arg_1_0:refreshTime()
end

function var_0_0.isSelect(arg_2_0)
	return arg_2_0.hasChosenDirection and arg_2_0.chosenInfo ~= nil
end

function var_0_0.refreshTime(arg_3_0)
	if arg_3_0:isSelect() then
		local var_3_0 = arg_3_0.nextDayChangeOffset
		local var_3_1 = TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
		local var_3_2 = arg_3_0.chosenInfo.directionGenTime / TimeUtil.OneSecondMilliSecond
		local var_3_3 = ServerTime.timeInLocal(var_3_2)
		local var_3_4 = var_3_3 - var_3_1 + TimeUtil.OneDaySecond + var_3_0

		arg_3_0.rewardTime, arg_3_0.changeEndTime = var_3_3 + TimeUtil.OneDaySecond, var_3_4
	end
end

function var_0_0.canGetBonus(arg_4_0)
	if not arg_4_0:isSelect() then
		return false
	end

	if arg_4_0.rewardTime == nil then
		return false
	end

	return ServerTime.now() >= arg_4_0.rewardTime
end

function var_0_0.canChangeDirection(arg_5_0)
	if not arg_5_0:isSelect() then
		return false
	end

	if arg_5_0.changeEndTime == nil then
		return false
	end

	return ServerTime.now() < arg_5_0.changeEndTime
end

function var_0_0.getCurState(arg_6_0)
	local var_6_0

	if arg_6_0:isSelect() == false then
		var_6_0 = AssassinChaseEnum.ViewState.Select
	elseif arg_6_0.chosenInfo and arg_6_0.chosenInfo.rewardId ~= nil and arg_6_0.chosenInfo.rewardId ~= 0 then
		var_6_0 = AssassinChaseEnum.ViewState.Result
	else
		var_6_0 = AssassinChaseEnum.ViewState.Progress
	end

	return var_6_0
end

return var_0_0
