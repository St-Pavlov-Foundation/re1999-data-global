module("modules.logic.fight.system.work.FightWorkEffectUniversalCard", package.seeall)

local var_0_0 = class("FightWorkEffectUniversalCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)
	FightController.instance:dispatchEvent(FightEvent.UniversalAppear)
	arg_1_0:com_registTimer(arg_1_0._delayDone, 1.3 / FightModel.instance:getUISpeed())
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
