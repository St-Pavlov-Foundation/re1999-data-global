module("modules.logic.survival.model.map.SurvivalShopMo", package.seeall)

local var_0_0 = pureTable("SurvivalShopMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.items = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.items) do
		local var_1_0 = SurvivalShopItemMo.New()

		var_1_0:init(iter_1_1)
		table.insert(arg_1_0.items, var_1_0)
	end
end

function var_0_0.removeItem(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.items) do
		if iter_2_1.uid == arg_2_1 then
			iter_2_1.count = iter_2_1.count - arg_2_2

			if iter_2_1.count <= 0 then
				iter_2_1:ctor()
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShopItemUpdate, iter_2_0, iter_2_1)

			break
		end
	end
end

return var_0_0
