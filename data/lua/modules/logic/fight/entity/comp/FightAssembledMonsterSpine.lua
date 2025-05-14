module("modules.logic.fight.entity.comp.FightAssembledMonsterSpine", package.seeall)

local var_0_0 = class("FightAssembledMonsterSpine", FightUnitSpine)

function var_0_0.playBySub(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if arg_1_2 == "die" or arg_1_2 == "idle" then
		return
	end

	arg_1_0:play(arg_1_2, arg_1_3, arg_1_4)
end

return var_0_0
