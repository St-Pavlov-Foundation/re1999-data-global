module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapScene", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapScene", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
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
	slot0:_initDrag()
	gohelper.setActive(slot0._gointeractitem, false)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, slot0.onActivityDungeonMoChange, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.FocusElement, slot0.onFocusElement, slot0)
	MainCameraMgr.instance:addView(slot0.viewName, slot0._initCamera, nil, slot0)
	slot0:refreshMap()
end

function slot0._initDrag(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gofullscreen)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
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

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._dragBeginPos = nil
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

function slot0.getTargetPos(slot0, slot1)
	slot3 = slot1.y

	if slot1.x < slot0._mapMinX then
		slot2 = slot0._mapMinX
	elseif slot0._mapMaxX < slot2 then
		slot2 = slot0._mapMaxX
	end

	if slot3 < slot0._mapMinY then
		slot3 = slot0._mapMinY
	elseif slot0._mapMaxY < slot3 then
		slot3 = slot0._mapMaxY
	end

	return slot2, slot3
end

function slot0.directSetScenePos(slot0, slot1)
	slot0._scenePos.x, slot0._scenePos.y = slot0:getTargetPos(slot1)

	transformhelper.setLocalPos(slot0._sceneTrans, slot0._scenePos.x, slot0._scenePos.y, 0)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnMapPosChanged)
end

function slot0.tweenSetScenePos(slot0, slot1, slot2)
	slot0._tweenTargetPosX, slot0._tweenTargetPosY = slot0:getTargetPos(slot1)
	slot0._tweenStartPosX, slot0._tweenStartPosY = slot0:getTargetPos(slot2 or slot0._scenePos)

	slot0:killTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, slot0.tweenFrameCallback, slot0.tweenFinishCallback, slot0)

	slot0:tweenFrameCallback(0)
end

function slot0.tweenFrameCallback(slot0, slot1)
	slot0._tempVector:Set(Mathf.Lerp(slot0._tweenStartPosX, slot0._tweenTargetPosX, slot1), Mathf.Lerp(slot0._tweenStartPosY, slot0._tweenTargetPosY, slot1), 0)
	slot0:directSetScenePos(slot0._tempVector)
end

function slot0.tweenFinishCallback(slot0)
	slot0._tempVector:Set(slot0._tweenTargetPosX, slot0._tweenTargetPosY, 0)
	slot0:directSetScenePos(slot0._tempVector)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.TweenMapPosDone)
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
	slot1.orthographicSize = VersionActivity1_5DungeonEnum.DungeonMapCameraSize * GameUtil.getAdapterScale()
end

function slot0._resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false
end

function slot0._initMapRootNode(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New(VersionActivity1_5DungeonEnum.SceneRootName)
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnCreateMapRootGoDone, slot0._sceneRoot)
end

function slot0.getSceneGo(slot0)
	return slot0._sceneGo
end

function slot0._isSameMap(slot0, slot1, slot2)
	return slot1 == slot2
end

function slot0.refreshMap(slot0, slot1)
	slot0._mapCfg = VersionActivity1_5DungeonController.instance:getEpisodeMapConfig(slot0.activityDungeonMo.episodeId)

	if slot0._mapCfg.id == slot0._lastLoadMapId then
		if not slot0.loadDone then
			return
		end

		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
			mapConfig = slot0._mapCfg,
			mapSceneGo = slot0._sceneGo
		})
		slot0:_initElements()

		return
	end

	slot0.needTween = slot1
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

	slot0._sceneUrl = slot1[1]
	slot0._mapLightUrl = slot1[2]

	slot0._mapLoader:addPath(slot0._sceneUrl)
	slot0._mapLoader:addPath(slot0._mapLightUrl)
	slot0._mapLoader:startLoad(slot0._loadSceneFinish, slot0)
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
end

function slot0.buildLoadRes(slot0, slot1, slot2)
	table.insert(slot1, ResUrl.getDungeonMapRes(slot2.res))
	table.insert(slot1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
end

function slot0._disposeScene(slot0)
	slot0._oldScenePos = slot0._scenePos
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

	slot0._mapAudioGo = nil
end

function slot0._rebuildScene(slot0)
	slot0:loadMap(slot0._tempMapCfg)

	slot0._tempMapCfg = nil
end

function slot0._addMapLight(slot0)
	slot1 = slot0._mapLightUrl

	gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneGo)
end

function slot0._initElements(slot0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function slot0._initScene(slot0)
	slot0._mapSize = gohelper.findChild(slot0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size
	slot3 = nil
	slot5 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot8 = VersionActivity1_5DungeonEnum.DungeonMapCameraSize / (CameraMgr.instance:getUICamera() and slot6.orthographicSize or 5)
	slot9 = slot5[1] * slot4 * slot8
	slot10 = slot5[3] * slot4 * slot8
	slot0._viewWidth = math.abs(slot10.x - slot9.x)
	slot0._viewHeight = math.abs(slot10.y - slot9.y)
	slot0._mapMinX = slot9.x - (slot0._mapSize.x - slot0._viewWidth)
	slot0._mapMaxX = slot9.x
	slot0._mapMinY = slot9.y
	slot0._mapMaxY = slot9.y + slot0._mapSize.y - slot0._viewHeight
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
	else
		slot0:directSetScenePos(slot0._tempVector)
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

	if slot0._oldMapLoader then
		slot0._oldMapLoader:dispose()

		slot0._oldMapLoader = nil
	end
end

function slot0.onUpdateParam(slot0)
	slot0:refreshMap()
end

function slot0.onModeChange(slot0)
	slot0:refreshMap()
end

function slot0.onActivityDungeonMoChange(slot0)
	slot0:refreshMap(true)
end

function slot0._onScreenResize(slot0)
	if slot0._sceneGo then
		CameraMgr.instance:getMainCamera().orthographicSize = VersionActivity1_5DungeonEnum.DungeonMapCameraSize * GameUtil.getAdapterScale()

		slot0:_initScene()
	end
end

function slot0.onClickElement(slot0, slot1)
	slot0:focusElementByCo(slot1:getConfig())
end

function slot0.onFocusElement(slot0, slot1)
	if not DungeonMapModel.instance:getElementById(slot1) then
		logError("element not exist or not unlock, element id : " .. slot1)

		return
	end

	if slot0.mapSceneElementsView:getElementComp(slot1) then
		slot0:focusElementByCo(slot2:getConfig())

		return
	end

	slot5 = lua_chapter_map_element.configDict[slot1].mapId

	if not string.nilorempty(lua_activity11502_episode_element.configDict[slot1].mapIds) then
		slot5 = string.splitToNumber(slot4.mapIds, "#")[1]
	end

	slot0._mapCfg = lua_chapter_map.configDict[slot5]
	slot0.tempInitPosX = -string.splitToNumber(slot3.pos, "#")[1] or 0
	slot0.tempInitPosY = -slot6[2] or 0
	slot7 = DungeonConfig.instance:getEpisodeIdByMapCo(slot0._mapCfg)

	if VersionActivityDungeonBaseEnum.DungeonMode.Story ~= slot0.activityDungeonMo.mode then
		slot0.activityDungeonMo:changeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
	end

	slot0.activityDungeonMo:changeEpisode(slot7)
end

function slot0.focusElementByCo(slot0, slot1)
	slot0._tempVector:Set(-string.splitToNumber(slot1.pos, "#")[1] or 0, -slot2[2] or 0, 0)
	slot0:tweenSetScenePos(slot0._tempVector)
end

function slot0.setVisible(slot0, slot1)
	gohelper.setActive(slot0._sceneRoot, slot1)

	if slot1 then
		slot0:_initCamera()
	end
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end
end

function slot0.onClose(slot0)
	slot0:killTween()
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._sceneRoot)
	slot0:disposeOldMap()
	slot0:_disposeScene()

	if slot0._mapLoader then
		slot0._mapLoader:dispose()
	end

	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
end

return slot0
