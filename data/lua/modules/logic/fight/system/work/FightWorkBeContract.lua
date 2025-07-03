module("modules.logic.fight.system.work.FightWorkBeContract", package.seeall)

local var_0_0 = class("FightWorkBeContract", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightModel.instance:setBeContractEntityUid(arg_1_0.actEffectData.targetId)
	arg_1_0:onDone(true)
end

return var_0_0
