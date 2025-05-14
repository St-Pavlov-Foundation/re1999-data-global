module("modules.logic.versionactivity2_0.dungeon.config.Activity161Config", package.seeall)

local var_0_0 = class("Activity161Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._activity161GraffitiConfig = nil
	arg_1_0._activity161RewardConfig = nil
	arg_1_0._activity161DialogConfig = nil
	arg_1_0._activity161ChessConfig = nil
	arg_1_0.graffitiPicList = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity161_graffiti",
		"activity161_reward",
		"activity161_graffiti_event",
		"activity161_graffiti_dialog",
		"activity161_graffiti_chess"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity161_graffiti" then
		arg_3_0._activity161GraffitiConfig = arg_3_2
	elseif arg_3_1 == "activity161_reward" then
		arg_3_0._activity161RewardConfig = arg_3_2
	elseif arg_3_1 == "activity161_graffiti_dialog" then
		arg_3_0._activity161DialogConfig = arg_3_2
	elseif arg_3_1 == "activity161_graffiti_chess" then
		arg_3_0._activity161ChessConfig = arg_3_2
	end
end

function var_0_0.getAllGraffitiCo(arg_4_0, arg_4_1)
	return arg_4_0._activity161GraffitiConfig.configDict[arg_4_1]
end

function var_0_0.getGraffitiCo(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0._activity161GraffitiConfig.configDict[arg_5_1][arg_5_2]
end

function var_0_0.getGraffitiCount(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getAllGraffitiCo(arg_6_1)

	return GameUtil.getTabLen(var_6_0)
end

function var_0_0.getAllRewardCos(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = arg_7_0._activity161RewardConfig.configDict[arg_7_1]

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		table.insert(var_7_0, iter_7_1)
	end

	table.sort(var_7_0, var_0_0.sortReward)

	return var_7_0
end

function var_0_0.sortReward(arg_8_0, arg_8_1)
	return arg_8_0.rewardId < arg_8_1.rewardId
end

function var_0_0.getRewardCo(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0._activity161RewardConfig.configDict[arg_9_1][arg_9_2]
end

function var_0_0.getFinalReward(arg_10_0, arg_10_1)
	local var_10_0 = tabletool.copy(arg_10_0:getAllRewardCos(arg_10_1))
	local var_10_1 = var_10_0[#var_10_0]
	local var_10_2 = GameUtil.splitString2(var_10_1.bonus, true)
	local var_10_3 = table.remove(var_10_2, #var_10_2)

	return var_10_2, var_10_3
end

function var_0_0.getUnlockCondition(arg_11_0, arg_11_1)
	local var_11_0 = DungeonConfig.instance:getChapterMapElement(arg_11_1)
	local var_11_1
	local var_11_2
	local var_11_3

	if not string.nilorempty(var_11_0.condition) then
		var_11_1 = arg_11_0:extractConditionValue(var_11_0.condition, "EpisodeFinish")
		var_11_2 = arg_11_0:extractConditionValue(var_11_0.condition, "ChapterMapElement")
		var_11_3 = arg_11_0:extractConditionValue(var_11_0.condition, "Act161CdFinish")
	end

	return var_11_1, var_11_2, var_11_3
end

function var_0_0.extractConditionValue(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2 .. "=(%d+)"

	return string.match(arg_12_1, var_12_0) or nil
end

function var_0_0.getAllDialogMapCoByGraoupId(arg_13_0, arg_13_1)
	return arg_13_0._activity161DialogConfig.configDict[arg_13_1]
end

function var_0_0.getDialogConfig(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0._activity161DialogConfig.configDict[arg_14_1][arg_14_2]
end

function var_0_0.getChessConfig(arg_15_0, arg_15_1)
	return arg_15_0._activity161ChessConfig.configDict[arg_15_1]
end

function var_0_0.getGraffitiRelevantElementMap(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getAllGraffitiCo(arg_16_1)
	local var_16_1 = {}
	local var_16_2 = {}

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_3 = {}

		if not string.nilorempty(iter_16_1.subElementIds) then
			local var_16_4 = string.splitToNumber(iter_16_1.subElementIds, "#")

			for iter_16_2, iter_16_3 in pairs(var_16_4) do
				var_16_1[iter_16_3] = iter_16_1
			end
		end

		if not string.nilorempty(iter_16_1.mainElementId) then
			var_16_2[iter_16_1.mainElementId] = iter_16_1
		end
	end

	return var_16_1, var_16_2
end

function var_0_0.getGraffitiRelevantElement(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getGraffitiCo(arg_17_1, arg_17_2)
	local var_17_1 = {}

	if not string.nilorempty(var_17_0.subElementIds) then
		var_17_1 = string.splitToNumber(var_17_0.subElementIds, "#")
	end

	return var_17_1
end

function var_0_0.isPreMainElementFinish(arg_18_0, arg_18_1)
	local var_18_0 = string.splitToNumber(arg_18_1.preMainElementIds, "#") or {}

	if #var_18_0 == 0 then
		return true
	end

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if not DungeonMapModel.instance:elementIsFinished(iter_18_1) then
			return false
		end
	end

	return true
end

function var_0_0.initGraffitiPicMap(arg_19_0, arg_19_1)
	if #arg_19_0.graffitiPicList == 0 then
		local var_19_0 = arg_19_0:getAllGraffitiCo(arg_19_1)

		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			table.insert(arg_19_0.graffitiPicList, iter_19_1)
		end

		table.sort(arg_19_0.graffitiPicList, arg_19_0.sortGraffitiPic)
	end
end

function var_0_0.sortGraffitiPic(arg_20_0, arg_20_1)
	return arg_20_0.sort < arg_20_1.sort
end

function var_0_0.checkIsGraffitiMainElement(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getAllGraffitiCo(arg_21_1)

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		if iter_21_1.mainElementId == arg_21_2 then
			return true, iter_21_1
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
