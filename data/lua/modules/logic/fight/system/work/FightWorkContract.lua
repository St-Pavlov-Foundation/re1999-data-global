module("modules.logic.fight.system.work.FightWorkContract", package.seeall)

local var_0_0 = class("FightWorkContract", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightDataHelper.entityMgr:getById(arg_1_0.actEffectData.targetId)

	if var_1_0 then
		var_1_0:clearNotifyBindContract()
		FightModel.instance:setContractEntityUid(var_1_0.uid)
	end

	arg_1_0:onDone(true)
end

return var_0_0
