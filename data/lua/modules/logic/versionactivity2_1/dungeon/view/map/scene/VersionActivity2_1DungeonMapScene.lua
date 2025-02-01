module("modules.logic.versionactivity2_1.dungeon.view.map.scene.VersionActivity2_1DungeonMapScene", package.seeall)

slot0 = class("VersionActivity2_1DungeonMapScene", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gofullscreen)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, slot0.onActivityDungeonMoChange, slot0)
	slot0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.FocusElement, slot0.onFocusElement, slot0)
	slot0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.ManualClickElement, slot0.manualClickElement, slot0)

	if slot0._drag then
		slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
		slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
		slot0._drag:AddDragListener(slot0._onDrag, slot0)
	end
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, slot0.onActivityDungeonMoChange, slot0)
	slot0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.FocusElement, slot0.onFocusElement, slot0)
	slot0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.ManualClickElement, slot0.manualClickElement, slot0)

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		slot0:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, slot0)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		slot0:loadMap()
	end
end

function slot0._onScreenResize(slot0)
	if slot0._sceneGo then
		CameraMgr.instance:getMainCamera().orthographicSize = VersionActivity2_1DungeonEnum.DungeonMapCameraSize * GameUtil.getAdapterScale()

		slot0:_initScene()
	end
end

function slot0.onModeChange(slot0)
	slot0:refreshMap()
end

function slot0.onActivityDungeonMoChange(slot0)
	slot0:refreshMap(VersionActivity2_1DungeonModel.instance:getMapNeedTweenState())
end

function slot0.onClickElement(slot0, slot1)
	if type(slot1) ~= "table" then
		slot1 = slot0.viewContainer.mapSceneElements:getElementComp(tonumber(slot1))
	end

	if slot1 then
		slot0:focusElementByCo(slot1:getConfig())
	end
end

function slot0.focusElementByCo(slot0, slot1)
	slot0._tempVector:Set(-string.splitToNumber(slot1.pos, "#")[1] or 0, -slot2[2] or 0, 0)
	slot0:tweenSetScenePos(slot0._tempVector)
end

function slot0.onFocusElement(slot0, slot1, slot2)
	if slot0.mapSceneElementsView:getElementComp(slot1) or slot2 then
		slot4 = nil

		if (not slot3 or slot3:getConfig()) and DungeonConfig.instance:getChapterMapElement(slot1) then
			slot0:focusElementByCo(slot4)
		end
	else
		slot0:changeToElementEpisode(slot1)
	end
end

function slot0.changeToElementEpisode(slot0, slot1)
	if not lua_chapter_map_element.configDict[slot1] then
		return
	end

	slot0._mapCfg = lua_chapter_map.configDict[slot2.mapId]
	slot0.tempInitPosX = -string.splitToNumber(slot2.pos, "#")[1] or 0
	slot0.tempInitPosY = -slot4[2] or 0
	slot5 = DungeonConfig.instance:getEpisodeIdByMapCo(slot0._mapCfg)

	if VersionActivityDungeonBaseEnum.DungeonMode.Story ~= slot0.activityDungeonMo.mode then
		slot0.activityDungeonMo:changeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
	end

	slot0.activityDungeonMo:changeEpisode(slot5)
end

function slot0.manualClickElement(slot0, slot1)
	if slot0.mapSceneElementsView:getElementComp(slot1) then
		slot0.mapSceneElementsView:manualClickElement(slot1)
	else
		slot0.mapSceneElementsView:setInitClickElement(slot1)
		slot0:changeToElementEpisode(slot1)
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._dragBeginPos = slot0:getDragWorldPos(slot2)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._dragBeginPos then
		return
	end

	slot3 = slot0:getDragWorldPos(slot2)
	slot4 = slot3 - slot0._dragBeginPos
	slot0._dragBeginPos = slot3

	slot0._tempVector:Set(slot0._scenePos.x + slot4.x, slot0._scenePos.y + slot4.y)
	slot0:directSetScenePos(slot0._tempVector)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._dragBeginPos = nil
end

function slot0.getDragWorldPos(slot0, slot1)
	return SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot1.position, CameraMgr.instance:getMainCamera(), slot0._gofullscreen.transform.position)
end

function slot0._editableInitView(slot0)
	slot0.mapSceneElementsView = slot0.viewContainer.mapSceneElements

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	slot0._tempVector = Vector3()
	slot0._dragDeltaPos = Vector3()
	slot0._scenePos = Vector3()

	slot0:_initMapRootNode()
end

function slot0._initMapRootNode(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New(VersionActivity2_1DungeonEnum.SceneRootName)
	slot2, slot3, slot4 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot3, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnCreateMapRootGoDone, slot0._sceneRoot)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshMap()
end

function slot0.onOpen(slot0)
	MainCameraMgr.instance:addView(slot0.viewName, slot0._initCamera, nil, slot0)
	slot0:refreshMap()
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = VersionActivity2_1DungeonEnum.DungeonMapCameraSize * GameUtil.getAdapterScale()
end

function slot0.refreshMap(slot0, slot1, slot2)
	slot0._mapCfg = slot2 or VersionActivity2_1DungeonConfig.instance:getEpisodeMapConfig(slot0.activityDungeonMo.episodeId)
	slot0.needTween = slot1

	if slot0._mapCfg.id == slot0._lastLoadMapId then
		if not slot0.loadedDone then
			return
		end

		slot0:_initElements()
		slot0:_setMapPos()
	else
		slot0._lastLoadMapId = slot0._mapCfg.id

		slot0:loadMap()
	end

	VersionActivity2_1DungeonModel.instance:setMapNeedTweenState(true)
end

function slot0._initElements(slot0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
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

	slot0.loadedDone = false
	slot0._mapLoader = MultiAbLoader.New()
	slot1 = {}

	slot0:buildLoadRes(slot1, slot0._mapCfg)

	slot0._sceneUrl = slot1[1]
	slot0._mapLightUrl = slot1[2]
	slot0._sceneCanvas = slot1[3]
	slot0._mapAudioUrl = slot1[4]

	slot0._mapLoader:addPath(slot0._sceneUrl)
	slot0._mapLoader:addPath(slot0._mapLightUrl)
	slot0._mapLoader:addPath(slot0._sceneCanvas)
	slot0._mapLoader:addPath(slot0._mapAudioUrl)
	slot0._mapLoader:startLoad(slot0._loadSceneFinish, slot0)
end

function slot0.buildLoadRes(slot0, slot1, slot2)
	table.insert(slot1, ResUrl.getDungeonMapRes(slot2.res))
	table.insert(slot1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
end

function slot0._loadSceneFinish(slot0)
	slot0.loadedDone = true

	slot0:disposeOldMap()

	slot1 = slot0._sceneUrl
	slot0._sceneGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneRoot, slot0._mapCfg.id)
	slot0._sceneTrans = slot0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = slot0._mapCfg,
		mapSceneGo = slot0._sceneGo
	})
	slot0:_initScene()
	slot0:_setMapPos()
	slot0:_addMapLight()
	slot0:_initElements()
	slot0:_addMapAudio()
	slot0:_focusUnfinishStoryElement()
end

function slot0._initScene(slot0)
	slot1 = gohelper.findChild(slot0._sceneGo, "root/size")
	slot0._mapSize = slot1:GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size
	slot3, slot4, slot5 = transformhelper.getLocalScale(slot1.transform, 0, 0, 0)
	slot6 = nil
	slot8 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot11 = VersionActivity2_1DungeonEnum.DungeonMapCameraSize / (CameraMgr.instance:getUICamera() and slot9.orthographicSize or 5)
	slot12 = slot8[1] * slot7 * slot11
	slot13 = slot8[3] * slot7 * slot11
	slot0._viewWidth = math.abs(slot13.x - slot12.x)
	slot0._viewHeight = math.abs(slot13.y - slot12.y)
	slot0._mapMinX = slot12.x - (slot0._mapSize.x * slot3 - slot0._viewWidth)
	slot0._mapMaxX = slot12.x
	slot0._mapMinY = slot12.y
	slot0._mapMaxY = slot12.y + slot0._mapSize.y * slot4 - slot0._viewHeight
end

function slot0._setMapPos(slot0)
	if slot0.tempInitPosX then
		slot0._tempVector:Set(slot0.tempInitPosX, slot0.tempInitPosY, 0)

		slot0.tempInitPosX = nil
		slot0.tempInitPosY = nil
	else
		slot2 = string.splitToNumber(slot0._mapCfg.initPos, "#")

		slot0._tempVector:Set(slot2[1], slot2[2], 0)
	end

	if slot0.needTween then
		slot0:tweenSetScenePos(slot0._tempVector, slot0._oldScenePos)

		slot0.needTween = nil
	else
		slot0:directSetScenePos(slot0._tempVector)
	end
end

function slot0._addMapLight(slot0)
	slot1 = slot0._mapLightUrl

	gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneGo)
end

function slot0._addMapAudio(slot0)
	if not slot0._mapAudioUrl then
		return
	end

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

function slot0._focusUnfinishStoryElement(slot0)
	if VersionActivity2_1DungeonModel.instance:checkAndGetUnfinishStoryElementCo(slot0._mapCfg.id) then
		VersionActivity2_1DungeonController.instance:dispatchEvent(VersionActivity2_1DungeonEvent.FocusElement, slot1.id)
	end
end

function slot0.tweenSetScenePos(slot0, slot1, slot2)
	slot0._tweenTargetPosX, slot0._tweenTargetPosY = slot0:getTargetPos(slot1)
	slot0._tweenStartPosX, slot0._tweenStartPosY = slot0:getTargetPos(slot2 or slot0._scenePos)

	slot0:killTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, slot0.tweenFrameCallback, slot0.tweenFinishCallback, slot0)

	slot0:tweenFrameCallback(0)
end

function slot0.getTargetPos(slot0, slot1)
	slot2 = slot1.x
	slot3 = slot1.y

	if not slot0._mapMinX or not slot0._mapMaxX or not slot0._mapMinY or not slot0._mapMaxY then
		slot2 = string.splitToNumber(slot0._mapCfg and slot0._mapCfg.initPos, "#")[1] or 0
		slot3 = slot5[2] or 0
	else
		if slot2 < slot0._mapMinX then
			slot2 = slot0._mapMinX
		elseif slot0._mapMaxX < slot2 then
			slot2 = slot0._mapMaxX
		end

		if slot3 < slot0._mapMinY then
			slot3 = slot0._mapMinY
		elseif slot0._mapMaxY < slot3 then
			slot3 = slot0._mapMaxY
		end
	end

	return slot2, slot3
end

function slot0.tweenFrameCallback(slot0, slot1)
	slot0._tempVector:Set(Mathf.Lerp(slot0._tweenStartPosX, slot0._tweenTargetPosX, slot1), Mathf.Lerp(slot0._tweenStartPosY, slot0._tweenTargetPosY, slot1), 0)
	slot0:directSetScenePos(slot0._tempVector)
end

function slot0.tweenFinishCallback(slot0)
	slot0._tempVector:Set(slot0._tweenTargetPosX, slot0._tweenTargetPosY, 0)
	slot0:directSetScenePos(slot0._tempVector)
end

function slot0.directSetScenePos(slot0, slot1)
	slot0._scenePos.x, slot0._scenePos.y = slot0:getTargetPos(slot1)

	if not slot0._sceneTrans or gohelper.isNil(slot0._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(slot0._sceneTrans, slot0._scenePos.x, slot0._scenePos.y, 0)
	VersionActivity2_1DungeonController.instance:dispatchEvent(VersionActivity2_1DungeonEvent.OnMapPosChanged, slot0._scenePos, slot0.needTween)
	slot0:_updateElementArrow()
end

function slot0._updateElementArrow(slot0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function slot0.setVisible(slot0, slot1)
	gohelper.setActive(slot0._sceneRoot, slot1)

	if slot1 then
		slot0:_initCamera()
	end
end

function slot0.getSceneGo(slot0)
	return slot0._sceneGo
end

function slot0.onClose(slot0)
	slot0:killTween()
	slot0:_resetCamera()
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end
end

function slot0._resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._sceneRoot)
	slot0:disposeOldMap()
	slot0:_disposeScene()

	if slot0._mapLoader then
		slot0._mapLoader:dispose()
	end
end

function slot0.disposeOldMap(slot0)
	if slot0._sceneTrans then
		slot0._oldScenePos = slot0._scenePos
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
end

function slot0._disposeScene(slot0)
	slot0._oldScenePos = slot0._scenePos

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

	slot0._mapAudioGo = nil
end

return slot0
