module("modules.logic.fight.entity.comp.FightAssembledMonsterSpineSub", package.seeall)

local var_0_0 = class("FightAssembledMonsterSpineSub")

function var_0_0.play(arg_1_0, ...)
	arg_1_0.unitSpawn.mainSpine:playBySub(arg_1_0.unitSpawn, ...)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.unitSpawn = arg_2_1
end

function var_0_0.__index(arg_3_0, arg_3_1)
	if var_0_0[arg_3_1] then
		return var_0_0[arg_3_1]
	else
		return arg_3_0.unitSpawn.mainSpine[arg_3_1]
	end
end

return var_0_0
