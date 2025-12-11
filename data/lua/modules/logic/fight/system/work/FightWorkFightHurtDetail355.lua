module("modules.logic.fight.system.work.FightWorkFightHurtDetail355", package.seeall)

local var_0_0 = class("FightWorkFightHurtDetail355", FightEffectBase)
local var_0_1 = {
	[FightEnum.EffectType.KILL] = FightWorkKill110,
	[FightEnum.EffectType.DAMAGEFROMABSORB] = FightWorkDamageFromAbsorb192
}

var_0_0.DamageEffectClass = var_0_1

local var_0_2 = {
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = FightWorkDeadlyPoisonOriginDamage263Parallel,
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = FightWorkDeadlyPoisonOriginCrit264Parallel,
	[FightEnum.EffectType.COLDSATURDAYHURT] = FightWorkColdSaturdayHurt336Parallel
}

setmetatable(var_0_2, {
	__index = var_0_1
})

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.hurtInfo
	local var_1_1 = var_1_0.effectType
	local var_1_2 = var_0_2[var_1_1]

	if not var_1_2 then
		local var_1_3 = arg_1_0.actEffectData.targetId
		local var_1_4 = FightHelper.getEntity(var_1_3)

		if var_1_4 then
			local var_1_5 = var_1_0.damage
			local var_1_6 = var_1_0.reduceHp
			local var_1_7 = var_1_4:isMySide() and -var_1_5 or var_1_5
			local var_1_8 = var_1_0:getFloatType()

			FightFloatMgr.instance:float(var_1_3, var_1_8, var_1_7, nil, var_1_0.assassinate)

			if var_1_4.nameUI then
				var_1_4.nameUI:addHp(-var_1_6)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_4, -var_1_6)
		end

		FightMsgMgr.sendMsg(FightMsgId.EntityHurt, var_1_3, var_1_0)

		return arg_1_0:onDone(true)
	end

	local var_1_9 = arg_1_0:com_registFlowSequence()

	var_1_9:registWork(var_1_2, arg_1_0.actEffectData)
	arg_1_0:playWorkAndDone(var_1_9)
end

return var_0_0
