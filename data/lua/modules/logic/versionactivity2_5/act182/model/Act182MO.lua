module("modules.logic.versionactivity2_5.act182.model.Act182MO", package.seeall)

local var_0_0 = pureTable("Act182MO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.passEpisodeIds = arg_1_1.passEpisodeIds
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.score = arg_1_1.score
	arg_1_0.gameMos = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.gameInfos) do
		local var_1_0 = AutoChessGameMO.New()

		var_1_0:init(iter_1_1)
		table.insert(arg_1_0.gameMos, var_1_0)
	end

	arg_1_0.historyInfo = arg_1_1.historyInfo
	arg_1_0.doubleScoreTimes = arg_1_1.doubleScoreTimes
	arg_1_0.gainRewardRank = arg_1_1.gainRewardRank

	arg_1_0:updateSnapshot(arg_1_1.snapshot)
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_1.rank - arg_2_0.rank > 0 then
		arg_2_0.isRankUp = true

		if arg_2_1.rank > arg_2_0.historyInfo.maxRank then
			arg_2_0.newRankUp = true
		end
	end

	arg_2_0.passEpisodeIds = arg_2_1.passEpisodeIds
	arg_2_0.rank = arg_2_1.rank
	arg_2_0.score = arg_2_1.score

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.gameInfos) do
		local var_2_0 = arg_2_0:getGameMo(iter_2_1.activityId, iter_2_1.module, true)

		if not var_2_0 then
			var_2_0 = AutoChessGameMO.New()

			table.insert(arg_2_0.gameMos, var_2_0)
		end

		var_2_0:init(iter_2_1)
	end

	arg_2_0.historyInfo = arg_2_1.historyInfo
	arg_2_0.doubleScoreTimes = arg_2_1.doubleScoreTimes
	arg_2_0.gainRewardRank = arg_2_1.gainRewardRank
	arg_2_0.snapshot = arg_2_1.snapshot
end

function var_0_0.updateMasterIdBox(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0:getGameMo(arg_3_1, AutoChessEnum.ModuleId.PVP)

	var_3_0:updateMasterIdBox(arg_3_2)

	var_3_0.refreshed = arg_3_3
	var_3_0.start = true
end

function var_0_0.updateSnapshot(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.snapshot = arg_4_1
end

function var_0_0.updateFriendSnapshot(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._friendSnapshots then
		arg_5_0._friendSnapshots = {}
	end

	local var_5_0 = arg_5_1.playerInfo.userId

	if var_5_0 ~= 0 then
		arg_5_0._friendSnapshots[var_5_0] = arg_5_1
		arg_5_0._curFriendSnapshot = arg_5_1
	end
end

function var_0_0.updateFriendInfoList(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._friendPlayerInfos = arg_6_1
end

function var_0_0.updateFriendFightRecords(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._friendFightRecords = arg_7_1
end

function var_0_0.getCurFriendSnapshot(arg_8_0)
	return arg_8_0._curFriendSnapshot
end

function var_0_0.getFriendInfoList(arg_9_0)
	return arg_9_0._friendPlayerInfos
end

function var_0_0.getFriendFightRecords(arg_10_0)
	return arg_10_0._friendFightRecords
end

function var_0_0.isEpisodePass(arg_11_0, arg_11_1)
	if tabletool.indexOf(arg_11_0.passEpisodeIds, arg_11_1) then
		return true
	else
		return false
	end
end

function var_0_0.isEpisodeUnlock(arg_12_0, arg_12_1)
	local var_12_0 = AutoChessConfig.instance:getEpisodeCO(arg_12_1).preEpisode

	if var_12_0 == 0 then
		return true
	elseif arg_12_0:isEpisodePass(var_12_0) then
		return true
	end

	return false
end

function var_0_0.clearRankUpMark(arg_13_0)
	arg_13_0.isRankUp = false
	arg_13_0.newRankUp = false
end

function var_0_0.getGameMo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.gameMos) do
		if iter_14_1.activityId == arg_14_1 and iter_14_1.module == arg_14_2 then
			return iter_14_1
		end
	end

	if not arg_14_3 then
		logError(string.format("活动: %s 模块: %s 不存在Act182AutoChessGameInfo", arg_14_1, arg_14_2))
	end
end

return var_0_0
