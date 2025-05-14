module("modules.logic.fight.view.cardeffect.FigthCardDistributeEffect", package.seeall)

local var_0_0 = class("FigthCardDistributeEffect", BaseWork)
local var_0_1 = 1

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if arg_1_1.playCardContainer then
		gohelper.onceAddComponent(arg_1_1.playCardContainer, typeof(UnityEngine.CanvasGroup)).alpha = 0
	end

	arg_1_0._flow = FlowParallel.New()

	local var_1_0 = 0.033 * var_0_1 / FightModel.instance:getUISpeed()
	local var_1_1 = arg_1_1.preCardCount
	local var_1_2 = arg_1_1.newCardCount

	for iter_1_0 = 1, var_1_2 do
		local var_1_3 = var_1_1 + iter_1_0
		local var_1_4 = arg_1_1.handCardItemList[var_1_3]

		if var_1_4 then
			gohelper.setActive(var_1_4.go, false)

			local var_1_5 = FlowSequence.New()

			var_1_5:addWork(FunctionWork.New(function()
				gohelper.setActive(var_1_4.go, false)
			end))

			local var_1_6 = (1 + 3 * (iter_1_0 - 1)) * var_1_0

			if var_1_6 > 0 then
				var_1_5:addWork(WorkWaitSeconds.New(var_1_6))
			end

			local var_1_7 = FightViewHandCard.calcCardPosX(var_1_3)
			local var_1_8 = var_1_7 + 60
			local var_1_9 = var_1_7 - 1000

			var_1_5:addWork(FunctionWork.New(function()
				gohelper.onceAddComponent(var_1_4.go, gohelper.Type_CanvasGroup).alpha = 0

				gohelper.setActive(var_1_4.go, true)
				recthelper.setAnchorX(var_1_4.tr, var_1_9)
			end))

			local var_1_10 = FlowParallel.New()

			var_1_10:addWork(TweenWork.New({
				from = 0,
				type = "DOFadeCanvasGroup",
				to = 1,
				go = var_1_4.go,
				t = var_1_0 * 8,
				ease = EaseType.linear
			}))
			var_1_10:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = var_1_4.tr,
				to = var_1_8,
				t = var_1_0 * 8,
				ease = EaseType.InOutSine
			}))
			var_1_5:addWork(var_1_10)
			var_1_5:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = var_1_4.tr,
				to = var_1_7,
				t = var_1_0 * 4,
				ease = EaseType.OutCubic
			}))
			arg_1_0._flow:addWork(var_1_5)
		end
	end

	if var_1_2 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightDistribute)
	end

	arg_1_0._flow:registerDoneListener(arg_1_0._onCardDone, arg_1_0)
	arg_1_0._flow:start(arg_1_1)
end

function var_0_0._onCardDone(arg_4_0)
	arg_4_0._flow:unregisterDoneListener(arg_4_0._onCardDone, arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	arg_5_0._flow:unregisterDoneListener(arg_5_0._onCardDone, arg_5_0)
	arg_5_0._flow:stop()
end

return var_0_0
