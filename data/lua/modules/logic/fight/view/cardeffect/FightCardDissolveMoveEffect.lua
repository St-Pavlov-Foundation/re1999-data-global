module("modules.logic.fight.view.cardeffect.FightCardDissolveMoveEffect", package.seeall)

slot0 = class("FightCardDissolveMoveEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.handCardItemList) do
		if not tabletool.indexOf(slot1.dissolveCardIndexs, slot6) then
			table.insert(slot2, slot6)
		end
	end

	slot0._dissolveCardIndexs = nil
	slot0._moveCardFlow = FlowParallel.New()
	slot3 = 1

	for slot7, slot8 in ipairs(slot2) do
		slot10 = slot1.handCardItemList[slot7].go

		if not gohelper.isNil(slot1.handCardItemList[slot8].go) and not gohelper.isNil(slot10) and slot9 ~= slot10 then
			slot11 = slot9.transform
			slot12 = FlowSequence.New()

			slot12:addWork(WorkWaitSeconds.New(3 * slot3 * slot0._dt))

			slot13, slot14 = recthelper.getAnchor(slot10.transform)

			slot12:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot11,
				to = slot13 + 10,
				t = slot0._dt * 5
			}))
			slot12:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot11,
				to = slot13,
				t = slot0._dt * 2
			}))
			slot0._moveCardFlow:addWork(slot12)

			slot3 = slot3 + 1
		end
	end

	slot0._moveCardFlow:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._moveCardFlow:start()
end

function slot0.onStop(slot0)
	uv0.super.onStop(slot0)
	slot0._moveCardFlow:unregisterDoneListener(slot0._onWorkDone, slot0)

	if slot0._moveCardFlow.status == WorkStatus.Running then
		slot0._moveCardFlow:stop()
	end
end

function slot0._onWorkDone(slot0)
	slot0:onDone(true)
end

return slot0
