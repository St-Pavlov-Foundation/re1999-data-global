module("modules.logic.versionactivity.view.VersionActivityDungeonMapScene", package.seeall)

slot0 = class("VersionActivityDungeonMapScene", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")
	slot0._gotoptipsbg = gohelper.findChild(slot0.viewGO, "#go_main/#go_toptipsbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	slot0._tempVector = Vector3()
	slot0._dragDeltaPos = Vector3()

	slot0:_initCamera()
	slot0:_initMapRootNode()
	slot0:_initDrag()
end

function slot0._initDrag(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gofullscreen)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		slot0:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, slot0)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		slot0:_rebuildScene()
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._dragBeginPos = slot0:getDragWorldPos(slot2)

	if slot0._sceneTrans then
		slot0._beginDragPos = slot0._sceneTrans.localPosition
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._dragBeginPos = nil
	slot0._beginDragPos = nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
	slot0:drag(slot0:getDragWorldPos(slot2) - slot0._dragBeginPos)
end

function slot0.drag(slot0, slot1)
	if not slot0._sceneTrans or not slot0._beginDragPos then
		return
	end

	slot0._dragDeltaPos.x = slot1.x
	slot0._dragDeltaPos.y = slot1.y

	slot0:setScenePosSafety(slot0:vectorAdd(slot0._beginDragPos, slot0._dragDeltaPos))
	slot0:_updateElementArrow()
end

function slot0._updateElementArrow(slot0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function slot0.setScenePosSafety(slot0, slot1, slot2)
	if not slot0._sceneTrans then
		return
	end

	if slot1.x < slot0._mapMinX then
		slot1.x = slot0._mapMinX
	elseif slot0._mapMaxX < slot1.x then
		slot1.x = slot0._mapMaxX
	end

	if slot1.y < slot0._mapMinY then
		slot1.y = slot0._mapMinY
	elseif slot0._mapMaxY < slot1.y then
		slot1.y = slot0._mapMaxY
	end

	slot0._targetPos = slot1

	if slot2 then
		ZProj.TweenHelper.DOLocalMove(slot0._sceneTrans, slot1.x, slot1.y, 0, slot0._tweenTime or 0.26, slot0._localMoveDone, slot0, nil, EaseType.InOutQuart)
	else
		slot0._sceneTrans.localPosition = slot1
	end

	slot0:_updateElementArrow()
end

function slot0._localMoveDone(slot0)
	slot0:_updateElementArrow()
end

function slot0.vectorAdd(slot0, slot1, slot2)
	slot3 = slot0._tempVector
	slot3.x = slot1.x + slot2.x
	slot3.y = slot1.y + slot2.y

	return slot3
end

function slot0.getDragWorldPos(slot0, slot1)
	return SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot1.position, CameraMgr.instance:getMainCamera(), slot0._gofullscreen.transform.position)
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = VersionActivityEnum.DungeonMapCameraSize * GameUtil.getAdapterScale()
end

function slot0._resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false
end

function slot0._initMapRootNode(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("VersionActivityDungeonMapScene")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.getSceneGo(slot0)
	return slot0._sceneGo
end

function slot0.refreshMap(slot0)
	slot0._mapCfg = VersionActivityDungeonController.instance:getEpisodeMapConfig(slot0.activityDungeonMo.episodeId)

	if slot0._mapCfg.id == slot0._lastLoadMapId then
		slot0:refreshHardMapEffectAndAudio()

		slot0.dotTween = nil

		return
	end

	slot0._lastLoadMapId = slot0._mapCfg.id

	slot0:loadMap()
end

function slot0.loadMap(slot0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	if slot0.loadedDone then
		slot0._oldMapLoader = slot0._mapLoader
		slot0._oldSceneGo = slot0._sceneGo
		slot0._mapLoader = nil
	end

	if slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end

	slot0._tempMapCfg = nil
	slot0.loadedDone = false
	slot0._mapLoader = MultiAbLoader.New()
	slot1 = {}

	slot0:buildLoadRes(slot1, slot0._mapCfg)

	slot0._canvasUrl = slot1[1]
	slot0._interactiveItemUrl = slot1[2]
	slot0._sceneUrl = slot1[3]
	slot0._mapAudioUrl = slot1[4]
	slot0._mapLightUrl = slot1[5]
	slot0._fogUrl = slot1[6]

	slot0._mapLoader:addPath(slot0._sceneUrl)
	slot0._mapLoader:addPath(slot0._canvasUrl)
	slot0._mapLoader:addPath(slot0._interactiveItemUrl)
	slot0._mapLoader:addPath(slot0._mapAudioUrl)
	slot0._mapLoader:addPath(slot0._mapLightUrl)
	slot0._mapLoader:addPath(slot0._fogUrl)
	slot0._mapLoader:startLoad(slot0._loadSceneFinish, slot0)
end

function slot0._loadSceneFinish(slot0)
	slot0.loadedDone = true

	slot0:disposeOldMap()

	slot1 = slot0._sceneUrl
	slot0._sceneGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneRoot, slot0._mapCfg.id)
	slot0._sceneTrans = slot0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		slot0._mapCfg,
		slot0._sceneGo,
		slot0
	})
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowMap)

	slot0.goFogEffect = gohelper.clone(slot0._mapLoader:getAssetItem(slot0._fogUrl):GetResource(slot0._fogUrl), slot0._sceneGo)
	slot0.goRainEffect = gohelper.findChild(slot0._sceneGo, "SceneEffect")

	gohelper.setActive(gohelper.findChild(slot0._sceneGo, "SceneEffect/big"), true)
	slot0:refreshHardMapEffectAndAudio()
	slot0:_initScene()
	slot0:_initCanvas()
	slot0:_addAllAudio()
	TaskDispatcher.runDelay(slot0._addMapLight, slot0, 0.3)
end

function slot0._addAllAudio(slot0)
	slot0:_addMapAudio()
end

function slot0.buildLoadRes(slot0, slot1, slot2)
	table.insert(slot1, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(slot1, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")
	table.insert(slot1, ResUrl.getDungeonMapRes(slot2.res))
	table.insert(slot1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_1_1.prefab")
	table.insert(slot1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(slot1, "scenes/m_s14_hddt_hd01/prefab/s08_hddt_hd_01_fog.prefab")
end

function slot0._disposeScene(slot0)
	slot0._oldScenePos = slot0._targetPos
	slot0._tempMapCfg = slot0._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if slot0._mapAudioGo then
		slot0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if slot0._sceneGo then
		gohelper.destroy(slot0._sceneGo)

		slot0._sceneGo = nil
	end

	slot0._sceneTrans = nil
	slot0._elementRoot = nil

	if slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end

	TaskDispatcher.cancelTask(slot0._addMapLight, slot0)
	TaskDispatcher.cancelTask(slot0._addAllAudio, slot0)

	slot0._mapAudioGo = nil
end

function slot0._rebuildScene(slot0)
	slot0:loadMap(slot0._tempMapCfg)

	slot0._tempMapCfg = nil
end

function slot0._addMapLight(slot0)
	slot1 = slot0._mapLightUrl

	gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function slot0._addMapAudio(slot0)
	slot1 = slot0._mapAudioUrl
	slot0._mapAudioGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneGo, "audio")

	gohelper.addChild(slot0._sceneGo, slot0._mapAudioGo)
	gohelper.setActive(slot0._mapAudioGo, true)
	transformhelper.setLocalPos(slot0._mapAudioGo.transform, 0, 0, 0)

	if string.nilorempty(slot0._mapCfg.areaAudio) then
		return
	end

	slot5 = gohelper.findChild(slot0._mapAudioGo, "audio")

	if slot4 == "all" then
		for slot11 = 1, slot5.transform.childCount do
			gohelper.setActive(slot6:GetChild(slot11 - 1).gameObject, true)
		end

		return
	end

	for slot10, slot11 in ipairs(string.split(slot4, "#")) do
		gohelper.setActive(gohelper.findChild(slot5, slot11), true)
	end
end

function slot0._initCanvas(slot0)
	slot0._sceneCanvasGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot0._canvasUrl):GetResource(slot0._canvasUrl), slot0._sceneGo)
	slot0._sceneCanvas = slot0._sceneCanvasGo:GetComponent("Canvas")
	slot0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	slot0._itemPrefab = slot0._mapLoader:getAssetItem(slot0._interactiveItemUrl):GetResource(slot0._interactiveItemUrl)
end

function slot0.getInteractiveItem(slot0)
	slot0._uiGo = gohelper.clone(slot0._itemPrefab, slot0._sceneCanvasGo)
	slot0._interactiveItem = MonoHelper.addLuaComOnceToGo(slot0._uiGo, DungeonMapInteractiveItem)

	slot0._interactiveItem:setBtnClosePosZ(-5)
	gohelper.setActive(slot0._uiGo, false)

	return slot0._interactiveItem
end

function slot0.showInteractiveItem(slot0)
	return not gohelper.isNil(slot0._uiGo)
end

function slot0._initScene(slot0)
	slot0._mapSize = gohelper.findChild(slot0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size
	slot3 = nil
	slot5 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot8 = VersionActivityEnum.DungeonMapCameraSize / (CameraMgr.instance:getUICamera() and slot6.orthographicSize or 5)
	slot9 = slot5[1] * slot4 * slot8
	slot10 = slot5[3] * slot4 * slot8
	slot0._viewWidth = math.abs(slot10.x - slot9.x)
	slot0._viewHeight = math.abs(slot10.y - slot9.y)
	slot0._mapMinX = slot9.x - (slot0._mapSize.x - slot0._viewWidth)
	slot0._mapMaxX = slot9.x
	slot0._mapMinY = slot9.y
	slot0._mapMaxY = slot9.y + slot0._mapSize.y - slot0._viewHeight

	if slot0._oldScenePos then
		slot0._sceneTrans.localPosition = slot0._oldScenePos
	end

	if slot0.dotTween then
		slot0:_setInitPos(false)
	else
		slot0:_setInitPos(slot0._oldScenePos)
	end

	slot0.dotTween = nil
	slot0._oldScenePos = nil
end

function slot0._setInitPos(slot0, slot1)
	if not slot0._mapCfg then
		return
	end

	slot3 = string.splitToNumber(slot0._mapCfg.initPos, "#")

	slot0:setScenePosSafety(Vector3(slot3[1], slot3[2], 0), slot1)
end

function slot0.disposeOldMap(slot0)
	if slot0._sceneTrans then
		slot0._oldScenePos = slot0._sceneTrans.localPosition
	else
		slot0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, slot0.viewName)

	if slot0._oldSceneGo then
		gohelper.destroy(slot0._oldSceneGo)

		slot0._oldSceneGo = nil
	end

	if slot0._mapAudioGo then
		slot0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if slot0._oldMapLoader then
		slot0._oldMapLoader:dispose()

		slot0._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(slot0._addAllAudio, slot0)
	TaskDispatcher.cancelTask(slot0._addMapLight, slot0)
end

function slot0._showMapTip(slot0)
	gohelper.setActive(slot0._gotoptipsbg, false)
end

function slot0._hideMapTip(slot0)
	gohelper.setActive(slot0._gotoptipsbg, false)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshMap()
end

function slot0.onOpen(slot0)
	slot0.activityDungeonMo = slot0.viewContainer.versionActivityDungeonBaseMo

	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnFocusElement, slot0._focusElementById, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:refreshMap()
end

function slot0.onModeChange(slot0)
	slot0.dotTween = true

	slot0:refreshMap()
end

function slot0._setEpisodeListVisible(slot0, slot1)
	if slot1 and slot0._interactiveItem then
		slot0._interactiveItem:_onOutAnimationFinished()
	end

	gohelper.setActive(slot0._gofullscreen, slot1)
end

function slot0._onScreenResize(slot0)
	if slot0._sceneGo then
		CameraMgr.instance:getMainCamera().orthographicSize = VersionActivityEnum.DungeonMapCameraSize * GameUtil.getAdapterScale()

		slot0:_initScene()
	end
end

function slot0._focusElementById(slot0, slot1)
	slot0:setScenePosSafety(Vector3(slot0._mapMaxX - ((string.splitToNumber(lua_chapter_map_element.configDict[slot1].pos, "#")[1] or 0) + (string.splitToNumber(slot2.offsetPos, "#")[1] or 0)) + slot0._viewWidth / 2, slot0._mapMinY - ((slot3[2] or 0) + (slot6[2] or 0)) - slot0._viewHeight / 2 + 2, 0), not DungeonMapModel.instance.directFocusElement)
end

function slot0.refreshHardMapEffectAndAudio(slot0)
	if slot0.activityDungeonMo:isHardMode() then
		AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
	else
		AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	end

	if slot0.goRainEffect then
		gohelper.setActive(slot0.goRainEffect, slot1)
	end

	if slot0.goFogEffect then
		gohelper.setActive(slot0.goFogEffect, slot1)
	end
end

function slot0.setVisible(slot0, slot1)
	gohelper.setActive(slot0._sceneRoot, slot1)

	if slot1 then
		slot0:_initCamera()
	end
end

function slot0.onClose(slot0)
	slot0:_resetCamera()
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._sceneRoot)
	slot0:disposeOldMap()

	if slot0._mapLoader then
		slot0._mapLoader:dispose()
	end

	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	TaskDispatcher.cancelTask(slot0._hideMapTip, slot0)
end

return slot0
