module("modules.logic.versionactivity1_7.lantern.model.LanternFestivalPuzzleMo", package.seeall)

local var_0_0 = pureTable("LanternFestivalPuzzleMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.puzzleId = 0
	arg_1_0.state = 0
	arg_1_0.answerRecords = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.puzzleId = arg_2_1.puzzleId
	arg_2_0.state = arg_2_1.state
	arg_2_0.answerRecords = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.answerRecords) do
		table.insert(arg_2_0.answerRecords, iter_2_1)
	end
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0.puzzleId = arg_3_1.puzzleId
	arg_3_0.state = arg_3_1.state
	arg_3_0.answerRecords = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.answerRecords) do
		table.insert(arg_3_0.answerRecords, iter_3_1)
	end
end

return var_0_0
