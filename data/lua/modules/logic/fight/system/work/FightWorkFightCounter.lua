module("modules.logic.fight.system.work.FightWorkFightCounter", package.seeall)

local var_0_0 = class("FightWorkFightCounter", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.effectNum
	local var_1_1 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_0 == 13 and var_1_1 then
		local var_1_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("fight_counter_float13"), {
			luaLang("multiple"),
			arg_1_0.actEffectData.configEffect
		})

		FightFloatMgr.instance:float(var_1_1.id, FightEnum.FloatType.buff, var_1_2, 1, false)
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
