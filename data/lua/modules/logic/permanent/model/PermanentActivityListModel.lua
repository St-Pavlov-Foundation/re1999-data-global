module("modules.logic.permanent.model.PermanentActivityListModel", package.seeall)

local var_0_0 = class("PermanentActivityListModel", ListScrollModel)

function var_0_0.refreshList(arg_1_0)
	local var_1_0 = PermanentModel.instance:getActivityDic()
	local var_1_1 = {}
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_1.online then
			if iter_1_1.permanentUnlock then
				table.insert(var_1_1, iter_1_1)
			else
				table.insert(var_1_2, iter_1_1)
			end
		end
	end

	table.sort(var_1_1, SortUtil.keyLower("id"))
	table.sort(var_1_2, SortUtil.keyLower("id"))
	tabletool.addValues(var_1_1, var_1_2)
	table.insert(var_1_1, {
		id = -999
	})
	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
