module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordMO", package.seeall)

local var_0_0 = pureTable("PuzzleRecordMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.index = arg_1_1
	arg_1_0.desc = arg_1_2
end

function var_0_0.GetIndex(arg_2_0)
	return arg_2_0.index
end

function var_0_0.GetRecord(arg_3_0)
	return arg_3_0.desc
end

return var_0_0
