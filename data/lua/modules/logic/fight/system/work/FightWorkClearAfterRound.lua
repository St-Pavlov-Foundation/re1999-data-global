module("modules.logic.fight.system.work.FightWorkClearAfterRound", package.seeall)

local var_0_0 = class("FightWorkClearAfterRound", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	FightRoundSequence.roundTempData = {}

	FightPlayCardModel.instance:clearUsedCards()
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
