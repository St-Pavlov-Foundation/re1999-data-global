module("modules.logic.versionactivity2_5.act182.model.AutoChessGameMO", package.seeall)

local var_0_0 = pureTable("AutoChessGameMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.module = arg_1_1.module
	arg_1_0.start = arg_1_1.start
	arg_1_0.currRound = arg_1_1.currRound
	arg_1_0.episodeId = arg_1_1.episodeId

	arg_1_0:updateMasterIdBox(arg_1_1.masterIdBox)

	arg_1_0.selectMasterId = arg_1_1.selectMasterId
	arg_1_0.refreshed = arg_1_1.refreshed
end

function var_0_0.updateMasterIdBox(arg_2_0, arg_2_1)
	arg_2_0.masterIdBox = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0.masterIdBox[#arg_2_0.masterIdBox + 1] = iter_2_1
	end
end

return var_0_0
