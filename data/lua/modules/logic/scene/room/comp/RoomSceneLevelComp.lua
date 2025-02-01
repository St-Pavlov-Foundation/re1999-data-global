module("modules.logic.scene.room.comp.RoomSceneLevelComp", package.seeall)

slot0 = class("RoomSceneLevelComp", CommonSceneLevelComp)

function slot0.init(slot0, slot1, slot2)
	slot0:loadLevel(slot2)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._sceneId = slot1
	slot0._levelId = slot2
end

return slot0
