module("modules.logic.versionactivity2_5.challenge.model.Act183GroupEpisodeRecordMO", package.seeall)

local var_0_0 = pureTable("Act183GroupEpisodeRecordMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._playerName = arg_1_1.playerName
	arg_1_0._portrait = arg_1_1.portrait
	arg_1_0._groupId = arg_1_1.groupId
	arg_1_0._allRound = arg_1_1.allRound

	arg_1_0:_onEpisodeListInfoLoaded(arg_1_1.episodeList)

	arg_1_0._finishedTime = arg_1_1.finishedTime
	arg_1_0._actId = arg_1_2
end

function var_0_0._onEpisodeListInfoLoaded(arg_2_0, arg_2_1)
	arg_2_0._episodeList = {}
	arg_2_0._episodeTypeMap = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = Act183EpisodeRecordMO.New()

		var_2_0:init(iter_2_1)
		table.insert(arg_2_0._episodeList, var_2_0)

		local var_2_1 = var_2_0:getEpisodeType()

		arg_2_0._episodeTypeMap[var_2_1] = arg_2_0._episodeTypeMap[var_2_1] or {}

		table.insert(arg_2_0._episodeTypeMap[var_2_1], var_2_0)
	end

	local var_2_2 = arg_2_0._episodeList[1]

	arg_2_0._groupType = var_2_2 and var_2_2:getGroupType()

	table.sort(arg_2_0._episodeList, arg_2_0._sortEpisodeByPassOrder)

	for iter_2_2, iter_2_3 in pairs(arg_2_0._episodeTypeMap) do
		table.sort(iter_2_3, arg_2_0._sortEpisodeByPassOrder)
	end
end

function var_0_0.getUserName(arg_3_0)
	return arg_3_0._playerName
end

function var_0_0.getPortrait(arg_4_0)
	return arg_4_0._portrait
end

function var_0_0.getFinishedTime(arg_5_0)
	return arg_5_0._finishedTime
end

function var_0_0.getAllRound(arg_6_0)
	return arg_6_0._allRound
end

function var_0_0.getEpisodeListByType(arg_7_0, arg_7_1)
	return arg_7_0._episodeTypeMap and arg_7_0._episodeTypeMap[arg_7_1]
end

function var_0_0.getBossEpisode(arg_8_0)
	local var_8_0 = arg_8_0:getEpisodeListByType(Act183Enum.EpisodeType.Boss)

	return var_8_0 and var_8_0[1]
end

function var_0_0.getEpusideListByTypeAndPassOrder(arg_9_0, arg_9_1)
	return (arg_9_0:getEpisodeListByType(arg_9_1))
end

function var_0_0._sortEpisodeByPassOrder(arg_10_0, arg_10_1)
	return arg_10_0:getPassOrder() < arg_10_1:getPassOrder()
end

function var_0_0.getGroupType(arg_11_0)
	return arg_11_0._groupType
end

function var_0_0.getGroupId(arg_12_0)
	return arg_12_0._groupId
end

function var_0_0.getActivityId(arg_13_0)
	return arg_13_0._actId
end

function var_0_0.getBossEpisodeConditionStatus(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._episodeList) do
		if iter_14_1:getEpisodeType() ~= Act183Enum.EpisodeType.Boss then
			local var_14_4 = iter_14_1:getConditionIds()
			local var_14_5 = iter_14_1:getPassConditions()

			tabletool.addValues(var_14_0, var_14_4)
			tabletool.addValues(var_14_1, var_14_5)
		else
			var_14_2 = iter_14_1:getPassConditions()
			var_14_3 = iter_14_1:getChooseConditions()
		end
	end

	return var_14_0, var_14_1, var_14_2, var_14_3
end

return var_0_0
