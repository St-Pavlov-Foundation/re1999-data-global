module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroBaseEffectWork", package.seeall)

local var_0_0 = class("DiceHeroBaseEffectWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._effectMo = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0:onDone(true)
end

return var_0_0
