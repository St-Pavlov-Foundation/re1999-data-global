module("modules.logic.explore.map.unit.ExploreDisjunctorUnit", package.seeall)

slot0 = class("ExploreDisjunctorUnit", ExploreBaseDisplayUnit)

function slot0.onTrigger(slot0)
	uv0.super.onTrigger(slot0)
	slot0:doRotate(slot0.mo.unitDir, ExploreHelper.getDir(slot0.mo.unitDir + 90), 0.5)

	slot0._lockTrigger = true

	TaskDispatcher.runDelay(slot0._delayUnlock, slot0, 2.5)
end

function slot0.tryTrigger(slot0, ...)
	if slot0._lockTrigger then
		return
	end

	uv0.super.tryTrigger(slot0, ...)
end

function slot0._delayUnlock(slot0)
	slot0._lockTrigger = false
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayUnlock, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
