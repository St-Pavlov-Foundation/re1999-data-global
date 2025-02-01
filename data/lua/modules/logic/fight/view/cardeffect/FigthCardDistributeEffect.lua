module("modules.logic.fight.view.cardeffect.FigthCardDistributeEffect", package.seeall)

slot0 = class("FigthCardDistributeEffect", BaseWork)
slot1 = 1

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot1.playCardContainer then
		gohelper.onceAddComponent(slot1.playCardContainer, typeof(UnityEngine.CanvasGroup)).alpha = 0
	end

	slot0._flow = FlowParallel.New()
	slot2 = 0.033 * uv1 / FightModel.instance:getUISpeed()

	for slot8 = 1, slot1.newCardCount do
		if slot1.handCardItemList[slot1.preCardCount + slot8] then
			gohelper.setActive(slot10.go, false)

			slot11 = FlowSequence.New()

			slot11:addWork(FunctionWork.New(function ()
				gohelper.setActive(uv0.go, false)
			end))

			if (1 + 3 * (slot8 - 1)) * slot2 > 0 then
				slot11:addWork(WorkWaitSeconds.New(slot12))
			end

			slot13 = FightViewHandCard.calcCardPosX(slot9)
			slot15 = slot13 - 1000

			slot11:addWork(FunctionWork.New(function ()
				gohelper.onceAddComponent(uv0.go, gohelper.Type_CanvasGroup).alpha = 0

				gohelper.setActive(uv0.go, true)
				recthelper.setAnchorX(uv0.tr, uv1)
			end))

			slot16 = FlowParallel.New()

			slot16:addWork(TweenWork.New({
				from = 0,
				type = "DOFadeCanvasGroup",
				to = 1,
				go = slot10.go,
				t = slot2 * 8,
				ease = EaseType.linear
			}))
			slot16:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot10.tr,
				to = slot13 + 60,
				t = slot2 * 8,
				ease = EaseType.InOutSine
			}))
			slot11:addWork(slot16)
			slot11:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot10.tr,
				to = slot13,
				t = slot2 * 4,
				ease = EaseType.OutCubic
			}))
			slot0._flow:addWork(slot11)
		end
	end

	if slot4 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightDistribute)
	end

	slot0._flow:registerDoneListener(slot0._onCardDone, slot0)
	slot0._flow:start(slot1)
end

function slot0._onCardDone(slot0)
	slot0._flow:unregisterDoneListener(slot0._onCardDone, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	slot0._flow:unregisterDoneListener(slot0._onCardDone, slot0)
	slot0._flow:stop()
end

return slot0
