module("modules.logic.rouge.model.RougeFavoriteCollectionEnchantListModel", package.seeall)

local var_0_0 = class("RougeFavoriteCollectionEnchantListModel", ListScrollModel)

function var_0_0.initData(arg_1_0, arg_1_1)
	local var_1_0 = RougeCollectionListModel.instance:getEnchantList()
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1 ~= arg_1_1 then
			table.insert(var_1_1, iter_1_1)
		end
	end

	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
