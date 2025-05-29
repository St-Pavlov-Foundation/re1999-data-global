module("modules.logic.fight.system.work.FightWorkAfterRedealCard", package.seeall)

local var_0_0 = class("FightWorkAfterRedealCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if FightModel.instance:getVersion() < 5 then
		arg_1_0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)

	local var_1_0 = FightDataHelper.coverData(FightCardModel.instance:getHandCards())
	local var_1_1 = FightHelper.buildInfoMOs(arg_1_0._actEffectMO.cardInfoList, FightCardInfoMO)

	FightCardModel.instance:coverCard(var_1_1)
	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, var_1_0, var_1_1)
end

return var_0_0
