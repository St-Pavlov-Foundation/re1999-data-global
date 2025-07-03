module("modules.logic.fight.system.work.FightWorkEffectRedealCard", package.seeall)

local var_0_0 = class("FightWorkEffectRedealCard", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)
	arg_2_0:_playRedealCardEffect()
end

function var_0_0._playRedealCardEffect(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)

	local var_3_0 = arg_3_0.oldHandCard
	local var_3_1 = FightDataHelper.handCardMgr.handCard

	arg_3_0:com_registTimer(arg_3_0._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, var_3_0, var_3_1)
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
