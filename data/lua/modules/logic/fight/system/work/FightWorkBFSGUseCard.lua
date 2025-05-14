module("modules.logic.fight.system.work.FightWorkBFSGUseCard", package.seeall)

local var_0_0 = class("FightWorkBFSGUseCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if FightModel.instance:getVersion() >= 1 and arg_1_0._actEffectMO.teamType ~= FightEnum.TeamType.MySide then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = FightCardModel.instance:getHandCards()
	local var_1_1 = arg_1_0._actEffectMO.effectNum

	if var_1_0[var_1_1] then
		table.remove(var_1_0, var_1_1)
		FightCardModel.instance:coverCard(var_1_0)
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	end

	arg_1_0:onDone(true)
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
