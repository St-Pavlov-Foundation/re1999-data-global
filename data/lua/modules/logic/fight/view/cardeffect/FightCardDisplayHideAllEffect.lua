module("modules.logic.fight.view.cardeffect.FightCardDisplayHideAllEffect", package.seeall)

slot0 = class("FightCardDisplayHideAllEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()
	slot2 = FlowParallel.New()

	for slot6, slot7 in ipairs(slot1.hideSkillItemGOs) do
		if slot7.activeSelf then
			slot2:addWork(TweenWork.New({
				from = 1,
				type = "DOFadeCanvasGroup",
				to = 0,
				go = slot7,
				t = slot0._dt * 10
			}))
			slot2:addWork(FunctionWork.New(slot0._hideLockObj, slot0, slot6))
		end
	end

	slot0._flow = FlowSequence.New()

	slot0._flow:addWork(WorkWaitSeconds.New(0.5))
	slot0._flow:addWork(slot2)
	slot0._flow:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._flow:start()
end

function slot0._hideLockObj(slot0, slot1)
	if slot0.context.hideSkillItemGOs[slot1] then
		gohelper.setActive(gohelper.findChild(slot2.transform.parent.gameObject, "lock"), false)
	end
end

function slot0.onStop(slot0)
	uv0.super.onStop(slot0)
	slot0._flow:unregisterDoneListener(slot0._onWorkDone, slot0)

	if slot0._flow.status == WorkStatus.Running then
		slot0._flow:stop()
	end
end

function slot0._onWorkDone(slot0)
	slot0:onDone(true)
end

return slot0
