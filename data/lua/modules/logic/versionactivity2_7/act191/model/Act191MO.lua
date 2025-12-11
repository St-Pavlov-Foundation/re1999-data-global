module("modules.logic.versionactivity2_7.act191.model.Act191MO", package.seeall)

local var_0_0 = pureTable("Act191MO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.triggerEffectPushList = {}
end

function var_0_0.initBadgeInfo(arg_2_0, arg_2_1)
	arg_2_0.badgeMoDic = {}
	arg_2_0.badgeScoreChangeDic = {}

	local var_2_0 = lua_activity191_badge.configDict[arg_2_1]

	if var_2_0 then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			local var_2_1 = Act191BadgeMO.New()

			var_2_1:init(iter_2_1)

			arg_2_0.badgeMoDic[iter_2_0] = var_2_1
		end
	end
end

function var_0_0.init(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.badgeInfoList) do
		arg_3_0.badgeMoDic[iter_3_1.id]:update(iter_3_1)
	end

	arg_3_0.gameInfo = Act191GameMO.New()

	arg_3_0.gameInfo:init(arg_3_1.gameInfo)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateBadgeMo)
end

function var_0_0.updateGameInfo(arg_4_0, arg_4_1)
	arg_4_0.gameInfo:update(arg_4_1)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateGameInfo)
end

function var_0_0.getGameInfo(arg_5_0)
	return arg_5_0.gameInfo
end

function var_0_0.triggerEffectPush(arg_6_0, arg_6_1)
	arg_6_0.triggerEffectPushList[#arg_6_0.triggerEffectPushList + 1] = arg_6_1
end

function var_0_0.clearTriggerEffectPush(arg_7_0)
	tabletool.clear(arg_7_0.triggerEffectPushList)
end

function var_0_0.getGameEndInfo(arg_8_0)
	return arg_8_0.gameEndInfo
end

function var_0_0.setEnfInfo(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1.badgeInfoList) do
		local var_9_0 = iter_9_1.id
		local var_9_1 = arg_9_0.badgeMoDic[var_9_0]

		arg_9_0.badgeScoreChangeDic[var_9_0] = iter_9_1.count - var_9_1.count

		arg_9_0.badgeMoDic[var_9_0]:update(iter_9_1)
	end

	arg_9_0.gameEndInfo = arg_9_1

	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateBadgeMo)
end

function var_0_0.getBadgeScoreChangeDic(arg_10_0)
	return arg_10_0.badgeScoreChangeDic
end

function var_0_0.clearEndInfo(arg_11_0)
	arg_11_0.gameEndInfo = nil

	tabletool.clear(arg_11_0.badgeScoreChangeDic)
	arg_11_0:clearTriggerEffectPush()
end

function var_0_0.getBadgeMoList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.badgeMoDic) do
		var_12_0[#var_12_0 + 1] = iter_12_1
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return arg_13_0.id < arg_13_1.id
	end)

	return var_12_0
end

return var_0_0
