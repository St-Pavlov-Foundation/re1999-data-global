module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDiceChangeStatusWork", package.seeall)

local var_0_0 = class("DiceHeroDiceChangeStatusWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = DiceHeroHelper.instance:getDice(arg_1_0._effectMo.targetId)

	if not var_1_0 or not var_1_0.diceMo then
		logError("骰子uid不存在" .. arg_1_0._effectMo.targetId)

		return arg_1_0:onDone(true)
	end

	var_1_0.diceMo.status = arg_1_0._effectMo.effectNum

	var_1_0:refreshLock()
	arg_1_0:onDone(true)
end

return var_0_0
