module("modules.logic.fight.system.work.FightWorkAfterRedealCard", package.seeall)

local var_0_0 = class("FightWorkAfterRedealCard", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0.oldCardList = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function var_0_0.onStart(arg_2_0)
	if FightModel.instance:getVersion() < 5 then
		arg_2_0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)
	arg_2_0:com_registTimer(arg_2_0._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())

	local var_2_0 = arg_2_0.oldCardList
	local var_2_1 = FightDataHelper.handCardMgr.handCard

	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, var_2_0, var_2_1)
end

return var_0_0
