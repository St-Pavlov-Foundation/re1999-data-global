module("modules.logic.fight.system.work.FightWorkBFSGUseCard", package.seeall)

local var_0_0 = class("FightWorkBFSGUseCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if FightModel.instance:getVersion() >= 1 and arg_1_0.actEffectData.teamType ~= FightEnum.TeamType.MySide then
		arg_1_0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	arg_1_0:onDone(true)
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
