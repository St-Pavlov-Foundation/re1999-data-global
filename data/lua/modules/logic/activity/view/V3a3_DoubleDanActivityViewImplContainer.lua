module("modules.logic.activity.view.V3a3_DoubleDanActivityViewImplContainer", package.seeall)

local var_0_0 = class("V3a3_DoubleDanActivityViewImplContainer", BaseViewContainer)

function var_0_0.actId(arg_1_0)
	return assert(arg_1_0.viewParam.actId, "please pass viewParam.actId!!")
end

function var_0_0.getDayCO(arg_2_0, arg_2_1)
	return ActivityType101Config.instance:getDayCO(arg_2_0:actId(), arg_2_1)
end

function var_0_0.getSignMaxDay(arg_3_0)
	return ActivityType101Config.instance:getSignMaxDay(arg_3_0:actId())
end

function var_0_0.getDayBonusList(arg_4_0, arg_4_1)
	arg_4_0.__cacheBonusList = arg_4_0.__cacheBonusList or {}

	if arg_4_0.__cacheBonusList[arg_4_1] then
		return arg_4_0.__cacheBonusList[arg_4_1]
	end

	local var_4_0 = ActivityType101Config.instance:getDayBonusList(arg_4_0:actId(), arg_4_1)

	arg_4_0.__cacheBonusList[arg_4_1] = var_4_0

	return var_4_0
end

function var_0_0.isType101RewardGet(arg_5_0, arg_5_1)
	return ActivityType101Model.instance:isType101RewardGet(arg_5_0:actId(), arg_5_1)
end

function var_0_0.isType101RewardCouldGet(arg_6_0, arg_6_1)
	return ActivityType101Model.instance:isType101RewardCouldGet(arg_6_0:actId(), arg_6_1)
end

function var_0_0.getFirstAvailableIndex(arg_7_0)
	return ActivityType101Model.instance:getFirstAvailableIndex(arg_7_0:actId())
end

function var_0_0.isDayOpen(arg_8_0, arg_8_1)
	return ActivityType101Model.instance:isDayOpen(arg_8_0:actId(), arg_8_1)
end

function var_0_0.getType101LoginCount(arg_9_0)
	return ActivityType101Model.instance:getType101LoginCount(arg_9_0:actId())
end

function var_0_0.sendGet101BonusRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return Activity101Rpc.instance:sendGet101BonusRequest(arg_10_0:actId(), arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.getRemainTimeStr(arg_11_0)
	local var_11_0 = arg_11_0:getRemainTimeSec()

	if var_11_0 <= 0 then
		return luaLang("turnback_end")
	end

	local var_11_1, var_11_2, var_11_3, var_11_4 = TimeUtil.secondsToDDHHMMSS(var_11_0)

	if var_11_1 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_11_1,
			var_11_2
		})
	elseif var_11_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_11_2,
			var_11_3
		})
	elseif var_11_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			var_11_3
		})
	elseif var_11_4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function var_0_0.getRemainTimeSec(arg_12_0)
	local var_12_0 = arg_12_0:actId()

	return ActivityModel.instance:getRemainTimeSec(var_12_0) or 0
end

function var_0_0.getSkinCo(arg_13_0)
	local var_13_0 = ActivityType101Config.instance:getDoubleDanSkinId()

	return SkinConfig.instance:getSkinCo(var_13_0)
end

function var_0_0.getSkinCo_characterId(arg_14_0)
	local var_14_0 = arg_14_0:getSkinCo()

	if not var_14_0 then
		return 0
	end

	return var_14_0.characterId
end

function var_0_0.getHeroCO(arg_15_0)
	return HeroConfig.instance:getHeroCO(arg_15_0:getSkinCo_characterId())
end

function var_0_0.getActivityCo(arg_16_0)
	return ActivityConfig.instance:getActivityCo(arg_16_0:actId())
end

return var_0_0
