module("modules.logic.versionactivity1_4.act130.model.Activity130LevelInfoMo", package.seeall)

local var_0_0 = pureTable("Activity130LevelInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.episodeId = 0
	arg_1_0.state = 0
	arg_1_0.progress = 0
	arg_1_0.act130Elements = {}
	arg_1_0.tipsElementId = 0
	arg_1_0.challengeNum = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.episodeId = arg_2_1.episodeId
	arg_2_0.state = arg_2_1.state
	arg_2_0.progress = arg_2_1.progress
	arg_2_0.act130Elements = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.act130Elements) do
		local var_2_0 = Activity130ElementMo.New()

		var_2_0:init(iter_2_1)
		table.insert(arg_2_0.act130Elements, var_2_0)
	end

	arg_2_0.tipsElementId = arg_2_1.tipsElementId
	arg_2_0.challengeNum = arg_2_1.startGameTimes
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0.state = arg_3_1.state
	arg_3_0.progress = arg_3_1.progress
	arg_3_0.act130Elements = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.act130Elements) do
		local var_3_0 = Activity130ElementMo.New()

		var_3_0:init(iter_3_1)
		table.insert(arg_3_0.act130Elements, var_3_0)
	end

	arg_3_0.tipsElementId = arg_3_1.tipsElementId
	arg_3_0.challengeNum = arg_3_1.startGameTimes
end

function var_0_0.getFinishElementCount(arg_4_0)
	local var_4_0 = 0

	if not var_4_0 then
		return var_4_0
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.act130Elements) do
		if iter_4_1.isFinish then
			var_4_0 = var_4_0 + 1
		end
	end

	return var_4_0
end

function var_0_0.updateChallengeNum(arg_5_0, arg_5_1)
	arg_5_0.challengeNum = arg_5_1
end

return var_0_0
