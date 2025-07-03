module("modules.logic.fight.model.data.FightBloodPoolDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightBloodPoolDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.playedSkill = false
end

function var_0_0.onCancelOperation(arg_2_0)
	if arg_2_0.playedSkill then
		arg_2_0.playedSkill = false
	end

	FightController.instance:dispatchEvent(FightEvent.BloodPool_OnCancelPlayCard)
end

function var_0_0.playBloodPoolCard(arg_3_0)
	arg_3_0.playedSkill = true

	FightController.instance:dispatchEvent(FightEvent.BloodPool_OnPlayCard)
end

function var_0_0.checkPlayedCard(arg_4_0)
	return arg_4_0.playedSkill
end

return var_0_0
