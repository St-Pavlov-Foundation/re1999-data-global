module("modules.logic.versionactivity2_3.act174.model.Act174MO", package.seeall)

local var_0_0 = pureTable("Act174MO")

function var_0_0.initBadgeInfo(arg_1_0, arg_1_1)
	arg_1_0.badgeMoDic = {}
	arg_1_0.badgeScoreChangeDic = {}

	local var_1_0 = lua_activity174_badge.configDict[arg_1_1]

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		local var_1_1 = Act174BadgeMO.New()

		var_1_1:init(iter_1_1)

		arg_1_0.badgeMoDic[iter_1_0] = var_1_1
	end
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.triggerList = {}
	arg_2_0.season = arg_2_1.season

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.badgeInfoList) do
		arg_2_0.badgeMoDic[iter_2_1.id]:update(iter_2_1)
	end

	arg_2_0:updateGameInfo(arg_2_1.gameInfo)
	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateBadgeMo)
end

function var_0_0.updateGameInfo(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.gameInfo then
		arg_3_0.gameInfo = Act174GameMO.New()
	end

	arg_3_0.gameInfo:init(arg_3_1, arg_3_2)
end

function var_0_0.updateShopInfo(arg_4_0, arg_4_1)
	arg_4_0.gameInfo:updateShopInfo(arg_4_1)
end

function var_0_0.updateTeamInfo(arg_5_0, arg_5_1)
	arg_5_0.gameInfo:updateTeamMo(arg_5_1)
end

function var_0_0.updateIsBet(arg_6_0, arg_6_1)
	arg_6_0.gameInfo:updateIsBet(arg_6_1)
end

function var_0_0.triggerEffectPush(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.triggerList[#arg_7_0.triggerList + 1] = {
		effectId = arg_7_1,
		param = arg_7_2
	}
end

function var_0_0.getTriggerList(arg_8_0)
	return arg_8_0.triggerList
end

function var_0_0.cleanTriggerEffect(arg_9_0)
	tabletool.clear(arg_9_0.triggerList)
end

function var_0_0.setEndInfo(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1.badgeInfoList) do
		local var_10_0 = iter_10_1.id
		local var_10_1 = arg_10_0.badgeMoDic[var_10_0]

		arg_10_0.badgeScoreChangeDic[var_10_0] = iter_10_1.count - var_10_1.count

		arg_10_0.badgeMoDic[var_10_0]:update(iter_10_1)
	end

	arg_10_0.gameEndInfo = arg_10_1

	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateBadgeMo)
end

function var_0_0.getBadgeScoreChangeDic(arg_11_0)
	return arg_11_0.badgeScoreChangeDic
end

function var_0_0.clearEndInfo(arg_12_0)
	arg_12_0.gameEndInfo = nil

	tabletool.clear(arg_12_0.badgeScoreChangeDic)
	arg_12_0:cleanTriggerEffect()
end

function var_0_0.getGameInfo(arg_13_0)
	return arg_13_0.gameInfo
end

function var_0_0.getGameEndInfo(arg_14_0)
	return arg_14_0.gameEndInfo
end

function var_0_0.getBadgeMo(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.badgeMoDic[arg_15_1]

	if not var_15_0 then
		logError("dont exist badgeMo" .. arg_15_1)
	end

	return var_15_0
end

function var_0_0.getBadgeMoList(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.badgeMoDic) do
		var_16_0[#var_16_0 + 1] = iter_16_1
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0.id < arg_17_1.id
	end)

	return var_16_0
end

function var_0_0.getRuleHeroCoList(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = lua_activity174_role.configList

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if string.find(iter_18_1.season, tostring(arg_18_0.season)) then
			var_18_0[#var_18_0 + 1] = iter_18_1
		end
	end

	return var_18_0
end

function var_0_0.getRuleCollectionCoList(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = lua_activity174_collection.configList

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if string.find(iter_19_1.season, tostring(arg_19_0.season)) then
			var_19_0[#var_19_0 + 1] = iter_19_1
		end
	end

	return var_19_0
end

function var_0_0.getRuleBuffCoList(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = lua_activity174_enhance.configList

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if string.find(iter_20_1.season, tostring(arg_20_0.season)) then
			var_20_0[#var_20_0 + 1] = iter_20_1
		end
	end

	return var_20_0
end

return var_0_0
