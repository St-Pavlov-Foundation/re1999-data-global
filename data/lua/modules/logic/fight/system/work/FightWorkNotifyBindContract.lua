module("modules.logic.fight.system.work.FightWorkNotifyBindContract", package.seeall)

local var_0_0 = class("FightWorkNotifyBindContract", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightStrUtil.instance:getSplitCache(arg_1_0.actEffectData.reserveStr, "#")

	FightModel.instance:setNotifyContractInfo(arg_1_0.actEffectData.targetId, var_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
