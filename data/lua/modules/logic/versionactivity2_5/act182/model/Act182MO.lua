module("modules.logic.versionactivity2_5.act182.model.Act182MO", package.seeall)

local var_0_0 = pureTable("Act182MO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.passEpisodeIds = arg_1_1.passEpisodeIds
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.score = arg_1_1.score
	arg_1_0.gameMoDic = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.gameInfos) do
		local var_1_0 = AutoChessGameMO.New()

		var_1_0:init(iter_1_1)

		arg_1_0.gameMoDic[iter_1_1.module] = var_1_0
	end

	arg_1_0.historyInfo = arg_1_1.historyInfo
	arg_1_0.doubleScoreTimes = arg_1_1.doubleScoreTimes
	arg_1_0.gainRewardRank = arg_1_1.gainRewardRank
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
		local var_2_0 = iter_2_1.module

		arg_2_0.gameMoDic[var_2_0]:init(iter_2_1)
	end

	arg_2_0.historyInfo = arg_2_1.historyInfo
	arg_2_0.doubleScoreTimes = arg_2_1.doubleScoreTimes
	arg_2_0.gainRewardRank = arg_2_1.gainRewardRank
end

function var_0_0.updateMasterIdBox(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.gameMoDic[AutoChessEnum.ModuleId.PVP]

	var_3_0:updateMasterIdBox(arg_3_1)

	var_3_0.refreshed = arg_3_2
	var_3_0.start = true
end

function var_0_0.isEpisodePass(arg_4_0, arg_4_1)
	if tabletool.indexOf(arg_4_0.passEpisodeIds, arg_4_1) then
		return true
	else
		return false
	end
end

function var_0_0.isEpisodeUnlock(arg_5_0, arg_5_1)
	local var_5_0 = lua_auto_chess_episode.configDict[arg_5_1].preEpisode

	if var_5_0 == 0 then
		return true
	elseif arg_5_0:isEpisodePass(var_5_0) then
		return true
	end

	return false
end

function var_0_0.clearRankUpMark(arg_6_0)
	arg_6_0.isRankUp = false
	arg_6_0.newRankUp = false
end

return var_0_0
