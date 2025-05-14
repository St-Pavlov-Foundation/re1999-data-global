﻿module("modules.logic.fight.system.work.FightWorkAddSpHandCard320", package.seeall)

local var_0_0 = class("FightWorkAddSpHandCard320", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_1_0 = FightCardInfoMO.New()

	var_1_0:init(arg_1_0._actEffectMO.cardInfo)

	local var_1_1 = FightCardModel.instance:getHandCards()

	table.insert(var_1_1, var_1_0)
	FightCardModel.instance:coverCard(var_1_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
	FightController.instance:dispatchEvent(FightEvent.SpCardAdd, #var_1_1)
	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, 0.7 / FightModel.instance:getUISpeed())
end

function var_0_0.clearWork(arg_2_0)
	if arg_2_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
