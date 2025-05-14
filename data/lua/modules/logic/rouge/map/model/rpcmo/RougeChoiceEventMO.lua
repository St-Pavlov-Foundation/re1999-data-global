module("modules.logic.rouge.map.model.rpcmo.RougeChoiceEventMO", package.seeall)

local var_0_0 = class("RougeChoiceEventMO", RougeBaseEventMO)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:updateCanChoiceSet()

	arg_1_0.choiceSelect = arg_1_0.jsonData.choiceSelect
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:updateCanChoiceSet()

	arg_2_0.choiceSelect = arg_2_0.jsonData.choiceSelect
end

function var_0_0.updateCanChoiceSet(arg_3_0)
	arg_3_0.canChoiceList = arg_3_0.jsonData.canChoiceSet

	if arg_3_0.canChoiceList then
		table.sort(arg_3_0.canChoiceList, arg_3_0.sortChoice)
	end
end

function var_0_0.getChoiceIdList(arg_4_0)
	return arg_4_0.canChoiceList
end

function var_0_0.sortChoice(arg_5_0, arg_5_1)
	return arg_5_0 < arg_5_1
end

function var_0_0.__tostring(arg_6_0)
	return var_0_0.super.__tostring(arg_6_0)
end

return var_0_0
