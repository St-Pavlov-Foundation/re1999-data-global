module("modules.logic.versionactivity3_1.nationalgift.model.NationalGiftBonusMO", package.seeall)

local var_0_0 = pureTable("NationalGiftBonusMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.status = arg_1_1.status
end

function var_0_0.updateStatus(arg_2_0, arg_2_1)
	arg_2_0.status = arg_2_1
end

return var_0_0
