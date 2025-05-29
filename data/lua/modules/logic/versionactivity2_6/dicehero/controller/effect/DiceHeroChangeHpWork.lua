module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangeHpWork", package.seeall)

local var_0_0 = class("DiceHeroChangeHpWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._effectMo.targetId
	local var_1_1 = DiceHeroHelper.instance:getEntity(var_1_0)

	if not var_1_1 then
		logError("找不到实体" .. var_1_0)
	else
		var_1_1:addHp(arg_1_0._effectMo.effectNum)
	end

	arg_1_0:onDone(true)
end

return var_0_0
