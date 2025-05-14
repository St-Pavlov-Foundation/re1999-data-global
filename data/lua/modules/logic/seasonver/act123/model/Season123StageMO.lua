module("modules.logic.seasonver.act123.model.Season123StageMO", package.seeall)

local var_0_0 = pureTable("Season123StageMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.stage = arg_1_1.stage
	arg_1_0.isPass = arg_1_1.isPass == 1
	arg_1_0.episodeMap = arg_1_0.episodeMap or {}
	arg_1_0.minRound = arg_1_1.minRound
	arg_1_0.state = arg_1_1.state or 0

	arg_1_0:updateEpisodes(arg_1_1.act123Episodes)
	arg_1_0:initAssistHeroMO(arg_1_1)
end

function var_0_0.updateEpisodes(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0 = 1, #arg_2_1 do
		local var_2_1 = arg_2_1[iter_2_0]
		local var_2_2 = arg_2_0.episodeMap[var_2_1.layer]

		if not var_2_2 then
			var_2_2 = Season123EpisodeMO.New()
			arg_2_0.episodeMap[var_2_1.layer] = var_2_2

			var_2_2:init(var_2_1)
		else
			var_2_2:update(var_2_1)
		end

		var_2_0[var_2_2] = true
	end

	for iter_2_1, iter_2_2 in pairs(arg_2_0.episodeMap) do
		if not var_2_0[iter_2_2] then
			arg_2_0.episodeMap[iter_2_1] = nil
		end
	end
end

function var_0_0.initAssistHeroMO(arg_3_0, arg_3_1)
	logNormal("info.assistHeroInfo.heroUid = [" .. tostring(arg_3_1.assistHeroInfo.heroUid) .. "], type = " .. type(arg_3_1.assistHeroInfo.heroUid))

	if arg_3_1.assistHeroInfo and tostring(arg_3_1.assistHeroInfo.heroUid) ~= "0" and arg_3_1.assistHeroInfo.heroId and arg_3_1.assistHeroInfo.heroId ~= 0 then
		arg_3_0._assistMO = Season123AssistHeroMO.New()

		arg_3_0._assistMO:init(arg_3_1.assistHeroInfo)

		arg_3_0._assistHeroMO = Season123HeroUtils.createHeroMOByAssistMO(arg_3_0._assistMO)
	end
end

function var_0_0.getAssistHeroMO(arg_4_0)
	return arg_4_0._assistHeroMO, arg_4_0._assistMO
end

function var_0_0.alreadyPass(arg_5_0)
	return arg_5_0.isPass
end

function var_0_0.isFinishNow(arg_6_0)
	return arg_6_0.state == 2
end

function var_0_0.isNeverTry(arg_7_0)
	return arg_7_0.state == 0
end

function var_0_0.updateReduceEpisodeRoundState(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.reduceState = arg_8_0.reduceState or {}

	local var_8_0 = arg_8_0.episodeMap[arg_8_1]

	arg_8_0.reduceState[arg_8_1] = var_8_0 and arg_8_2 or false
end

return var_0_0
