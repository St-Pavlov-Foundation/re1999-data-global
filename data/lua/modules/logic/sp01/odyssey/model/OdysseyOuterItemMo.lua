module("modules.logic.sp01.odyssey.model.OdysseyOuterItemMo", package.seeall)

local var_0_0 = pureTable("OdysseyOuterItemMo")

function var_0_0.init(arg_1_0)
	arg_1_0.addCount = 0
	arg_1_0.count = 0
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.type = arg_2_1.materilType
	arg_2_0.id = arg_2_1.materilId
	arg_2_0.addCount = arg_2_1.quantity
	arg_2_0.config = ItemConfig.instance:getItemConfig(arg_2_0.type, arg_2_0.id)
	arg_2_0.count = ItemModel.instance:getItemCount(arg_2_0.id)
	arg_2_0.itemType = OdysseyEnum.RewardItemType.OuterItem
end

function var_0_0.cleanAddCount(arg_3_0)
	arg_3_0.addCount = 0
end

return var_0_0
