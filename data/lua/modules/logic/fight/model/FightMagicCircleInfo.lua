module("modules.logic.fight.model.FightMagicCircleInfo", package.seeall)

local var_0_0 = pureTable("FightMagicCircleInfo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.magicCircleId = nil
end

function var_0_0.refreshData(arg_2_0, arg_2_1)
	arg_2_0.magicCircleId = arg_2_1.magicCircleId
	arg_2_0.round = arg_2_1.round
	arg_2_0.createUid = arg_2_1.createUid
	arg_2_0.electricLevel = arg_2_1.electricLevel
	arg_2_0.electricProgress = arg_2_1.electricProgress
end

function var_0_0.deleteData(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0.magicCircleId then
		arg_3_0.magicCircleId = nil

		return true
	end
end

function var_0_0.clear(arg_4_0)
	arg_4_0.magicCircleId = nil
	arg_4_0.round = nil
	arg_4_0.createUid = nil
	arg_4_0.electricLevel = nil
	arg_4_0.electricProgress = nil
end

return var_0_0
