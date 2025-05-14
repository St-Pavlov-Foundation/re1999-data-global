module("modules.logic.teach.model.TeachNoteRewardListModel", package.seeall)

local var_0_0 = class("TeachNoteRewardListModel", ListScrollModel)

function var_0_0.setRewardList(arg_1_0, arg_1_1)
	arg_1_0._moList = {}

	if arg_1_1 then
		for iter_1_0, iter_1_1 in pairs(arg_1_1) do
			table.insert(arg_1_0._moList, iter_1_1)
		end
	end

	table.sort(arg_1_0._moList, function(arg_2_0, arg_2_1)
		return arg_2_0.id < arg_2_1.id
	end)
	arg_1_0:setList(arg_1_0._moList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
