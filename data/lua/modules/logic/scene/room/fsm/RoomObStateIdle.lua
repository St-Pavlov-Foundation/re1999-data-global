module("modules.logic.scene.room.fsm.RoomObStateIdle", package.seeall)

slot0 = class("RoomObStateIdle", SimpleFSMBaseState)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.onEnter(slot0)
	uv0.super.onEnter(slot0)
end

function slot0.onLeave(slot0)
	uv0.super.onLeave(slot0)
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
