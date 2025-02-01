module("modules.logic.scene.pushbox.comp.PushBoxSceneDirector", package.seeall)

slot0 = class("PushBoxSceneDirector", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene.preloader:startPreload()
end

function slot0.onPushBoxAssetLoadFinish(slot0)
	slot0:_onRefreshActivityData()
end

function slot0._onRefreshActivityData(slot0)
	slot0._scene:onPrepared()
end

function slot0.onSceneClose(slot0)
end

return slot0
