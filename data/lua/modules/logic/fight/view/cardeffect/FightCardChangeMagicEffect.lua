module("modules.logic.fight.view.cardeffect.FightCardChangeMagicEffect", package.seeall)

local var_0_0 = class("FightCardChangeMagicEffect", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0:_playEffects()
end

function var_0_0._playEffects(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
