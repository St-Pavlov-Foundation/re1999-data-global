module("modules.logic.fight.system.work.FightWorkCardInvalid", package.seeall)

local var_0_0 = class("FightWorkCardInvalid", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if FightModel.instance:getVersion() >= 1 and arg_1_0.actEffectData.teamType ~= FightEnum.TeamType.MySide then
		local var_1_0 = FightDataHelper.roundMgr:getPreRoundData()

		if var_1_0 then
			local var_1_1 = var_1_0:getAIUseCardMOList()[arg_1_0.actEffectData.effectNum]

			if var_1_1 then
				var_1_1.custom_done = true
			end
		end

		FightController.instance:dispatchEvent(FightEvent.InvalidEnemyUsedCard, arg_1_0.actEffectData.effectNum)
		arg_1_0:onDone(true)

		return
	end

	FightPlayCardModel.instance:playCard(arg_1_0.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.InvalidUsedCard, arg_1_0.actEffectData.effectNum, arg_1_0.actEffectData.configEffect)
	arg_1_0:com_registTimer(arg_1_0._delayDone, 1 / FightModel.instance:getUISpeed())
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
