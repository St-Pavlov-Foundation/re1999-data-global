module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueCollectionMO", package.seeall)

local var_0_0 = pureTable("RogueCollectionMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.uid
	arg_1_0.cfgId = arg_1_1.id
	arg_1_0.leftUid = arg_1_1.leftUid
	arg_1_0.rightUid = arg_1_1.rightUid
	arg_1_0.baseId = arg_1_1.baseId
	arg_1_0.enchantUid = arg_1_1.enchantUid
end

function var_0_0.getEnchantId(arg_2_0, arg_2_1)
	return arg_2_1 == V1a6_CachotEnum.CollectionHole.Left and arg_2_0.leftUid or arg_2_0.rightUid
end

function var_0_0.isEnchant(arg_3_0)
	return arg_3_0.enchantUid and arg_3_0.enchantUid ~= 0
end

function var_0_0.getEnchantCount(arg_4_0)
	local var_4_0 = 0

	if arg_4_0.leftUid and arg_4_0.leftUid ~= V1a6_CachotEnum.EmptyEnchantId then
		var_4_0 = var_4_0 + 1
	end

	if arg_4_0.rightUid and arg_4_0.rightUid ~= V1a6_CachotEnum.EmptyEnchantId then
		var_4_0 = var_4_0 + 1
	end

	return var_4_0
end

return var_0_0
