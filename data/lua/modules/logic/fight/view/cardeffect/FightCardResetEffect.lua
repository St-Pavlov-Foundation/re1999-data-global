module("modules.logic.fight.view.cardeffect.FightCardResetEffect", package.seeall)

local var_0_0 = class("FightCardResetEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	TaskDispatcher.runDelay(arg_1_0.onDelayDone, arg_1_0, 1)

	arg_1_0._dt = var_0_2 / FightModel.instance:getUISpeed()
	arg_1_0.flow = FightWorkFlowSequence.New()

	local var_1_0 = arg_1_0.flow

	var_1_0:registWork(FightWorkSendEvent, FightEvent.CorrectHandCardScale)

	local var_1_1 = arg_1_0.context.view.viewContainer.fightViewHandCard._handCardItemList

	if arg_1_1.curIndex2OriginHandCardIndex then
		local var_1_2 = var_1_0:registWork(FightWorkFlowParallel)

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_3 = iter_1_1.go
			local var_1_4 = iter_1_1.cardInfoMO
			local var_1_5 = arg_1_1.curIndex2OriginHandCardIndex[iter_1_0]

			if var_1_5 then
				local var_1_6 = FightViewHandCard.calcCardPosX(var_1_5)

				var_1_2:registWork(FightTweenWork, {
					type = "DOAnchorPos",
					toy = 0,
					tr = var_1_3.transform,
					tox = var_1_6,
					t = arg_1_0._dt * 4
				})
			end
		end
	end

	var_1_0:registWork(FightWorkSendEvent, FightEvent.UpdateHandCards)
	var_1_0:registFinishCallback(arg_1_0._onWorkDone, arg_1_0)
	var_1_0:start()
end

function var_0_0.onDelayDone(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.UpdateHandCards)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.onDelayDone, arg_3_0)

	if arg_3_0.flow then
		arg_3_0.flow:disposeSelf()

		arg_3_0.flow = nil
	end
end

function var_0_0._onWorkDone(arg_4_0)
	arg_4_0:onDone(true)
end

return var_0_0
