module("modules.logic.explore.model.mo.ExploreBackpackItemMO", package.seeall)

local var_0_0 = pureTable("ExploreBackpackItemMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.ids = {}
	arg_1_0.quantity = 0
	arg_1_0.itemId = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.uid
	arg_2_0.ids = {
		arg_2_0.id
	}
	arg_2_0.quantity = arg_2_1.quantity
	arg_2_0.itemId = arg_2_1.itemId
	arg_2_0.status = arg_2_1.status
	arg_2_0.config = ExploreConfig.instance:getItemCo(arg_2_0.itemId)
	arg_2_0.isStackable = arg_2_0.config.isClientStackable
	arg_2_0.isActiveTypeItem = ExploreConfig.instance:isActiveTypeItem(arg_2_0.config.type)
	arg_2_0.itemEffect = string.split(arg_2_0.config.effect, "#")[1] or "1"
end

function var_0_0.updateStackable(arg_3_0, arg_3_1)
	if arg_3_1.quantity == 0 then
		tabletool.removeValue(arg_3_0.ids, arg_3_1.uid)
	elseif tabletool.indexOf(arg_3_0.ids, arg_3_1.uid) == nil then
		table.insert(arg_3_0.ids, arg_3_1.uid)
	end

	arg_3_0.id = arg_3_0.ids[1] or 0
	arg_3_0.quantity = #arg_3_0.ids
end

return var_0_0
