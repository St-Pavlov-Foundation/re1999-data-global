module("modules.logic.versionactivity2_4.pinball.entity.PinballResEntity", package.seeall)

slot0 = class("PinballResEntity", PinballColliderEntity)

function slot0.doHit(slot0, slot1)
	if slot0.isDead then
		return
	end

	slot0:onHitCount(slot1)

	if slot0.isDead then
		slot0._waitAnim = true

		TaskDispatcher.runDelay(slot0._delayDestory, slot0, 1.5)
		slot0:playAnim("disapper")
	else
		slot0:playAnim("hit")
	end
end

function slot0.onHitCount(slot0, slot1)
end

function slot0._delayDestory(slot0)
	gohelper.destroy(slot0.go)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayDestory, slot0)
end

function slot0.dispose(slot0)
	if not slot0._waitAnim then
		gohelper.destroy(slot0.go)
	end
end

return slot0
