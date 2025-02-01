module("modules.logic.versionactivity2_2.lopera.view.LoperaBaseSceneView", package.seeall)

slot0 = class("LoperaBaseSceneView", BaseView)

function slot0.onOpen(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New(slot0.__cname)

	slot0:beforeLoadScene()
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)

	slot0._loader = PrefabInstantiate.Create(slot0._sceneRoot)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, 5, 0)
	MainCameraMgr.instance:addView(slot0.viewName, slot0._initCamera, nil, slot0)
	slot0._loader:startLoad(slot0:getScenePath(), slot0._onSceneLoadEnd, slot0)
end

function slot0.beforeLoadScene(slot0)
end

function slot0.getScenePath(slot0)
	return ""
end

function slot0._onSceneLoadEnd(slot0)
	slot1 = slot0._loader:getInstGO()
	slot1.name = "Scene"

	transformhelper.setLocalPos(slot1.transform, 0, 0, 5)
	slot0:onSceneLoaded(slot1)
end

function slot0.onSceneLoaded(slot0, slot1)
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 5 * GameUtil.getAdapterScale(true)
end

function slot0.setSceneVisible(slot0, slot1)
	gohelper.setActive(slot0._sceneRoot, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

return slot0
