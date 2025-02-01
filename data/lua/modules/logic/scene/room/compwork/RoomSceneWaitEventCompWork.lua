module("modules.logic.scene.room.compwork.RoomSceneWaitEventCompWork", package.seeall)

slot0 = class("RoomSceneWaitEventCompWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._comp = slot1
	slot0._event = slot2
end

function slot0.onStart(slot0, slot1)
	slot2 = slot1.sceneId
	slot3 = slot1.levelId

	if not slot0._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")
		slot0:onDone(true)

		return
	end

	if slot0._comp.init then
		slot0._comp:registerCallback(slot0._event, slot0._onEvent, slot0)
		slot0._comp:init(slot2, slot3)
	else
		logError(string.format("%s: 没有init", slot0._comp.__cname))
		slot0:onDone(true)
	end
end

function slot0._onEvent(slot0)
	if not slot0._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")

		return
	end

	slot0._comp:unregisterCallback(slot0._event, slot0._onEvent, slot0)
	slot0:onDone(true)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)

	if not slot0._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")

		return
	end

	slot0._comp:unregisterCallback(slot0._event, slot0._onEvent, slot0)
end

return slot0
