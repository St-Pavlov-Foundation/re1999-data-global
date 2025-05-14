module("modules.logic.fight.system.work.FightWorkEffectUniversalCard", package.seeall)

local var_0_0 = class("FightWorkEffectUniversalCard", FightEffectBase)
local var_0_1 = "ui/viewres/fight/ui_effect_flusheddown.prefab"

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	FightCardModel.instance:clearCardOps()
	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)

	local var_1_0 = FightCardInfoMO.New()

	var_1_0:init({
		uid = "0",
		skillId = arg_1_0._actEffectMO.effectNum
	})
	FightController.instance:dispatchEvent(FightEvent.UniversalAppear, var_1_0)
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
