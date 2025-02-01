module("modules.logic.scene.room.comp.RoomSceneTouchComp", package.seeall)

slot0 = class("RoomSceneTouchComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot3 = slot0._scene.go.sceneGO
	slot0._touchComp = MonoHelper.addLuaComOnceToGo(slot3, RoomTouchComp, slot3)
end

function slot0.setUIDragScreenScroll(slot0, slot1)
	if slot0._touchComp then
		slot0._touchComp:setUIDragScreenScroll(slot1)
	end
end

function slot0.onSceneClose(slot0)
	slot0._touchComp = nil
end

return slot0
