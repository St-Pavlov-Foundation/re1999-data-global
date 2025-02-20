module("modules.logic.tower.view.fight.work.TowerBossResultShowResultWork", package.seeall)

slot0 = class("TowerBossResultShowResultWork", BaseWork)
slot1 = 1

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.goResult = slot1
	slot0.audioId = slot2
	slot0.callback = slot3
	slot0.callbackObj = slot4
end

function slot0.onStart(slot0)
	gohelper.setActive(slot0.goResult, true)

	if slot0.audioId then
		AudioMgr.instance:trigger(slot0.audioId)
	end

	if slot0.callback then
		slot0.callback(slot0.callbackObj)
	end

	TaskDispatcher.runDelay(slot0._delayFinish, slot0, uv0)
end

function slot0._delayFinish(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayFinish, slot0)
end

return slot0
