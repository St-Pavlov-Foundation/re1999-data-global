module("modules.logic.versionactivity2_5.challenge.model.Act183GroupEpisodeMO", package.seeall)

local var_0_0 = pureTable("Act183GroupEpisodeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._groupId = arg_1_1.groupId
	arg_1_0._finished = arg_1_1.finished

	arg_1_0:_onGetEpisodeList(arg_1_1.episodeList)
end

function var_0_0._onGetEpisodeList(arg_2_0, arg_2_1)
	arg_2_0._episodeList = {}
	arg_2_0._episodeMap = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = Act183EpisodeMO.New()

		var_2_0:init(iter_2_1)
		table.insert(arg_2_0._episodeList, var_2_0)

		local var_2_1 = var_2_0:getEpisodeId()

		arg_2_0._episodeMap[var_2_1] = var_2_0
	end

	local var_2_2 = arg_2_0._episodeList[1]

	arg_2_0._groupType = var_2_2 and var_2_2:getGroupType()
	arg_2_0._episodeCount = arg_2_0._episodeList and #arg_2_0._episodeList or 0
end

function var_0_0.isHasFinished(arg_3_0)
	return arg_3_0._finished
end

function var_0_0.getEpisodeMos(arg_4_0)
	return arg_4_0._episodeList
end

function var_0_0.getGroupId(arg_5_0)
	return arg_5_0._groupId
end

function var_0_0.getGroupType(arg_6_0)
	return arg_6_0._groupType
end

function var_0_0.getStatus(arg_7_0)
	local var_7_0 = Act183Enum.GroupStatus.Locked

	if arg_7_0._groupType == Act183Enum.GroupType.Daily then
		local var_7_1 = arg_7_0:getUnlockRemainTime()

		if not var_7_1 or var_7_1 <= 0 then
			var_7_0 = Act183Enum.GroupStatus.Unlocked
		end
	elseif arg_7_0._groupType == Act183Enum.GroupType.NormalMain or arg_7_0._groupType == Act183Enum.GroupType.HardMain then
		var_7_0 = arg_7_0:isGroupFinished() and Act183Enum.GroupStatus.Finished or Act183Enum.GroupStatus.Unlocked
	else
		logError(string.format("挑战玩法获取关卡组状态失败  未定义关卡组类型 groupId = %s, groupType = %s", arg_7_0._groupId, arg_7_0._groupType))
	end

	return var_7_0
end

function var_0_0.isGroupFinished(arg_8_0)
	local var_8_0 = arg_8_0:getStatusEpisodes(Act183Enum.GroupStatus.Finished)

	return (var_8_0 and #var_8_0 or 0) >= arg_8_0._episodeCount
end

function var_0_0.getUnlockRemainTime(arg_9_0)
	return Act183Helper.getDailyGroupEpisodeUnlockRemainTime(arg_9_0._groupId) or 0
end

function var_0_0.getEpisodeCount(arg_10_0)
	return arg_10_0._episodeCount
end

function var_0_0.getEpisodeFinishCount(arg_11_0)
	local var_11_0 = arg_11_0:getStatusEpisodes(Act183Enum.EpisodeStatus.Finished)

	return var_11_0 and #var_11_0 or 0
end

function var_0_0.isAllSubEpisodeFinished(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._episodeList) do
		local var_12_0 = iter_12_1:getEpisodeType()
		local var_12_1 = iter_12_1:getStatus()

		if var_12_0 == Act183Enum.EpisodeType.Sub and var_12_1 ~= Act183Enum.EpisodeStatus.Finished then
			return false
		end
	end

	return true
end

function var_0_0.getAllPassConditionIds(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._episodeList) do
		if iter_13_1:isFinished() then
			tabletool.addValues(var_13_0, iter_13_1:getPassConditions())
		end
	end

	return var_13_0
end

function var_0_0.getTotalAndPassConditionIds(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getEpisodeMo(arg_14_1)
	local var_14_1 = arg_14_0:getPreEpisodeMos(arg_14_1)
	local var_14_2 = {
		var_14_0
	}

	tabletool.addValues(var_14_2, var_14_1)
	table.sort(var_14_2, arg_14_0._sortEpisodeByPassOrder)

	local var_14_3 = {}
	local var_14_4 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		local var_14_5 = iter_14_1:getConditionIds()
		local var_14_6 = iter_14_1:getPassConditions()

		tabletool.addValues(var_14_3, var_14_5)
		tabletool.addValues(var_14_4, var_14_6)
	end

	return var_14_3, var_14_4
end

function var_0_0.getEpisodeListByPassOrder(arg_15_0)
	local var_15_0 = tabletool.copy(arg_15_0._episodeList)

	table.sort(var_15_0, arg_15_0._sortEpisodeByPassOrder)

	return var_15_0
end

function var_0_0._sortEpisodeByPassOrder(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:isFinished()

	if var_16_0 ~= arg_16_1:isFinished() then
		return var_16_0
	end

	local var_16_1 = arg_16_0:getPassOrder()
	local var_16_2 = arg_16_1:getPassOrder()

	if var_16_1 ~= var_16_2 then
		return var_16_1 < var_16_2
	end

	local var_16_3 = arg_16_0:getConfig()
	local var_16_4 = arg_16_1:getConfig()
	local var_16_5 = var_16_3.order
	local var_16_6 = var_16_4.order

	if var_16_5 ~= var_16_6 then
		return var_16_5 < var_16_6
	end

	return arg_16_0:getEpisodeId() < arg_16_1:getEpisodeId()
end

function var_0_0.isConditionPass(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._episodeList) do
		if iter_17_1:isConditionPass(arg_17_1) then
			return true
		end
	end
end

function var_0_0.getPreEpisodeMos(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getEpisodeMo(arg_18_1)
	local var_18_1 = {}

	if var_18_0 then
		local var_18_2 = var_18_0:getPreEpisodeIds()

		if var_18_2 then
			for iter_18_0, iter_18_1 in ipairs(var_18_2) do
				local var_18_3 = arg_18_0:getEpisodeMo(iter_18_1)

				table.insert(var_18_1, var_18_3)
			end
		end
	end

	return var_18_1
end

function var_0_0.getConditionFinishCount(arg_19_0)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._episodeList) do
		local var_19_1 = iter_19_1:getPassConditions()

		var_19_0 = var_19_0 + (var_19_1 and #var_19_1 or 0)
	end

	return var_19_0
end

function var_0_0.getBossEpisodePassCount(arg_20_0)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._episodeList) do
		local var_20_1 = iter_20_1:getEpisodeType()
		local var_20_2 = iter_20_1:getStatus()

		if var_20_1 == Act183Enum.EpisodeType.Boss and var_20_2 == Act183Enum.EpisodeStatus.Finished then
			var_20_0 = var_20_0 + 1
		end
	end

	return var_20_0
end

function var_0_0.getEpisodeMo(arg_21_0, arg_21_1)
	return arg_21_0._episodeMap[arg_21_1]
end

function var_0_0.getEscapeRules(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getEpisodeMo(arg_22_1)

	if not var_22_0 then
		return
	end

	local var_22_1 = {}
	local var_22_2 = arg_22_0:getEpisodeListByPassOrder()

	for iter_22_0, iter_22_1 in ipairs(var_22_2) do
		if not iter_22_1:isFinished() then
			break
		end

		if iter_22_1:getEpisodeId() == var_22_0:getEpisodeId() then
			break
		end

		local var_22_3 = iter_22_1:getEscapeRules()

		if var_22_3 and #var_22_3 > 0 then
			for iter_22_2, iter_22_3 in ipairs(var_22_3) do
				if not string.nilorempty(iter_22_3) then
					local var_22_4 = {
						episodeId = iter_22_1:getEpisodeId(),
						ruleDesc = iter_22_3,
						ruleIndex = iter_22_2,
						passOrder = iter_22_1:getPassOrder()
					}

					table.insert(var_22_1, var_22_4)
				end
			end
		end
	end

	return var_22_1
end

function var_0_0.isEpisodeCanRestart(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getEpisodeMo(arg_23_1)

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0:isFinished()

	if var_23_0:getEpisodeType() == Act183Enum.EpisodeType.Boss and var_23_1 then
		return true
	end

	local var_23_2 = var_23_0:isSimulate()
	local var_23_3 = var_23_0:getPassOrder()
	local var_23_4 = arg_23_0:findMaxPassOrder()

	return var_23_1 and var_23_3 == var_23_4 and not var_23_2
end

function var_0_0.isEpisodeCanReset(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getEpisodeMo(arg_24_1)

	if not var_24_0 then
		return
	end

	if var_24_0:getEpisodeType() == Act183Enum.EpisodeType.Boss then
		return
	end

	local var_24_1 = var_24_0:getStatus()
	local var_24_2 = var_24_0:getPassOrder()
	local var_24_3 = var_24_0:isSimulate()
	local var_24_4 = arg_24_0:findMaxPassOrder()

	return var_24_1 == Act183Enum.EpisodeStatus.Finished and var_24_2 < var_24_4 and not var_24_3
end

function var_0_0.isCanStart(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getEpisodeMo(arg_25_1)

	if not var_25_0 then
		return
	end

	if var_25_0:getStatus() ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	local var_25_1 = var_25_0:getEpisodeType()

	if var_25_1 == Act183Enum.EpisodeType.Sub then
		return true
	elseif var_25_1 == Act183Enum.EpisodeType.Boss then
		return arg_25_0:isAllSubEpisodeFinished()
	end
end

function var_0_0.isEpisodeCanReRepress(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getEpisodeMo(arg_26_1)

	if not var_26_0 then
		return
	end

	if var_26_0:getEpisodeType() == Act183Enum.EpisodeType.Boss then
		return
	end

	local var_26_1 = var_26_0:getPassOrder()
	local var_26_2 = var_26_0:isFinished()
	local var_26_3 = arg_26_0:findMaxPassOrder()
	local var_26_4 = Act183Helper.isLastPassEpisodeInGroup(var_26_0)

	return var_26_2 and var_26_1 == var_26_3 and not var_26_4
end

function var_0_0.isHeroRepress(arg_27_0, arg_27_1, arg_27_2)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0._episodeList) do
		local var_27_0 = iter_27_1:isHeroRepress(arg_27_1)
		local var_27_1 = iter_27_1:getEpisodeId()

		if var_27_0 and (not arg_27_2 or arg_27_2 == var_27_1) then
			return true
		end
	end

	return false
end

function var_0_0.findMaxPassOrder(arg_28_0)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._episodeList) do
		if iter_28_1:isFinished() then
			local var_28_1 = iter_28_1:getPassOrder()

			if var_28_0 < var_28_1 then
				var_28_0 = var_28_1
			end
		end
	end

	return var_28_0
end

function var_0_0.isHeroRepressInPreEpisode(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:getEpisodeMo(arg_29_1)
	local var_29_1 = var_29_0:isFinished()
	local var_29_2 = var_29_0:getPassOrder()

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._episodeList) do
		if iter_29_1:isFinished() and (not var_29_1 or var_29_2 > iter_29_1:getPassOrder()) and iter_29_1:isHeroRepress(arg_29_2) then
			return true
		end
	end

	return false
end

function var_0_0.getStatusEpisodes(arg_30_0, arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._episodeList) do
		if arg_30_1 == iter_30_1:getStatus() then
			table.insert(var_30_0, iter_30_1)
		end
	end

	return var_30_0
end

function var_0_0.isAnySubEpisodeNotFinished(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0._episodeList) do
		if iter_31_1:getEpisodeType() == Act183Enum.EpisodeType.Sub and iter_31_1:getStatus() ~= Act183Enum.EpisodeStatus.Finished then
			return true
		end
	end
end

function var_0_0.getTargetTypeAndStatusEpisodes(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_0._episodeList) do
		if iter_32_1:getEpisodeType() == arg_32_1 and iter_32_1:getStatus() == arg_32_2 then
			table.insert(var_32_0, iter_32_1)
		end
	end

	return var_32_0
end

return var_0_0
