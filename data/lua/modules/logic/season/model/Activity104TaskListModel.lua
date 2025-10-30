module("modules.logic.season.model.Activity104TaskListModel", package.seeall)

local var_0_0 = class("Activity104TaskListModel", ListScrollModel)

function var_0_0.refreshList(arg_1_0)
	local var_1_0 = Activity104TaskModel.instance:getTaskSeasonList()
	local var_1_1 = {}
	local var_1_2 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		var_1_1[iter_1_0] = iter_1_1

		if iter_1_1.hasFinished then
			var_1_2 = var_1_2 + 1
		end
	end

	if var_1_2 > 1 then
		table.insert(var_1_1, 1, {
			isTotalGet = true
		})
	end

	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
