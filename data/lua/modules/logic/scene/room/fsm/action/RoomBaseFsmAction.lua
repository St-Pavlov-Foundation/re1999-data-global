module("modules.logic.scene.room.fsm.action.RoomBaseFsmAction", package.seeall)

slot0 = class("RoomBaseFsmAction")

function slot0.ctor(slot0, slot1)
	slot0.fsmTransition = slot1
end

function slot0.start(slot0, slot1)
	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0:onStart(slot1)
end

function slot0.onStart(slot0, slot1)
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
