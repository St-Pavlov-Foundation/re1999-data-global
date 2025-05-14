module("modules.logic.versionactivity1_4.act133.model.Activity133ListModel", package.seeall)

local var_0_0 = class("Activity133ListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = {}

	arg_1_0.scrollgo = arg_1_1

	local var_1_1 = Activity133Config.instance:getBonusCoList()

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = Activity133ListMO.New()

		var_1_2:init(iter_1_1[1])
		table.insert(var_1_0, var_1_2)
	end

	table.sort(var_1_0, var_0_0._sortFunction)

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		if not Activity133Model.instance:checkBonusReceived(iter_1_3.id) then
			local var_1_3 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity
			local var_1_4 = string.splitToNumber(iter_1_3.config.needTokens, "#")

			if var_1_3 >= tonumber(var_1_4[3]) then
				iter_1_3.showRed = true

				break
			end
		end
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0._sortFunction(arg_2_0, arg_2_1)
	if arg_2_0.id ~= arg_2_1.id then
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.reInit(arg_3_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
