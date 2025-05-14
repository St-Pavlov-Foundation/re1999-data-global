module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordListModel", package.seeall)

local var_0_0 = class("PuzzleRecordListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	local var_1_0 = {}

	arg_1_0:setList(var_1_0)
end

function var_0_0.setRecordList(arg_2_0, arg_2_1)
	arg_2_0:clear()

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = iter_2_0

		if var_2_0 < 10 then
			var_2_0 = "0" .. var_2_0
		end

		local var_2_1 = PuzzleRecordMO.New()

		var_2_1:init(var_2_0, iter_2_1)
		arg_2_0:addAtLast(var_2_1)
	end

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RecordCntChange, arg_2_0:getCount())
end

function var_0_0.clearRecord(arg_3_0)
	arg_3_0:clear()
	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RecordCntChange, arg_3_0:getCount())
end

var_0_0.instance = var_0_0.New()

return var_0_0
