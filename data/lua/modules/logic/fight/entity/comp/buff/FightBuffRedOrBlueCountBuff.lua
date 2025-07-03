module("modules.logic.fight.entity.comp.buff.FightBuffRedOrBlueCountBuff", package.seeall)

local var_0_0 = class("FightBuffRedOrBlueCountBuff")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onBuffStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.entityMo = arg_2_1:getMO()
	arg_2_0.side = arg_2_0.entityMo.side

	if arg_2_0.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCountBuff(arg_2_2)
	end
end

function var_0_0.clear(arg_3_0)
	if arg_3_0.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCountBuff(nil)
	end
end

function var_0_0.onBuffEnd(arg_4_0)
	arg_4_0:clear()
end

function var_0_0.dispose(arg_5_0)
	arg_5_0:clear()
end

return var_0_0
