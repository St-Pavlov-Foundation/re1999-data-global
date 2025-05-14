module("modules.logic.versionactivity1_2.jiexika.system.Activity114Helper", package.seeall)

local var_0_0 = pureTable("Activity114Helper")

function var_0_0.getEventCoByBattleId(arg_1_0)
	local var_1_0 = Activity114Model.instance.serverData.battleEventId

	if var_1_0 > 0 then
		local var_1_1 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, var_1_0)

		if var_1_1 and var_1_1.config.battleId == arg_1_0 then
			return var_1_1
		end
	end

	return false
end

function var_0_0.haveAttrOrFeatureChange(arg_2_0)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		return false
	end

	if arg_2_0.resultBonus then
		return true
	end

	local var_2_0 = arg_2_0.result

	if var_2_0 == nil then
		var_2_0 = Activity114Enum.Result.Success
	end

	if var_2_0 == Activity114Enum.Result.None then
		return false
	end

	local var_2_1 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, arg_2_0.eventId)

	if not var_2_1 then
		return false
	end

	local var_2_2

	if var_2_0 == Activity114Enum.Result.Success or arg_2_0.type == Activity114Enum.EventType.Rest then
		var_2_2 = var_2_1.successFeatures
	elseif var_2_0 == Activity114Enum.Result.FightSucess then
		var_2_2 = var_2_1.successBattleFeatures
	else
		var_2_2 = var_2_1.failureFeatures
	end

	local var_2_3

	if var_2_0 == Activity114Enum.Result.Success or arg_2_0.type == Activity114Enum.EventType.Rest then
		var_2_3 = var_2_1.successVerify
	elseif var_2_0 == Activity114Enum.Result.FightSucess then
		var_2_3 = var_2_1.successBattleVerify
	else
		var_2_3 = var_2_1.failureVerify
	end

	var_2_3[Activity114Enum.AddAttrType.UnLockMeet] = nil
	var_2_3[Activity114Enum.AddAttrType.UnLockTravel] = nil

	if next(Activity114Model.instance.newUnLockFeature) then
		var_2_2 = Activity114Model.instance.newUnLockFeature
	else
		var_2_2 = {}
	end

	if next(Activity114Model.instance.newUnLockMeeting) then
		var_2_3[Activity114Enum.AddAttrType.UnLockMeet] = Activity114Model.instance.newUnLockMeeting
	end

	if next(Activity114Model.instance.newUnLockTravel) then
		var_2_3[Activity114Enum.AddAttrType.UnLockTravel] = Activity114Model.instance.newUnLockTravel
	end

	if next(var_2_3) or next(var_2_2) then
		arg_2_0.resultBonus = {
			addAttr = var_2_3,
			featuresList = var_2_2
		}

		return true
	end

	return false
end

function var_0_0.getNextKeyDayDesc(arg_3_0)
	arg_3_0 = arg_3_0 or Activity114Model.instance.serverData.day

	local var_3_0 = Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, arg_3_0)

	if var_3_0 then
		return var_3_0.desc
	end

	return ""
end

function var_0_0.getNextKeyDayLeft(arg_4_0)
	arg_4_0 = arg_4_0 or Activity114Model.instance.serverData.day

	local var_4_0 = Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, arg_4_0)

	if var_4_0 then
		return var_4_0.day - arg_4_0
	end

	return 0
end

function var_0_0.getWeekEndScore()
	local var_5_0 = 0

	for iter_5_0 = 1, Activity114Enum.Attr.End - 1 do
		var_5_0 = var_5_0 + Activity114Model.instance.attrDict[iter_5_0] or 0
	end

	local var_5_1 = Activity114Model.instance.serverData.middleScore
	local var_5_2 = Activity114Model.instance.serverData.endScore
	local var_5_3 = var_5_0 + var_5_1 + var_5_2

	return var_5_0, var_5_1, var_5_2, var_5_3
end

return var_0_0
