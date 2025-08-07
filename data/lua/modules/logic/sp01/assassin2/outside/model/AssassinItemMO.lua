module("modules.logic.sp01.assassin2.outside.model.AssassinItemMO", package.seeall)

local var_0_0 = class("AssassinItemMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.itemId
	arg_1_0.count = arg_1_1.count
end

function var_0_0.getId(arg_2_0)
	return arg_2_0.id
end

function var_0_0.getCount(arg_3_0)
	return arg_3_0.count
end

function var_0_0.addCount(arg_4_0, arg_4_1)
	arg_4_0.count = arg_4_0.count + arg_4_1
end

function var_0_0.subCount(arg_5_0, arg_5_1)
	if arg_5_1 > arg_5_0.count then
		logError(string.format("AssassinItemMO:subCount error, count not enough, itemId:%s, curCount:%s, subCount:%s", arg_5_0.id, arg_5_0.count, arg_5_1))

		arg_5_0.count = 0
	else
		arg_5_0.count = arg_5_0.count - arg_5_1
	end
end

function var_0_0.isNew(arg_6_0)
	local var_6_0 = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.NewAssassinItem, arg_6_0.id)

	return (AssassinOutsideModel.instance:getCacheKeyData(var_6_0))
end

return var_0_0
