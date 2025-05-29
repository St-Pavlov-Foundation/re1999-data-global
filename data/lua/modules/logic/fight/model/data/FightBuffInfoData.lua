module("modules.logic.fight.model.data.FightBuffInfoData", package.seeall)

local var_0_0 = FightDataClass("FightBuffInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.buffId = arg_1_1.buffId
	arg_1_0.duration = arg_1_1.duration
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.exInfo = arg_1_1.exInfo
	arg_1_0.fromUid = arg_1_1.fromUid
	arg_1_0.count = arg_1_1.count
	arg_1_0.actCommonParams = arg_1_1.actCommonParams
	arg_1_0.layer = arg_1_1.layer
	arg_1_0.type = arg_1_1.type
end

return var_0_0
