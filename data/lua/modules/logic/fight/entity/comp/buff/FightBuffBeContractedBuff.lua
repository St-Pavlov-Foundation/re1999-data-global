module("modules.logic.fight.entity.comp.buff.FightBuffBeContractedBuff", package.seeall)

local var_0_0 = class("FightBuffBeContractedBuff")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onBuffStart(arg_2_0, arg_2_1, arg_2_2)
	FightModel.instance:setBeContractEntityUid(arg_2_1.id)
	FightController.instance:dispatchEvent(FightEvent.BeContract, arg_2_1.id)
end

function var_0_0.onBuffEnd(arg_3_0)
	FightModel.instance:setBeContractEntityUid(nil)
end

return var_0_0
