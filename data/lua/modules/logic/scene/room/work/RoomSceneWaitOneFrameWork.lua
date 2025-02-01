module("modules.logic.scene.room.work.RoomSceneWaitOneFrameWork", package.seeall)

slot0 = class("RoomSceneWaitOneFrameWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._scene = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._oneFrame, slot0, 0)
end

function slot0._oneFrame(slot0)
	slot0._scene = nil

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	slot0._scene = nil
end

return slot0
