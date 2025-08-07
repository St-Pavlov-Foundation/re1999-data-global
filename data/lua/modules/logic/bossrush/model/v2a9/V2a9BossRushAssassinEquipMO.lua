module("modules.logic.bossrush.model.v2a9.V2a9BossRushAssassinEquipMO", package.seeall)

local var_0_0 = class("V2a9BossRushAssassinEquipMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._index = arg_1_1
	arg_1_0._isLock = arg_1_3

	arg_1_0:setEquipItemType(arg_1_2)
end

function var_0_0.setEquipItemType(arg_2_0, arg_2_1)
	arg_2_0._itemType = arg_2_1
end

function var_0_0.isEquip(arg_3_0)
	return arg_3_0._itemType and arg_3_0._itemType ~= 0
end

function var_0_0.getItemType(arg_4_0)
	return arg_4_0._itemType
end

function var_0_0.getIndex(arg_5_0)
	return arg_5_0._index
end

function var_0_0.isLock(arg_6_0)
	return arg_6_0._isLock
end

return var_0_0
