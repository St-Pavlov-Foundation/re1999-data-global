module("modules.logic.fight.view.cardeffect.FightCardDisplayEffect", package.seeall)

slot0 = class("FightCardDisplayEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()

	gohelper.setActive(slot1.skillTipsGO, true)

	slot2 = slot1.skillTipsGO.transform
	slot4 = slot1.skillItemGO.transform.parent
	slot7 = recthelper.getAnchorX(slot4) - recthelper.getWidth(slot4) * 0.5

	recthelper.setAnchorX(slot2, 1100 + recthelper.getWidth(slot2))

	slot8 = FlowSequence.New()

	slot8:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot2,
		to = slot7 - 47.5,
		t = slot0._dt * 7
	}))
	slot8:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot2,
		to = slot7 - 34.2,
		t = slot0._dt * 3
	}))

	slot9 = slot1.skillItemGO.transform
	slot10 = FlowSequence.New()

	slot10:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = -15,
		toy = 22,
		tr = slot9,
		t = slot0._dt * 6
	}))

	slot11 = FlowSequence.New()

	slot11:addWork(TweenWork.New({
		to = 0.922,
		type = "DOScale",
		tr = slot9,
		t = slot0._dt * 3
	}))
	slot11:addWork(TweenWork.New({
		to = 1.2,
		type = "DOScale",
		tr = slot9,
		t = slot0._dt * 3
	}))

	slot0._flow = FlowParallel.New()

	slot0._flow:addWork(slot8)
	slot0._flow:addWork(slot10)
	slot0._flow:addWork(slot11)
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
