module("modules.logic.versionactivity2_5.challenge.model.Act183EpisodeMO", package.seeall)

local var_0_0 = pureTable("Act183EpisodeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._episodeId = arg_1_1.episodeId
	arg_1_0._isPass = tonumber(arg_1_1.status) == 1
	arg_1_0._passOrder = arg_1_1.passOrder or 0
	arg_1_0._heroes = Act183Helper.rpcInfosToList(arg_1_1.heroes, Act183HeroMO)
	arg_1_0._useBadgeNum = arg_1_1.useBadgeNum
	arg_1_0._unlockConditions = {}

	tabletool.addValues(arg_1_0._unlockConditions, arg_1_1.unlockConditions)

	arg_1_0._chooseConditions = {}

	tabletool.addValues(arg_1_0._chooseConditions, arg_1_1.chooseConditions)

	arg_1_0._repress = Act183RepressMO.New()

	arg_1_0._repress:init(arg_1_1.repress)

	arg_1_0._config = Act183Config.instance:getEpisodeCo(arg_1_0._episodeId)
	arg_1_0._groupId = arg_1_0._config and arg_1_0._config.groupId
	arg_1_0._params = arg_1_1.params
	arg_1_0._star = arg_1_1.star
	arg_1_0._totalStarCount = Act183Helper.calcEpisodeTotalConditionCount(arg_1_0._episodeId)

	arg_1_0:_buildEscapeRules()
end

function var_0_0._buildEscapeRules(arg_2_0)
	local var_2_0 = arg_2_0._config and arg_2_0._config.ruleDesc1
	local var_2_1 = arg_2_0._config and arg_2_0._config.ruleDesc2

	arg_2_0._escapeRules = {}

	local var_2_2 = arg_2_0._repress:getRuleIndex()

	if var_2_2 ~= 1 then
		table.insert(arg_2_0._escapeRules, var_2_0)
	end

	if var_2_2 ~= 2 then
		table.insert(arg_2_0._escapeRules, var_2_1)
	end
end

function var_0_0.getEpisodeId(arg_3_0)
	return arg_3_0._episodeId
end

function var_0_0.getStatus(arg_4_0)
	if arg_4_0._isPass then
		return Act183Enum.EpisodeStatus.Finished
	end

	local var_4_0 = arg_4_0:getPreEpisodeIds()

	if var_4_0 then
		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			local var_4_1 = Act183Model.instance:getEpisodeMo(arg_4_0._groupId, iter_4_1)

			if var_4_1 then
				if not var_4_1:isFinished() then
					return Act183Enum.EpisodeStatus.Locked
				end
			else
				logError(string.format("前置关卡不存在 curEpisodeId = %s, preEpisodeId = %s", arg_4_0._episodeId, iter_4_1))
			end
		end
	end

	return Act183Enum.EpisodeStatus.Unlocked
end

function var_0_0.getPreEpisodeIds(arg_5_0)
	if arg_5_0._config and not string.nilorempty(arg_5_0._config.preEpisodeIds) then
		return string.splitToNumber(arg_5_0._config.preEpisodeIds, "#")
	end
end

function var_0_0.isLocked(arg_6_0)
	return arg_6_0:getStatus() == Act183Enum.EpisodeStatus.Locked
end

function var_0_0.isFinished(arg_7_0)
	return arg_7_0:getStatus() == Act183Enum.EpisodeStatus.Finished
end

function var_0_0.getPassConditions(arg_8_0)
	return arg_8_0._unlockConditions
end

function var_0_0.getConfig(arg_9_0)
	return arg_9_0._config
end

function var_0_0.getEpisodeType(arg_10_0)
	return Act183Helper.getEpisodeType(arg_10_0._episodeId)
end

function var_0_0.getGroupType(arg_11_0)
	return arg_11_0._config and arg_11_0._config.type
end

function var_0_0.getRepressMo(arg_12_0)
	return arg_12_0._repress
end

function var_0_0.updateRepressMo(arg_13_0, arg_13_1)
	if not arg_13_0._repress then
		arg_13_0._repress = Act183RepressMO.New()
	end

	arg_13_0._repress:init(arg_13_1)
	arg_13_0:_buildEscapeRules()
end

function var_0_0.getRuleStatus(arg_14_0, arg_14_1)
	if arg_14_0:getStatus() ~= Act183Enum.EpisodeStatus.Finished then
		return Act183Enum.RuleStatus.Enabled
	end

	if arg_14_0._repress:getRuleIndex() == arg_14_1 then
		return Act183Enum.RuleStatus.Repress
	end

	return Act183Enum.RuleStatus.Escape
end

function var_0_0.getPassOrder(arg_15_0)
	return arg_15_0._passOrder
end

function var_0_0.getConfigOrder(arg_16_0)
	return arg_16_0._config.order
end

function var_0_0.getConditionIds(arg_17_0)
	if arg_17_0._config then
		return string.splitToNumber(arg_17_0._config.condition, "#")
	end
end

function var_0_0.isConditionPass(arg_18_0, arg_18_1)
	if arg_18_0._unlockConditions then
		return tabletool.indexOf(arg_18_0._unlockConditions, arg_18_1) ~= nil
	end
end

function var_0_0.isAllConditionPass(arg_19_0)
	if arg_19_0:getStatus() ~= Act183Enum.EpisodeStatus.Finished then
		return false
	end

	local var_19_0 = string.splitToNumber(arg_19_0._config.condition, "#")

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if not arg_19_0:isConditionPass(iter_19_1) then
			return false
		end
	end

	return true
end

function var_0_0.getEscapeRules(arg_20_0)
	return arg_20_0._escapeRules
end

function var_0_0.getUseBadgeNum(arg_21_0)
	return arg_21_0._useBadgeNum
end

function var_0_0.getHeroes(arg_22_0)
	return arg_22_0._heroes
end

function var_0_0.getRepressHeroMo(arg_23_0)
	if arg_23_0._repress:hasRepress() then
		local var_23_0 = arg_23_0._repress:getHeroIndex()

		return arg_23_0._heroes[var_23_0]
	end
end

function var_0_0.isHeroRepress(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getRepressHeroMo()

	if var_24_0 then
		return var_24_0:getHeroId() == arg_24_1
	end
end

function var_0_0.setSelectConditions(arg_25_0, arg_25_1)
	arg_25_0._selectConditionIds = arg_25_1
end

function var_0_0.getGroupId(arg_26_0)
	return arg_26_0._groupId
end

function var_0_0.getFinishStarCount(arg_27_0)
	return arg_27_0._star
end

function var_0_0.getTotalStarCount(arg_28_0)
	return arg_28_0._totalStarCount
end

return var_0_0
