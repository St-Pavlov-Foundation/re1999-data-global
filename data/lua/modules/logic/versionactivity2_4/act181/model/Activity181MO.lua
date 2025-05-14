module("modules.logic.versionactivity2_4.act181.model.Activity181MO", package.seeall)

local var_0_0 = pureTable("Activity181MO")

function var_0_0.setInfo(arg_1_0, arg_1_1)
	arg_1_0.config = Activity181Config.instance:getBoxConfig(arg_1_1.activityId)
	arg_1_0.id = arg_1_1.activityId
	arg_1_0.rewardInfo = {}
	arg_1_0.bonusIdDic = {}
	arg_1_0.getBonusCount = 0
	arg_1_0.allBonusCount = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.infos) do
		arg_1_0.rewardInfo[iter_1_1.pos] = iter_1_1.id
		arg_1_0.bonusIdDic[iter_1_1.id] = iter_1_1.pos

		if iter_1_1.pos ~= 0 then
			arg_1_0.getBonusCount = arg_1_0.getBonusCount + 1
		end
	end

	arg_1_0.allBonusCount = #Activity181Config.instance:getBoxListByActivityId(arg_1_0.id)
	arg_1_0.canGetTimes = arg_1_1.canGetTimes

	if arg_1_0.rewardInfo[0] ~= nil then
		arg_1_0.spBonusState = Activity181Enum.SPBonusState.HaveGet
	else
		arg_1_0.spBonusState = arg_1_1.canGetSpBonus
	end
end

function var_0_0.setBonusInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.rewardInfo[arg_2_1] = arg_2_2
	arg_2_0.bonusIdDic[arg_2_2] = arg_2_1
	arg_2_0.getBonusCount = arg_2_0.getBonusCount + 1

	arg_2_0:setBonusTimes(math.max(0, arg_2_0.canGetTimes - 1))

	if arg_2_0.spBonusState == Activity181Enum.SPBonusState.Locked and arg_2_0:getSPUnlockState() then
		arg_2_0.spBonusState = Activity181Enum.SPBonusState.Unlock
	end
end

function var_0_0.refreshSpBonusInfo(arg_3_0)
	if arg_3_0.spBonusState ~= Activity181Enum.SPBonusState.HaveGet then
		arg_3_0.spBonusState = arg_3_0:getSPUnlockState() and Activity181Enum.SPBonusState.Unlock or Activity181Enum.SPBonusState.Locked

		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetSPBonus, arg_3_0.id)
	end
end

function var_0_0.getBonusState(arg_4_0, arg_4_1)
	if arg_4_0.rewardInfo[arg_4_1] then
		return Activity181Enum.BonusState.HaveGet
	end

	return Activity181Enum.BonusState.Unlock
end

function var_0_0.getBonusIdByPos(arg_5_0, arg_5_1)
	return arg_5_0.rewardInfo[arg_5_1]
end

function var_0_0.getBonusStateById(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.bonusIdDic[arg_6_1]

	return arg_6_0:getBonusState(var_6_0)
end

function var_0_0.setSPBonusInfo(arg_7_0)
	arg_7_0.spBonusState = Activity181Enum.SPBonusState.HaveGet
	arg_7_0.rewardInfo[0] = 0
	arg_7_0.bonusIdDic[0] = 0
end

function var_0_0.getSPUnlockState(arg_8_0)
	local var_8_0 = arg_8_0.config

	if var_8_0.obtainType == Activity181Enum.SPBonusUnlockType.Time then
		return arg_8_0:isSpBonusTimeUnlock(var_8_0)
	elseif var_8_0.obtainType == Activity181Enum.SPBonusUnlockType.Count then
		return arg_8_0:isSpBonusCountUnlock(var_8_0)
	else
		return arg_8_0:isSpBonusTimeUnlock(var_8_0) or arg_8_0:isSpBonusCountUnlock(var_8_0)
	end
end

function var_0_0.isSpBonusTimeUnlock(arg_9_0, arg_9_1)
	local var_9_0 = ServerTime.now()
	local var_9_1 = TimeUtil.stringToTimestamp(arg_9_1.obtainStart)
	local var_9_2 = TimeUtil.stringToTimestamp(arg_9_1.obtainEnd)

	return var_9_1 <= var_9_0 and var_9_0 <= var_9_2
end

function var_0_0.isSpBonusCountUnlock(arg_10_0, arg_10_1)
	return arg_10_0.getBonusCount >= arg_10_1.obtainTimes
end

function var_0_0.getBonusTimes(arg_11_0)
	return arg_11_0.canGetTimes
end

function var_0_0.setBonusTimes(arg_12_0, arg_12_1)
	arg_12_0.canGetTimes = arg_12_1
end

function var_0_0.canGetBonus(arg_13_0)
	return arg_13_0.getBonusCount < arg_13_0.allBonusCount
end

return var_0_0
