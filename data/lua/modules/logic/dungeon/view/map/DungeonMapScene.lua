module("modules.logic.dungeon.view.map.DungeonMapScene", package.seeall)

slot0 = class("DungeonMapScene", BaseView)
slot1 = {
	OpenEnd = 3,
	NoStart = 1,
	ResLoad = 2,
	None = 0
}

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")
	slot0._goinvestigatepos = gohelper.findChild(slot0.viewGO, "go_investigatepos")
	slot0._gotoptipsbg = gohelper.findChild(slot0.viewGO, "#go_main/#go_toptipsbg")
	slot0._animchangeScene = gohelper.findChild(slot0.viewGO, "#go_scenechange"):GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeMap, slot0._OnChangeMap, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnFocusElement, slot0._focusElementById, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Finish, slot0._onStoryFinish, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.CheckEnterDungeonMapView, slot0._delaySendGuideEnterDungeonMapEvent, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.CheckEnterEpisodeDungeonMapView, slot0._delaySendGuideEnterEpisodeDungeonMapView, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnChangeMap, slot0._OnChangeMap, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnFocusElement, slot0._focusElementById, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Finish, slot0._onStoryFinish, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.CheckEnterDungeonMapView, slot0._delaySendGuideEnterDungeonMapEvent, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.CheckEnterEpisodeDungeonMapView, slot0._delaySendGuideEnterEpisodeDungeonMapView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._editableInitView(slot0)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	slot0._tempVector = Vector3()
	slot0._dragDeltaPos = Vector3()

	slot0:_initMap()
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

function slot0.setSceneVisible(slot0, slot1)
	gohelper.setActive(slot0._sceneRoot, slot1 and true or false)

	if slot1 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, slot0.viewParam.chapterId)
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
		slot3 = slot0._tweenTime or 0.46

		UIBlockHelper.instance:startBlock("DungeonMapSceneTweenPos", slot3, slot0.viewName)
		ZProj.TweenHelper.DOLocalMove(slot0._sceneTrans, slot1.x, slot1.y, 0, slot3, slot0._localMoveDone, slot0, nil, EaseType.OutQuad)
	else
		slot0._sceneTrans.localPosition = slot1

		slot0:_updateElementArrow()
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnMapPosChanged, slot1, slot2)
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
	slot1.orthographicSize = 5 * GameUtil.getAdapterScale()
end

function slot0._initMap(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("DungeonMapScene")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.getSceneGo(slot0)
	return slot0._sceneGo
end

function slot0.getChangeMapStatus(slot0)
	if not slot0._compareCur or not slot0._compareLast then
		return
	end

	if slot0._compareCur.mapState ~= slot0._compareLast.mapState then
		return slot0._compareCur.mapState
	end
end

function slot0._changeMap(slot0, slot1, slot2)
	if not slot1 or slot0._mapCfg == slot1 and not slot2 then
		return
	end

	slot0._showSceneChangeAnimState = uv0.None

	if slot0._mapCfg then
		slot3 = DungeonEnum.MapIdGroup[slot0._mapCfg.id]
		slot4 = DungeonEnum.MapIdGroup[slot1.id]

		if ToughBattleModel.instance:getIsJumpActElement() or slot3 and slot4 and slot4 ~= slot3 then
			slot0._showSceneChangeAnimState = uv0.NoStart
		end
	end

	slot0._compareLast = slot0._mapCfg
	slot0._compareCur = slot1

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	slot0._tempMapCfg = nil

	if not slot0._oldMapLoader and slot0._sceneGo then
		slot0._oldMapLoader = slot0._mapLoader
		slot0._oldSceneGo = slot0._sceneGo
		slot0._mapLoader = nil
	end

	if slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end

	slot0._mapCfg = slot1
	slot3 = slot1.res
	slot0._mapLoader = MultiAbLoader.New()
	slot4 = {}

	uv1._preloadRes(slot4, slot0._mapCfg)

	slot0._canvasUrl = slot4[1]
	slot0._interactiveItemUrl = slot4[2]
	slot0._sceneUrl = slot4[3]

	slot0._mapLoader:addPath(slot0._sceneUrl)

	slot0._mapAudioUrl = slot4[4]
	slot0._mapLightUrl = slot4[5]

	slot0._mapLoader:addPath(slot0._canvasUrl)
	slot0._mapLoader:addPath(slot0._interactiveItemUrl)
	slot0._mapLoader:addPath(slot0._mapAudioUrl)
	slot0._mapLoader:addPath(slot0._mapLightUrl)

	slot0._mapExEffectPath = DungeonEnum.MapExEffectPath[slot0._mapCfg.id]

	if slot0._mapExEffectPath then
		slot0._mapLoader:addPath(slot0._mapExEffectPath)
	end

	slot0:preloadElementRes(slot0._mapLoader)

	if slot0._showSceneChangeAnimState == uv0.NoStart then
		slot0._animchangeScene:Play("open", 0, 0)
		gohelper.setActive(slot0._animchangeScene, true)
		TaskDispatcher.cancelTask(slot0._delayShowScene, slot0)
		TaskDispatcher.runDelay(slot0._delayShowScene, slot0, 0.5)
		UIBlockHelper.instance:startBlock("DungeonSceneChangeAnimStart", 0.5, slot0.viewName)
	end

	slot0._mapLoader:startLoad(slot0._loadSceneFinish, slot0)
end

function slot0._delayShowScene(slot0)
	if slot0._showSceneChangeAnimState == uv0.ResLoad then
		slot0._showSceneChangeAnimState = uv0.OpenEnd

		slot0:_loadSceneFinish()
	elseif slot0._showSceneChangeAnimState == uv0.NoStart then
		slot0._showSceneChangeAnimState = uv0.OpenEnd
	end
end

function slot0.playSceneChangeClose(slot0)
	slot0._animchangeScene:Play("close", 0, 0)
	TaskDispatcher.runDelay(slot0._delayCloseEnd, slot0, 0.5)
	UIBlockHelper.instance:startBlock("DungeonSceneChangeAnimEnd", 0.5, slot0.viewName)
end

function slot0._delayCloseEnd(slot0)
	slot0._showSceneChangeAnimState = uv0.None

	gohelper.setActive(slot0._animchangeScene, false)
end

function slot0.preloadElementRes(slot0, slot1)
	for slot6, slot7 in pairs(DungeonMapModel.instance:getElements(slot0._mapCfg.id)) do
		if slot7.type == DungeonEnum.ElementType.ToughBattle and not string.nilorempty(slot7.res) then
			slot1:addPath(slot7.res)
		end
	end
end

function slot0._loadSceneFinish(slot0)
	if gohelper.isNil(slot0._sceneRoot) then
		logError("DungeonMapScene 节点没了？？？" .. slot0.viewContainer._viewStatus)

		return
	end

	if slot0._showSceneChangeAnimState == uv0.NoStart then
		slot0._showSceneChangeAnimState = uv0.ResLoad

		return
	elseif slot0._showSceneChangeAnimState == uv0.OpenEnd then
		slot0:playSceneChangeClose()
	end

	if slot0._curMapAreaAudio ~= slot0._mapCfg.areaAudio then
		slot0:_stopAreaAudio()
	elseif slot0._mapAudioGo then
		gohelper.addChild(slot0._sceneRoot, slot0._mapAudioGo)
	end

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
	TaskDispatcher.runDelay(slot0._addAllAudio, slot0, 0.2)
	MainCameraMgr.instance:addView(slot0.viewName, slot0._initCamera, nil, slot0)
	slot0:_initScene()
	slot0:_initCanvas()
	slot0:_initExEffect()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterEpisodeDungeonMapView, slot0._mapCfg.id)

	if slot0._mapCfg.id == 10721 or slot0._mapCfg.id == 10728 then
		TaskDispatcher.runDelay(slot0._addMapLight, slot0, 0)
	else
		TaskDispatcher.runDelay(slot0._addMapLight, slot0, 0.3)
	end

	slot0:_showMapTip()

	slot0._switchState1 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/switch/state_1")
	slot0._switchState2 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/switch/state_2")

	slot0:_updateSwitchState()
end

function slot0._initExEffect(slot0)
	if slot0._mapExEffectPath then
		gohelper.clone(slot0._mapLoader:getAssetItem(slot0._mapExEffectPath):GetResource(slot0._mapExEffectPath), slot0._sceneGo)
	end
end

function slot0._addAllAudio(slot0)
	slot0:_addMapAudio()
	slot0:_addEffectAudio()
end

function slot0._updateSwitchState(slot0)
	if not slot0._switchState1 or not slot0._switchState2 then
		return
	end

	if not slot0._episodeConfig then
		return
	end

	slot1 = DungeonModel.instance:hasPassLevelAndStory(slot0._episodeConfig.id)

	gohelper.setActive(slot0._switchState1, not slot1)
	gohelper.setActive(slot0._switchState2, slot1)
end

function slot0._preloadRes(slot0, slot1, slot2, slot3)
	table.insert(slot0, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(slot0, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")

	if slot2 then
		DungeonMapModel.instance.preloadMapCfg = DungeonMapChapterLayout.getFocusMap(slot2, slot3)
	end

	if not slot1 then
		return
	end

	if not slot2 then
		if DungeonMapModel.instance.preloadMapCfg and DungeonMapModel.instance.preloadMapCfg ~= slot1 then
			logError(string.format("DungeonMapScene preload error preload:%s,normal:%s", DungeonMapModel.instance.preloadMapCfg.id, slot1.id))
		end

		DungeonMapModel.instance.preloadMapCfg = nil
	end

	table.insert(slot0, ResUrl.getDungeonMapRes(slot1.res))
	uv0._addAudioAndLight(slot0, slot1)
end

function slot0._addAudioAndLight(slot0, slot1)
	if slot1.chapterId == 103 then
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_03.prefab")
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light_03.prefab")
	elseif slot1.chapterId == 104 then
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_04.prefab")
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light_04.prefab")
	elseif slot1.chapterId == 105 then
		table.insert(slot0, "scenes/v1a4_m_s08_hddt/scenes_prefab/v1a4_m_s08_hddt_audio.prefab")
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	elseif slot1.chapterId == 310 then
		table.insert(slot0, "scenes/v1a4_m_s08_hddt_jz/scene_prefab/v1a4_m_s08_hddt_jz_audio.prefab")
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	elseif slot1.chapterId == DungeonEnum.ChapterId.Main1_6 then
		table.insert(slot0, "scenes/v1a7_m_s08_hddt/scenes_prefab/v1a7_m_s08_hddt_audio.prefab")
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	else
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio.prefab")
		table.insert(slot0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	end
end

function slot0._disposeScene(slot0)
	slot0._oldScenePos = slot0._targetPos
	slot0._tempMapCfg = slot0._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if slot0._sceneGo then
		gohelper.destroy(slot0._sceneGo)

		slot0._sceneGo = nil
	end

	slot0._sceneTrans = nil

	if slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end

	TaskDispatcher.cancelTask(slot0._addMapLight, slot0)
	TaskDispatcher.cancelTask(slot0._addAllAudio, slot0)
	slot0:_removeEffectAudio(true)
	slot0:_stopAreaAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_uinoise_bus)
end

function slot0._rebuildScene(slot0)
	slot0:_changeMap(slot0._tempMapCfg, true)

	slot0._tempMapCfg = nil
end

function slot0._removeEffectAudio(slot0, slot1)
	if not slot0._effectAudio then
		return
	end

	if slot0._effectAudio == slot0._mapCfg.effectAudio and not slot1 then
		return
	end

	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)

	slot0._effectAudio = nil
end

function slot0._addEffectAudio(slot0)
	if slot0._effectAudio == slot0._mapCfg.effectAudio or slot0._mapCfg.effectAudio <= 0 then
		return
	end

	slot0._effectAudio = slot0._mapCfg.effectAudio

	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
end

function slot0._addMapLight(slot0)
	slot1 = slot0._mapLightUrl

	gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnNormalDungeonInitElements)
end

function slot0._addMapAudio(slot0)
	if slot0._mapAudioGo then
		gohelper.addChild(slot0._sceneGo, slot0._mapAudioGo)

		return
	end

	if slot0._mapCfg.chapterId == DungeonEnum.ChapterId.Main1_6 and not slot0.playingMain1_6Effect then
		slot0.playingMain1_6Effect = true

		AudioEffectMgr.instance:playAudio(AudioEnum.Bgm.Main1_6Effect)
	end

	slot1 = slot0._mapAudioUrl
	slot0._mapAudioGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneGo, "audio")

	gohelper.addChild(slot0._sceneGo, slot0._mapAudioGo)
	transformhelper.setLocalPos(slot0._mapAudioGo.transform, 0, 0, 0)

	if string.nilorempty(slot0._mapCfg.areaAudio) then
		return
	end

	slot0._curMapAreaAudio = slot4
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
	slot6 = slot5[1] * slot4
	slot7 = slot5[3] * slot4
	slot0._viewWidth = math.abs(slot7.x - slot6.x)
	slot0._viewHeight = math.abs(slot7.y - slot6.y)
	slot0._mapMinX = slot6.x - (slot0._mapSize.x - slot0._viewWidth)
	slot0._mapMaxX = slot6.x
	slot0._mapMinY = slot6.y
	slot0._mapMaxY = slot6.y + slot0._mapSize.y - slot0._viewHeight

	if slot0._oldScenePos then
		slot0._sceneTrans.localPosition = slot0._oldScenePos
	end

	slot0:_setInitPos(slot0._oldScenePos)

	slot0._oldScenePos = nil
end

function slot0._setInitPos(slot0, slot1)
	if not slot0._mapCfg then
		return
	end

	if ToughBattleModel.instance:getIsJumpActElement() then
		DungeonMapModel.instance.directFocusElement = true

		slot0:_focusElementById(ToughBattleEnum.ActElementId)

		DungeonMapModel.instance.directFocusElement = false

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

	if slot0._oldMapLoader then
		slot0._oldMapLoader:dispose()

		slot0._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(slot0._addAllAudio, slot0)
	slot0:_removeEffectAudio()
	TaskDispatcher.cancelTask(slot0._addMapLight, slot0)
end

function slot0._stopAreaAudio(slot0)
	if slot0._mapAudioGo then
		gohelper.destroy(slot0._mapAudioGo)

		slot0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
		AudioMgr.instance:trigger(AudioEnum.Bgm.Stop_FightingMusic)
	end
end

function slot0._showMapTip(slot0)
	gohelper.setActive(slot0._gotoptipsbg, false)
end

function slot0._hideMapTip(slot0)
	gohelper.setActive(slot0._gotoptipsbg, false)
end

function slot0.onOpen(slot0)
	slot0._showSceneChangeAnimState = uv0.None

	gohelper.setActive(slot0._animchangeScene, false)
end

function slot0._onScreenResize(slot0)
	if slot0._sceneGo then
		slot0:_initScene()
	end
end

function slot0._onStoryFinish(slot0)
	slot0:_updateSwitchState()
end

function slot0._focusElementById(slot0, slot1)
	slot2, slot3 = slot0:_getFocusPos(tonumber(slot1))

	slot0:setScenePosSafety(Vector3(slot2, slot3, 0), not DungeonMapModel.instance.directFocusElement)
end

function slot0._getFocusPos(slot0, slot1)
	return slot0._mapMaxX - ((string.splitToNumber(lua_chapter_map_element.configDict[slot1].pos, "#")[1] or 0) + (string.splitToNumber(slot2.offsetPos, "#")[1] or 0)) + slot0._viewWidth / 2, slot0._mapMinY - ((slot3[2] or 0) + (slot6[2] or 0)) - slot0._viewHeight / 2 + 2
end

function slot0._OnChangeMap(slot0, slot1)
	slot0._episodeConfig = slot1[2]

	if slot1[1] == slot0._mapCfg then
		slot0:_setInitPos(true)

		return
	end

	slot0:_changeMap(slot2)
end

function slot0._delaySendGuideEnterDungeonMapEvent(slot0)
	TaskDispatcher.runDelay(slot0._sendGuideEnterDungeonMapEvent, slot0, 0.5)
end

function slot0._sendGuideEnterDungeonMapEvent(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, slot0.viewParam.chapterId)
end

function slot0._delaySendGuideEnterEpisodeDungeonMapView(slot0)
	TaskDispatcher.runDelay(slot0._sendGuideEnterEpisodeDungeonMapView, slot0, 0.1)
end

function slot0._sendGuideEnterEpisodeDungeonMapView(slot0)
	if slot0._mapCfg then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterEpisodeDungeonMapView, slot0._mapCfg.id)
	end
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_uinoise_bus)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Bgm.Main1_6Effect)
	TaskDispatcher.cancelTask(slot0._delayShowScene, slot0)
	TaskDispatcher.cancelTask(slot0._delayCloseEnd, slot0)
	TaskDispatcher.cancelTask(slot0._sendGuideEnterDungeonMapEvent, slot0)
	TaskDispatcher.cancelTask(slot0._delaySendGuideEnterEpisodeDungeonMapView, slot0)
	gohelper.destroy(slot0._sceneRoot)
	slot0:_stopAreaAudio()
	slot0:disposeOldMap()
	slot0:_removeEffectAudio(true)

	if slot0._mapLoader then
		slot0._mapLoader:dispose()
	end

	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	slot0:removeEvents()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._hideMapTip, slot0)
end

return slot0
