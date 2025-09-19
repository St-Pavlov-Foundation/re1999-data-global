module("modules.logic.fight.entity.comp.buff.FightBuffLockHpComp", package.seeall)

local var_0_0 = class("FightBuffLockHpComp")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.refreshLockHp(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.OnLockHpChange, arg_2_0.entityId)
end

function var_0_0.onBuffStart(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.entityId = arg_3_1.entityId

	arg_3_0:refreshLockHp()
end

function var_0_0.onUpdateBuff(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:refreshLockHp()
end

function var_0_0.onBuffEnd(arg_5_0)
	arg_5_0:refreshLockHp()
end

function var_0_0.dispose(arg_6_0)
	arg_6_0:refreshLockHp()
end

return var_0_0
