module("modules.logic.fight.model.data.FightEquipRecordData", package.seeall)

local var_0_0 = FightDataClass("FightEquipRecordData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.equipUid = arg_1_1.equipUid
	arg_1_0.equipId = arg_1_1.equipId
	arg_1_0.equipLv = arg_1_1.equipLv
	arg_1_0.refineLv = arg_1_1.refineLv
end

return var_0_0
