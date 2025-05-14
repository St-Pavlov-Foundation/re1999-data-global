module("modules.logic.reactivity.model.ReactivityRuleModel", package.seeall)

local var_0_0 = class("ReactivityRuleModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.refreshList(arg_2_0)
	arg_2_0:clear()

	local var_2_0 = ReactivityController.instance:getCurReactivityId()
	local var_2_1 = ReactivityEnum.ActivityDefine[var_2_0]
	local var_2_2 = var_2_1 and var_2_1.storeActId
	local var_2_3 = ReactivityConfig.instance:getItemConvertList()
	local var_2_4 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_3) do
		if iter_2_1.version == var_2_2 then
			local var_2_5 = {
				id = iter_2_0,
				typeId = iter_2_1.typeId,
				itemId = iter_2_1.itemId,
				limit = iter_2_1.limit,
				price = iter_2_1.price
			}

			table.insert(var_2_4, var_2_5)
		end
	end

	if #var_2_4 > 1 then
		table.sort(var_2_4, SortUtil.tableKeyLower({
			"typeId",
			"itemId"
		}))
	end

	arg_2_0:setList(var_2_4)
end

var_0_0.instance = var_0_0.New()

return var_0_0
