module("modules.logic.fight.view.cardeffect.FightCardDisplayEndEffect", package.seeall)

slot0 = class("FightCardDisplayEndEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()
	slot0._flow = FlowSequence.New()

	if slot1.skillItemGO then
		slot0._flow:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = slot1.skillItemGO,
			t = slot0._dt * 5
		}))
	end

	slot3 = slot1.skillTipsGO.transform

	slot0._flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot3,
		to = recthelper.getWidth(slot1.waitingAreaGO.transform) + recthelper.getWidth(slot3),
		t = slot0._dt * 3
	}))
	slot0._flow:addWork(FunctionWork.New(function ()
		gohelper.setActive(uv0.skillItemGO, false)
		gohelper.setActive(uv0.skillTipsGO, false)
	end))
	slot0._flow:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._flow:start()
end

function slot0.onStop(slot0)
	uv0.super.onStop(slot0)

	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onWorkDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end
end

function slot0._onWorkDone(slot0)
	slot0:onDone(true)
end

return slot0
