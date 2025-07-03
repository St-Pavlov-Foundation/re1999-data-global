module("modules.logic.fight.model.data.FightEnhanceInfoBoxData", package.seeall)

local var_0_0 = FightDataClass("FightEnhanceInfoBoxData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.canUpgradeIds = {}
	arg_1_0.upgradedOptions = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.canUpgradeIds) do
		table.insert(arg_1_0.canUpgradeIds, iter_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.upgradedOptions) do
		table.insert(arg_1_0.upgradedOptions, iter_1_3)
	end
end

return var_0_0
