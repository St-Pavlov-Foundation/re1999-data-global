module("modules.logic.fight.system.work.FightWorkRandomDiceUseSkill353", package.seeall)

local var_0_0 = class("FightWorkRandomDiceUseSkill353", FightWorkEffectDice)

function var_0_0.onConstructor(arg_1_0)
	FightDataHelper.tempMgr.douQuQuDice = true
end

function var_0_0.onDestructor(arg_2_0)
	return
end

return var_0_0
