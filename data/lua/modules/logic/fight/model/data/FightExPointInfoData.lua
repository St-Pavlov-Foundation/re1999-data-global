module("modules.logic.fight.model.data.FightExPointInfoData", package.seeall)

local var_0_0 = FightDataClass("FightExPointInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.exPoint = arg_1_1.exPoint
	arg_1_0.powerInfos = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.powerInfos) do
		table.insert(arg_1_0.powerInfos, FightPowerInfoData.New(iter_1_1))
	end

	arg_1_0.currentHp = arg_1_1.currentHp
end

return var_0_0
