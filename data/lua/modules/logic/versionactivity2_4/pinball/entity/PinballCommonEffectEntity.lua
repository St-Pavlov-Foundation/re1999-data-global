module("modules.logic.versionactivity2_4.pinball.entity.PinballCommonEffectEntity", package.seeall)

slot0 = class("PinballCommonEffectEntity", PinballColliderEntity)

function slot0.canHit(slot0)
	return false
end

function slot0.initByCo(slot0)
end

function slot0.setScale(slot0, slot1)
	slot0.scale = slot1

	transformhelper.setLocalScale(slot0.trans, slot0.scale, slot0.scale, slot0.scale)
end

function slot0.setDelayDispose(slot0, slot1)
	TaskDispatcher.runDelay(slot0.markDead, slot0, slot1 or 1)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.markDead, slot0)
end

return slot0
