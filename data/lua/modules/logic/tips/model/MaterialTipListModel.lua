module("modules.logic.tips.model.MaterialTipListModel", package.seeall)

local var_0_0 = class("MaterialTipListModel", ListScrollModel)

function var_0_0.setData(arg_1_0, arg_1_1)
	local var_1_0 = {}

	if arg_1_1 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
			local var_1_1 = {
				materilType = iter_1_1[1],
				materilId = iter_1_1[2],
				quantity = iter_1_1[3]
			}

			table.insert(var_1_0, var_1_1)
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
