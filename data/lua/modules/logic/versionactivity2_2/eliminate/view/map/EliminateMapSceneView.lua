module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapSceneView", package.seeall)

slot0 = class("EliminateMapSceneView", BaseView)

function slot0.onOpen(slot0)
	slot0._oldSceneResList = slot0:getUserDataTb_()

	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, slot0.onSelectChapterChange, slot0)
	slot0:_initSceneRoot()
	slot0:_loadScene()
end

function slot0._initSceneRoot(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New(slot0.__cname)

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)

	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
end

function slot0.onSelectChapterChange(slot0)
	slot0:_loadScene()
end

function slot0._loadScene(slot0)
	slot0.chapterId = slot0.viewContainer.chapterId
	slot1 = UnityEngine.GameObject.New(tostring(slot0.chapterId))

	gohelper.addChild(slot0._sceneRoot, slot1)
	table.insert(slot0._oldSceneResList, slot0._chapterRoot)

	slot0._chapterRoot = slot1
	slot0._loader = PrefabInstantiate.Create(slot1)

	MainCameraMgr.instance:addView(slot0.viewName, slot0._initCamera, nil, slot0)
	slot0._loader:startLoad(slot0:getScenePath(), slot0._onSceneLoadEnd, slot0)
end

function slot0.getScenePath(slot0)
	return lua_eliminate_chapter.configDict[slot0.chapterId].map
end

function slot0._onSceneLoadEnd(slot0, slot1)
	if slot1 ~= slot0._loader then
		return
	end

	slot2 = slot0._loader:getInstGO()
	slot2.name = "Scene"

	transformhelper.setLocalPos(slot2.transform, 0, 0, 5)
	slot0:_disposeOldRes()
end

function slot0._disposeOldRes(slot0)
	for slot4, slot5 in ipairs(slot0._oldSceneResList) do
		gohelper.destroy(slot5)
	end

	slot0._oldSceneResList = slot0:getUserDataTb_()
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 5 * GameUtil.getAdapterScale(true)
end

function slot0.setSceneVisible(slot0, slot1)
	slot0._sceneVisible = slot1

	gohelper.setActive(slot0._sceneRoot, slot1)
end

function slot0.onDestroyView(slot0)
	slot0:_disposeOldRes()

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
