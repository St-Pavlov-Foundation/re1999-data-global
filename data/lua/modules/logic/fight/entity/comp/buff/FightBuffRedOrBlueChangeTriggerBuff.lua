module("modules.logic.fight.entity.comp.buff.FightBuffRedOrBlueChangeTriggerBuff", package.seeall)

local var_0_0 = class("FightBuffRedOrBlueChangeTriggerBuff")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onBuffStart(arg_2_0, arg_2_1, arg_2_2)
	FightDataHelper.LYDataMgr:setLYChangeTriggerBuff(arg_2_2)
end

function var_0_0.clear(arg_3_0)
	FightDataHelper.LYDataMgr:setLYChangeTriggerBuff(nil)
end

function var_0_0.onBuffEnd(arg_4_0)
	arg_4_0:clear()
end

function var_0_0.dispose(arg_5_0)
	arg_5_0:clear()
end

return var_0_0
