module("modules.logic.fight.system.work.FightWorkStartBornExtendForEffect", package.seeall)

local var_0_0 = class("FightWorkStartBornExtendForEffect", FightWorkStartBornNormal)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._effect_name = arg_1_3
	arg_1_0._hangPoint = arg_1_4
	arg_1_0._time = arg_1_5
end

function var_0_0._playEffect(arg_2_0)
	arg_2_0._effectWrap = arg_2_0._entity.effect:addHangEffect(arg_2_0._effect_name, arg_2_0._hangPoint, nil, nil, {
		z = 0,
		x = 0,
		y = 0
	})

	arg_2_0._effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_2_0._entity.id, arg_2_0._effectWrap)
	TaskDispatcher.runDelay(arg_2_0._onEffectDone, arg_2_0, arg_2_0._time)
end

return var_0_0
