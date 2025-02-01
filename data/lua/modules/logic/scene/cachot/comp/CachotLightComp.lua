module("modules.logic.scene.cachot.comp.CachotLightComp", package.seeall)

slot0 = class("CachotLightComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._preloadComp = slot0._scene.preloader
	slot0._lightGo = gohelper.create3d(slot0._scene:getSceneContainerGO(), "Light")
	slot0._lightAnim = slot0._preloadComp:getResInst(CachotScenePreloader.LightPath, slot0._lightGo):GetComponent(typeof(UnityEngine.Animator))

	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, slot0._playClickAnim, slot0)
end

function slot0._playClickAnim(slot0)
	slot0._lightAnim:Play("open", 0, 0)
end

function slot0.onSceneClose(slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, slot0._playClickAnim, slot0)

	if slot0._lightGo then
		gohelper.destroy(slot0._lightGo)

		slot0._lightGo = nil
	end

	slot0._preloadComp = nil
	slot0._scene = nil
	slot0._lightAnim = nil
end

return slot0
