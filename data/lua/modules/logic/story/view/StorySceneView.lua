module("modules.logic.story.view.StorySceneView", package.seeall)

slot0 = class("StorySceneView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._cameraComp = GameSceneMgr.instance:getCurScene().camera
	slot0._sceneRoot = CameraMgr.instance:getSceneRoot()
end

function slot0.onOpen(slot0)
	slot0:_initScene()
end

function slot0.onClose(slot0)
	slot0:_disposeScene()
end

function slot0._initScene(slot0)
	slot0._sceneContainer = gohelper.create3d(slot0._sceneRoot, "StoryScene")

	if not lua_scene_level.configDict[slot0.viewParam.levelId] then
		return
	end

	slot0._sceneLoader = MultiAbLoader.New()

	slot0._sceneLoader:addPath(ResUrl.getSceneUrl(slot2.resName))
	slot0._sceneLoader:startLoad(function (slot0)
		uv0._assetItem = slot0:getAssetItem(uv1)

		if not uv0._assetItem then
			return
		end

		uv0._assetItem:Retain()

		if uv3 == 10101 and uv0.viewContainer:getStoryMainSceneView() then
			slot3:setSceneId(1)
			slot3:initSceneGo(gohelper.clone(uv0._assetItem:GetResource(uv1), uv0._sceneContainer, uv2.resName), uv2.resName)
		end
	end)
	slot0._cameraComp:setCameraTraceEnable(true)
	slot0._cameraComp:resetParam(lua_camera.configDict[slot2.cameraId])
	slot0._cameraComp:applyDirectly()
	slot0._cameraComp:setCameraTraceEnable(false)
	PostProcessingMgr.instance:setLocalBloomColor(Color.New(slot2.bloomR, slot2.bloomG, slot2.bloomB, slot2.bloomA))
end

function slot0._disposeScene(slot0)
	if slot0._sceneContainer then
		gohelper.destroy(slot0._sceneContainer)

		slot0._sceneContainer = nil
	end

	if slot0._assetItem then
		slot0._assetItem:Release()

		slot0._assetItem = nil
	end

	if slot0._sceneLoader then
		slot0._sceneLoader:dispose()

		slot0._sceneLoader = nil
	end

	slot0._cameraComp:setCameraTraceEnable(true)
	slot0._cameraComp:resetParam()
	slot0._cameraComp:applyDirectly()
	slot0._cameraComp:setCameraTraceEnable(false)

	slot2 = lua_scene_level.configDict[GameSceneMgr.instance:getCurLevelId()]

	PostProcessingMgr.instance:setLocalBloomColor(Color.New(slot2.bloomR, slot2.bloomG, slot2.bloomB, slot2.bloomA))
end

return slot0
