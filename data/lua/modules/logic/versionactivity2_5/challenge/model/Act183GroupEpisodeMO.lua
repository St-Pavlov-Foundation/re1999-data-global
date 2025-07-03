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
	arg_2_0._bossPassCount = 0
	arg_2_0._episodeFinishCount = 0

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
	elseif arg_7_0._groupType == Act183Enum.GroupType.NormalMain then
		var_7_0 = arg_7_0:isGroupFinished() and Act183Enum.GroupStatus.Finished or Act183Enum.GroupStatus.Unlocked
	elseif arg_7_0._groupType == Act183Enum.GroupType.HardMain then
		local var_7_2 = Act183Model.instance:getActInfo():getGroupEpisodeMos(Act183Enum.GroupType.NormalMain)
		local var_7_3 = var_7_2 and var_7_2[1]

		if var_7_3 and var_7_3:isHasFinished() then
			var_7_0 = arg_7_0:isGroupFinished() and Act183Enum.GroupStatus.Finished or Act183Enum.GroupStatus.Unlocked
		end
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

function var_0_0.getTotalAndPassConditionIds(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getEpisodeMo(arg_13_1)
	local var_13_1 = arg_13_0:getPreEpisodeMos(arg_13_1)
	local var_13_2 = {
		var_13_0
	}

	tabletool.addValues(var_13_2, var_13_1)
	table.sort(var_13_2, arg_13_0._sortEpisodeByPassOrder)

	local var_13_3 = {}
	local var_13_4 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		local var_13_5 = iter_13_1:getConditionIds()
		local var_13_6 = iter_13_1:getPassConditions()

		tabletool.addValues(var_13_3, var_13_5)
		tabletool.addValues(var_13_4, var_13_6)
	end

	return var_13_3, var_13_4
end

function var_0_0.getEpisodeListByPassOrder(arg_14_0)
	local var_14_0 = tabletool.copy(arg_14_0._episodeList)

	table.sort(var_14_0, arg_14_0._sortEpisodeByPassOrder)

	return var_14_0
end

function var_0_0._sortEpisodeByPassOrder(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:isFinished()

	if var_15_0 ~= arg_15_1:isFinished() then
		return var_15_0
	end

	local var_15_1 = arg_15_0:getPassOrder()
	local var_15_2 = arg_15_1:getPassOrder()

	if var_15_1 ~= var_15_2 then
		return var_15_1 < var_15_2
	end

	local var_15_3 = arg_15_0:getConfig()
	local var_15_4 = arg_15_1:getConfig()
	local var_15_5 = var_15_3.order
	local var_15_6 = var_15_4.order

	if var_15_5 ~= var_15_6 then
		return var_15_5 < var_15_6
	end

	return arg_15_0:getEpisodeId() < arg_15_1:getEpisodeId()
end

function var_0_0.isConditionPass(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._episodeList) do
		if iter_16_1:isConditionPass(arg_16_1) then
			return true
		end
	end
end

function var_0_0.getPreEpisodeMos(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getEpisodeMo(arg_17_1)
	local var_17_1 = {}

	if var_17_0 then
		local var_17_2 = var_17_0:getPreEpisodeIds()

		if var_17_2 then
			for iter_17_0, iter_17_1 in ipairs(var_17_2) do
				local var_17_3 = arg_17_0:getEpisodeMo(iter_17_1)

				table.insert(var_17_1, var_17_3)
			end
		end
	end

	return var_17_1
end

function var_0_0.getConditionFinishCount(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._episodeList) do
		local var_18_1 = iter_18_1:getPassConditions()

		var_18_0 = var_18_0 + (var_18_1 and #var_18_1 or 0)
	end

	return var_18_0
end

function var_0_0.getBossEpisodePassCount(arg_19_0)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._episodeList) do
		local var_19_1 = iter_19_1:getEpisodeType()
		local var_19_2 = iter_19_1:getStatus()

		if var_19_1 == Act183Enum.EpisodeType.Boss and var_19_2 == Act183Enum.EpisodeStatus.Finished then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function var_0_0.getEpisodeMo(arg_20_0, arg_20_1)
	return arg_20_0._episodeMap[arg_20_1]
end

function var_0_0.getEscapeRules(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getEpisodeMo(arg_21_1)

	if not var_21_0 then
		return
	end

	local var_21_1 = {}
	local var_21_2 = arg_21_0:getEpisodeListByPassOrder()

	for iter_21_0, iter_21_1 in ipairs(var_21_2) do
		if not iter_21_1:isFinished() then
			break
		end

		if iter_21_1:getEpisodeId() == var_21_0:getEpisodeId() then
			break
		end

		local var_21_3 = iter_21_1:getEscapeRules()

		if var_21_3 and #var_21_3 > 0 then
			for iter_21_2, iter_21_3 in ipairs(var_21_3) do
				if not string.nilorempty(iter_21_3) then
					local var_21_4 = {
						episodeId = iter_21_1:getEpisodeId(),
						ruleDesc = iter_21_3,
						ruleIndex = iter_21_2,
						passOrder = iter_21_1:getPassOrder()
					}

					table.insert(var_21_1, var_21_4)
				end
			end
		end
	end

	return var_21_1
end

function var_0_0.isEpisodeCanRestart(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getEpisodeMo(arg_22_1)

	if not var_22_0 then
		return
	end

	local var_22_1 = var_22_0:isFinished()

	if var_22_0:getEpisodeType() == Act183Enum.EpisodeType.Boss and var_22_1 then
		return true
	end

	local var_22_2 = var_22_0:getPassOrder()
	local var_22_3 = arg_22_0:findMaxPassOrder()

	return var_22_1 and var_22_2 == var_22_3
end

function var_0_0.isEpisodeCanReset(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getEpisodeMo(arg_23_1)

	if not var_23_0 then
		return
	end

	if var_23_0:getEpisodeType() == Act183Enum.EpisodeType.Boss then
		return
	end

	local var_23_1 = var_23_0:getStatus()
	local var_23_2 = var_23_0:getPassOrder()
	local var_23_3 = arg_23_0:findMaxPassOrder()

	return var_23_1 == Act183Enum.EpisodeStatus.Finished and var_23_2 < var_23_3
end

function var_0_0.isCanStart(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getEpisodeMo(arg_24_1)

	if not var_24_0 then
		return
	end

	if var_24_0:getStatus() ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	local var_24_1 = var_24_0:getEpisodeType()

	if var_24_1 == Act183Enum.EpisodeType.Sub then
		return true
	elseif var_24_1 == Act183Enum.EpisodeType.Boss then
		return arg_24_0:isAllSubEpisodeFinished()
	end
end

function var_0_0.isEpisodeCanReRepress(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getEpisodeMo(arg_25_1)

	if not var_25_0 then
		return
	end

	if var_25_0:getEpisodeType() == Act183Enum.EpisodeType.Boss then
		return
	end

	local var_25_1 = var_25_0:getPassOrder()
	local var_25_2 = var_25_0:isFinished()
	local var_25_3 = arg_25_0:findMaxPassOrder()
	local var_25_4 = Act183Helper.isLastPassEpisodeInGroup(var_25_0)

	return var_25_2 and var_25_1 == var_25_3 and not var_25_4
end

function var_0_0.isHeroRepress(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._episodeList) do
		local var_26_0 = iter_26_1:isHeroRepress(arg_26_1)
		local var_26_1 = iter_26_1:getEpisodeId()

		if var_26_0 and (not arg_26_2 or arg_26_2 == var_26_1) then
			return true
		end
	end

	return false
end

function var_0_0.findMaxPassOrder(arg_27_0)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._episodeList) do
		if iter_27_1:isFinished() then
			local var_27_1 = iter_27_1:getPassOrder()

			if var_27_0 < var_27_1 then
				var_27_0 = var_27_1
			end
		end
	end

	return var_27_0
end

function var_0_0.isHeroRepressInPreEpisode(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getEpisodeMo(arg_28_1)
	local var_28_1 = var_28_0:isFinished()
	local var_28_2 = var_28_0:getPassOrder()

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._episodeList) do
		if iter_28_1:isFinished() and (not var_28_1 or var_28_2 > iter_28_1:getPassOrder()) and iter_28_1:isHeroRepress(arg_28_2) then
			return true
		end
	end

	return false
end

function var_0_0.getStatusEpisodes(arg_29_0, arg_29_1)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._episodeList) do
		if arg_29_1 == iter_29_1:getStatus() then
			table.insert(var_29_0, iter_29_1)
		end
	end

	return var_29_0
end

return var_0_0
