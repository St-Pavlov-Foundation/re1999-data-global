module("modules.logic.fight.entity.comp.FightEntityBuffSpecialPrecessComp", package.seeall)

local var_0_0 = class("FightEntityBuffSpecialPrecessComp", FightBaseClass)

function var_0_0.onAwake(arg_1_0, arg_1_1)
	arg_1_0._entity = arg_1_1

	arg_1_0:com_registFightEvent(FightEvent.AddEntityBuff, arg_1_0._onAddEntityBuff)
end

function var_0_0._onAddEntityBuff(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= arg_2_0._entity.id then
		return
	end

	arg_2_0:_registBuffIdClass(arg_2_2.buffId, arg_2_2.uid)
end

local var_0_1 = {
	[4150022] = FightBuffJuDaBenYePuDormancyHand,
	[4150023] = FightBuffJuDaBenYePuDormancyTail
}

function var_0_0._registBuffIdClass(arg_3_0, arg_3_1, arg_3_2)
	if var_0_1[arg_3_1] then
		arg_3_0:newClass(var_0_1[arg_3_1], arg_3_0._entity, arg_3_1, arg_3_2)
	end
end

function var_0_0.releaseSelf(arg_4_0)
	return
end

return var_0_0
