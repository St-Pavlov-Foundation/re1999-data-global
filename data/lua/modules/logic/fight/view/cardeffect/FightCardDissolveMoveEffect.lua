module("modules.logic.fight.view.cardeffect.FightCardDissolveMoveEffect", package.seeall)

local var_0_0 = class("FightCardDissolveMoveEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._dt = var_0_2 / FightModel.instance:getUISpeed()

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.handCardItemList) do
		if not tabletool.indexOf(arg_1_1.dissolveCardIndexs, iter_1_0) then
			table.insert(var_1_0, iter_1_0)
		end
	end

	arg_1_0._dissolveCardIndexs = nil
	arg_1_0._moveCardFlow = FlowParallel.New()

	local var_1_1 = 1

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		local var_1_2 = arg_1_1.handCardItemList[iter_1_3].go
		local var_1_3 = arg_1_1.handCardItemList[iter_1_2].go

		if not gohelper.isNil(var_1_2) and not gohelper.isNil(var_1_3) and var_1_2 ~= var_1_3 then
			local var_1_4 = var_1_2.transform
			local var_1_5 = FlowSequence.New()

			var_1_5:addWork(WorkWaitSeconds.New(3 * var_1_1 * arg_1_0._dt))

			local var_1_6, var_1_7 = recthelper.getAnchor(var_1_3.transform)
			local var_1_8 = var_1_6 + 10

			var_1_5:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = var_1_4,
				to = var_1_8,
				t = arg_1_0._dt * 5
			}))
			var_1_5:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = var_1_4,
				to = var_1_6,
				t = arg_1_0._dt * 2
			}))
			arg_1_0._moveCardFlow:addWork(var_1_5)

			var_1_1 = var_1_1 + 1
		end
	end

	arg_1_0._moveCardFlow:registerDoneListener(arg_1_0._onWorkDone, arg_1_0)
	arg_1_0._moveCardFlow:start()
end

function var_0_0.onStop(arg_2_0)
	var_0_0.super.onStop(arg_2_0)
	arg_2_0._moveCardFlow:unregisterDoneListener(arg_2_0._onWorkDone, arg_2_0)

	if arg_2_0._moveCardFlow.status == WorkStatus.Running then
		arg_2_0._moveCardFlow:stop()
	end
end

function var_0_0._onWorkDone(arg_3_0)
	arg_3_0:onDone(true)
end

return var_0_0
