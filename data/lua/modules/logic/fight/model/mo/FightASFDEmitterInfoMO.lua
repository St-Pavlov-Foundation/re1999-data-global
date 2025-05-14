module("modules.logic.fight.model.mo.FightASFDEmitterInfoMO", package.seeall)

local var_0_0 = pureTable("FightASFDEmitterInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.energy = arg_1_1.energy
end

function var_0_0.changeEnergy(arg_2_0, arg_2_1)
	arg_2_0.energy = arg_2_0.energy or 0
	arg_2_0.energy = arg_2_0.energy + arg_2_1
end

return var_0_0
