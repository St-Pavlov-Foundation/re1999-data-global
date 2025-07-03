module("modules.logic.versionactivity2_5.challenge.model.Act183EpisodeRecordMO", package.seeall)

local var_0_0 = pureTable("Act183EpisodeRecordMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._episodeId = arg_1_1.episodeId
	arg_1_0._passOrder = arg_1_1.passOrder
	arg_1_0._heroes = Act183Helper.rpcInfosToList(arg_1_1.heroes, Act183HeroMO)
	arg_1_0._useBadgeNum = arg_1_1.useBadgeNum
	arg_1_0._passConditions = {}

	tabletool.addValues(arg_1_0._passConditions, arg_1_1.unlockConditions)

	arg_1_0._chooseConditions = {}

	tabletool.addValues(arg_1_0._chooseConditions, arg_1_1.chooseConditions)

	arg_1_0._repress = Act183RepressMO.New()

	arg_1_0._repress:init(arg_1_1.repress)

	arg_1_0._config = Act183Config.instance:getEpisodeCo(arg_1_0._episodeId)
	arg_1_0._params = arg_1_1.params
	arg_1_0._star = arg_1_1.star
	arg_1_0._totalStarCount = Act183Helper.calcEpisodeTotalConditionCount(arg_1_0._episodeId)
end

function var_0_0.getConfig(arg_2_0)
	return arg_2_0._config
end

function var_0_0.getEpisodeId(arg_3_0)
	return arg_3_0._episodeId
end

function var_0_0.getPassOrder(arg_4_0)
	return arg_4_0._passOrder
end

function var_0_0.getUseBadgeNum(arg_5_0)
	return arg_5_0._useBadgeNum
end

function var_0_0.getHeroMos(arg_6_0)
	return arg_6_0._heroes
end

function var_0_0.getEpisodeType(arg_7_0)
	return Act183Helper.getEpisodeType(arg_7_0._episodeId)
end

function var_0_0.getGroupType(arg_8_0)
	return arg_8_0._config and arg_8_0._config.type
end

function var_0_0.getConditionIds(arg_9_0)
	if arg_9_0._config then
		return string.splitToNumber(arg_9_0._config.condition, "#")
	end
end

function var_0_0.getPassConditions(arg_10_0)
	return arg_10_0._passConditions
end

function var_0_0.getChooseConditions(arg_11_0)
	return arg_11_0._chooseConditions
end

function var_0_0.isConditionPass(arg_12_0, arg_12_1)
	if arg_12_0._passConditions then
		return tabletool.indexOf(arg_12_0._passConditions, arg_12_1) ~= nil
	end
end

function var_0_0.getAllConditions(arg_13_0)
	return (string.splitToNumber(arg_13_0._config.condition, "#"))
end

function var_0_0.isAllConditionPass(arg_14_0)
	local var_14_0 = arg_14_0:getAllConditions()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if not arg_14_0:isConditionPass(iter_14_1) then
			return false
		end
	end

	return true
end

function var_0_0.getRuleStatus(arg_15_0, arg_15_1)
	if arg_15_0._repress:getRuleIndex() == arg_15_1 then
		return Act183Enum.RuleStatus.Repress
	end

	return Act183Enum.RuleStatus.Escape
end

function var_0_0.getFinishStarCount(arg_16_0)
	return arg_16_0._star
end

function var_0_0.getTotalStarCount(arg_17_0)
	return arg_17_0._totalStarCount
end

return var_0_0
