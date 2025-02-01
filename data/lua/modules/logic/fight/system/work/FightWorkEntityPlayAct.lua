module("modules.logic.fight.system.work.FightWorkEntityPlayAct", package.seeall)

slot0 = class("FightWorkEntityPlayAct", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._entity = slot1
	slot0._actName = slot2
end

function slot0.onStart(slot0, slot1)
	slot0:_playAnim()
end

function slot0._playAnim(slot0)
	if slot0._entity.spine and slot0._entity.spine:hasAnimation(slot0._actName) then
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 30)
		slot0._entity.spine:addAnimEventCallback(slot0._onAnimEvent, slot0)
		slot0._entity.spine:play(slot0._actName, false, true)

		slot0._entity.spine.lockAct = true
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3)
	if slot2 == SpineAnimEvent.ActionComplete then
		slot0._entity.spine.lockAct = false

		slot0._entity.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot0._entity:resetAnimState()
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	if slot0._entity.spine then
		slot0._entity.spine.lockAct = false

		slot0._entity.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	end

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
