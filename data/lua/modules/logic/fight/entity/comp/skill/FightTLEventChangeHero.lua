module("modules.logic.fight.entity.comp.skill.FightTLEventChangeHero", package.seeall)

local var_0_0 = class("FightTLEventChangeHero")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._fightStepMO = arg_1_1
end

function var_0_0.reset(arg_2_0)
	arg_2_0:dispose()
end

function var_0_0.dispose(arg_3_0)
	return
end

function var_0_0.onSkillEnd(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeHeroEnd, arg_4_0._fightStepMO.fromId, arg_4_0._fightStepMO.toId)
end

function var_0_0.endChangeHero(arg_5_0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeHeroEnd, arg_5_0._fightStepMO.fromId, arg_5_0._fightStepMO.toId)
end

return var_0_0
