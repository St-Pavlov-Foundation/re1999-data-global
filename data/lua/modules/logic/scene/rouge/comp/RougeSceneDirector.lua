module("modules.logic.scene.rouge.comp.RougeSceneDirector", package.seeall)

slot0 = class("RougeSceneDirector", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, slot0.onMapLoadDone, slot0)
end

function slot0.onMapLoadDone(slot0)
	slot0._scene:onPrepared()
end

function slot0.onSceneClose(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, slot0.onMapLoadDone, slot0)
end

return slot0
