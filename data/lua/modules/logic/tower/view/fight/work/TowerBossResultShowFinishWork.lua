module("modules.logic.tower.view.fight.work.TowerBossResultShowFinishWork", package.seeall)

slot0 = class("TowerBossResultShowFinishWork", BaseWork)
slot1 = 2

function slot0.ctor(slot0, slot1, slot2)
	slot0.goFinish = slot1
	slot0.audioId = slot2
end

function slot0.onStart(slot0)
	gohelper.setActive(slot0.goFinish, true)

	if slot0.audioId then
		AudioMgr.instance:trigger(slot0.audioId)
	end

	TaskDispatcher.runDelay(slot0._delayFinish, slot0, uv0)
end

function slot0._delayFinish(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	gohelper.setActive(slot0.goFinish, false)
	TaskDispatcher.cancelTask(slot0._delayFinish, slot0)
end

return slot0
