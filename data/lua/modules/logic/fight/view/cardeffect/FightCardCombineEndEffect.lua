module("modules.logic.fight.view.cardeffect.FightCardCombineEndEffect", package.seeall)

local var_0_0 = class("FightCardCombineEndEffect", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if arg_1_1.preCombineIndex and arg_1_1.newCardCount > 0 then
		local var_1_0 = arg_1_1.preCombineIndex
		local var_1_1 = arg_1_1.preCardCount
		local var_1_2 = arg_1_1.handCardItemList
		local var_1_3 = arg_1_1.oldPosXList

		for iter_1_0 = 1, var_1_1 do
			recthelper.setAnchorX(var_1_2[iter_1_0].tr, var_1_3[iter_1_0])
		end

		arg_1_0._flow = FightCardCombineEffect.buildCombineEndFlow(var_1_0, var_1_1, var_1_1, var_1_2)

		arg_1_0._flow:registerDoneListener(arg_1_0._onMoveEnd, arg_1_0)
		arg_1_0._flow:start()
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onMoveEnd(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._flow then
		arg_3_0._flow:stop()
		arg_3_0._flow:unregisterDoneListener(arg_3_0._onBornEnd, arg_3_0)
	end
end

return var_0_0
