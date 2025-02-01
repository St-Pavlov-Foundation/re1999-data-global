module("modules.logic.scene.room.compwork.RoomSceneCommonCompWork", package.seeall)

slot0 = class("RoomSceneCommonCompWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._comp = slot1
end

function slot0.onStart(slot0, slot1)
	slot2 = slot1.sceneId
	slot3 = slot1.levelId

	if not slot0._comp then
		logError("RoomSceneCommonCompWork: 没有comp")
		slot0:onDone(true)

		return
	end

	if slot0._comp.init then
		slot0._comp:init(slot2, slot3)
		slot0:onDone(true)
	else
		logError(string.format("%s: 没有init", slot0._comp.__cname))
		slot0:onDone(true)
	end
end

return slot0
