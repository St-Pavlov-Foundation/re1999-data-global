module("modules.logic.fight.system.work.FightWorkChangeShield", package.seeall)

local var_0_0 = class("FightWorkChangeShield", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.targetId

	arg_1_0:com_sendFightEvent(FightEvent.ChangeShield, var_1_0)

	if arg_1_0.actEffectData.reserveId == "1" then
		FightFloatMgr.instance:float(var_1_0, FightEnum.FloatType.addShield, "+" .. arg_1_0.actEffectData.effectNum, nil, arg_1_0.actEffectData.effectNum1 == 1)
	end

	arg_1_0:onDone(true)
end

function var_0_0._onPlayCardOver(arg_2_0)
	return
end

return var_0_0
