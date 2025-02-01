module("modules.logic.scene.common.CommonSceneDirector", package.seeall)

slot0 = class("CommonSceneDirector", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.onSceneClose(slot0)
	slot0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	slot0._scene:onPrepared()
end

return slot0
