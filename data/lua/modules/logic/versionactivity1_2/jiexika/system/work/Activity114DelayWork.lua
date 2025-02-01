module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114DelayWork", package.seeall)

slot0 = class("Activity114DelayWork", Activity114BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._sec = slot1
end

function slot0.onStart(slot0, slot1)
	if slot0._sec then
		TaskDispatcher.runDelay(slot0.onDelay, slot0, slot0._sec)
	else
		slot0:onDone(true)
	end
end

function slot0.onDelay(slot0)
	TaskDispatcher.cancelTask(slot0.onDelay, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.onDelay, slot0)
end

return slot0
