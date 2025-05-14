module("modules.logic.fight.system.work.FightWorkEffectRedealCard", package.seeall)

local var_0_0 = class("FightWorkEffectRedealCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightCardModel.instance:clearCardOps()
	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)

	if FightCardModel.instance.redealCardInfoList then
		arg_1_0:_playRedealCardEffect()
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._playRedealCardEffect(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)

	local var_2_0 = FightCardModel.instance:getHandCards()
	local var_2_1 = FightCardModel.instance.redealCardInfoList

	FightCardModel.instance.redealCardInfoList = nil

	FightCardModel.instance:coverCard(var_2_1)

	if FightModel.instance:getVersion() < 4 then
		FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(var_2_1))
	end

	arg_2_0:com_registTimer(arg_2_0._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, var_2_0, var_2_1)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
