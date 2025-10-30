module("modules.logic.dungeon.view.map.DungeonMapScene", package.seeall)

local var_0_0 = class("DungeonMapScene", BaseView)
local var_0_1 = {
	OpenEnd = 3,
	NoStart = 1,
	ResLoad = 2,
	None = 0
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._goinvestigatepos = gohelper.findChild(arg_1_0.viewGO, "go_investigatepos")
	arg_1_0._gotoptipsbg = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_toptipsbg")
	arg_1_0._animchangeScene = gohelper.findChild(arg_1_0.viewGO, "#go_scenechange"):GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeMap, arg_2_0._OnChangeMap, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnFocusElement, arg_2_0._focusElementById, arg_2_0)
	arg_2_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_2_0._onStoryFinish, arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.CheckEnterDungeonMapView, arg_2_0._delaySendGuideEnterDungeonMapEvent, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.CheckEnterEpisodeDungeonMapView, arg_2_0._delaySendGuideEnterEpisodeDungeonMapView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnChangeMap, arg_3_0._OnChangeMap, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnFocusElement, arg_3_0._focusElementById, arg_3_0)
	arg_3_0:removeEventCb(StoryController.instance, StoryEvent.Finish, arg_3_0._onStoryFinish, arg_3_0)
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.CheckEnterDungeonMapView, arg_3_0._delaySendGuideEnterDungeonMapEvent, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.CheckEnterEpisodeDungeonMapView, arg_3_0._delaySendGuideEnterEpisodeDungeonMapView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	arg_4_0._tempVector = Vector3()
	arg_4_0._dragDeltaPos = Vector3()

	arg_4_0:_initMap()
	arg_4_0:_initDrag()
end

function var_0_0._initDrag(arg_5_0)
	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0._gofullscreen)

	arg_5_0._drag:AddDragBeginListener(arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0._onDragEnd, arg_5_0)
	arg_5_0._drag:AddDragListener(arg_5_0._onDrag, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_5_0._onOpenView, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseView, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.StoryView then
		TaskDispatcher.cancelTask(arg_6_0._checkSceneVisible, arg_6_0)
		arg_6_0:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, arg_6_0)
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.StoryView then
		arg_7_0:_rebuildScene()
	end
end

function var_0_0._onCloseViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.StoryFrontView and not gohelper.isNil(arg_8_0._sceneRoot) and not arg_8_0._sceneRoot.activeSelf and ViewHelper.instance:checkViewOnTheTop(ViewName.DungeonMapView) then
		logError("DungeonMapScene scene is hided!")
		arg_8_0:setSceneVisible(true)
	end
end

function var_0_0.setSceneVisible(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._sceneRoot, arg_9_1 and true or false)

	if arg_9_1 then
		local var_9_0 = arg_9_0.viewParam.chapterId

		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, var_9_0)
	end
end

function var_0_0._onDragBegin(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._dragBeginPos = arg_10_0:getDragWorldPos(arg_10_2)

	if arg_10_0._sceneTrans then
		arg_10_0._beginDragPos = arg_10_0._sceneTrans.localPosition
	end
end

function var_0_0._onDragEnd(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._dragBeginPos = nil
	arg_11_0._beginDragPos = nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function var_0_0._onDrag(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)

	local var_12_0 = arg_12_0:getDragWorldPos(arg_12_2) - arg_12_0._dragBeginPos

	arg_12_0:drag(var_12_0)
end

function var_0_0.drag(arg_13_0, arg_13_1)
	if not arg_13_0._sceneTrans or not arg_13_0._beginDragPos then
		return
	end

	arg_13_0._dragDeltaPos.x = arg_13_1.x
	arg_13_0._dragDeltaPos.y = arg_13_1.y

	local var_13_0 = arg_13_0:vectorAdd(arg_13_0._beginDragPos, arg_13_0._dragDeltaPos)

	arg_13_0:setScenePosSafety(var_13_0)
	arg_13_0:_updateElementArrow()
end

function var_0_0._updateElementArrow(arg_14_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function var_0_0.setScenePosSafety(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0._sceneTrans then
		return
	end

	if arg_15_1.x < arg_15_0._mapMinX then
		arg_15_1.x = arg_15_0._mapMinX
	elseif arg_15_1.x > arg_15_0._mapMaxX then
		arg_15_1.x = arg_15_0._mapMaxX
	end

	if arg_15_1.y < arg_15_0._mapMinY then
		arg_15_1.y = arg_15_0._mapMinY
	elseif arg_15_1.y > arg_15_0._mapMaxY then
		arg_15_1.y = arg_15_0._mapMaxY
	end

	arg_15_0._targetPos = arg_15_1

	if arg_15_2 then
		local var_15_0 = arg_15_0._tweenTime or 0.46

		UIBlockHelper.instance:startBlock("DungeonMapSceneTweenPos", var_15_0, arg_15_0.viewName)
		ZProj.TweenHelper.DOLocalMove(arg_15_0._sceneTrans, arg_15_1.x, arg_15_1.y, 0, var_15_0, arg_15_0._localMoveDone, arg_15_0, nil, EaseType.OutQuad)
	else
		arg_15_0._sceneTrans.localPosition = arg_15_1

		arg_15_0:_updateElementArrow()
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnMapPosChanged, arg_15_1, arg_15_2)
end

function var_0_0._localMoveDone(arg_16_0)
	arg_16_0:_updateElementArrow()
end

function var_0_0.vectorAdd(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._tempVector

	var_17_0.x = arg_17_1.x + arg_17_2.x
	var_17_0.y = arg_17_1.y + arg_17_2.y

	return var_17_0
end

function var_0_0.getDragWorldPos(arg_18_0, arg_18_1)
	local var_18_0 = CameraMgr.instance:getMainCamera()
	local var_18_1 = arg_18_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_18_1.position, var_18_0, var_18_1))
end

function var_0_0._initCamera(arg_19_0)
	local var_19_0 = CameraMgr.instance:getMainCamera()

	var_19_0.orthographic = true
	var_19_0.orthographicSize = 5 * GameUtil.getAdapterScale()
end

function var_0_0._initMap(arg_20_0)
	local var_20_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_20_1 = CameraMgr.instance:getSceneRoot()

	arg_20_0._sceneRoot = UnityEngine.GameObject.New("DungeonMapScene")

	local var_20_2, var_20_3, var_20_4 = transformhelper.getLocalPos(var_20_0)

	transformhelper.setLocalPos(arg_20_0._sceneRoot.transform, 0, var_20_3, 0)
	gohelper.addChild(var_20_1, arg_20_0._sceneRoot)
end

function var_0_0.getSceneGo(arg_21_0)
	return arg_21_0._sceneGo
end

function var_0_0.getChangeMapStatus(arg_22_0)
	if not arg_22_0._compareCur or not arg_22_0._compareLast then
		return
	end

	if arg_22_0._compareCur.mapState ~= arg_22_0._compareLast.mapState then
		return arg_22_0._compareCur.mapState
	end
end

function var_0_0._changeMap(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1 or arg_23_0._mapCfg == arg_23_1 and not arg_23_2 then
		return
	end

	arg_23_0._showSceneChangeAnimState = var_0_1.None

	if arg_23_0._mapCfg then
		local var_23_0 = arg_23_0._mapCfg.mapIdGroup
		local var_23_1 = arg_23_1.mapIdGroup

		if ToughBattleModel.instance:getIsJumpActElement() or var_23_0 and var_23_0 > 0 and var_23_1 and var_23_1 ~= var_23_0 then
			arg_23_0._showSceneChangeAnimState = var_0_1.NoStart
		end
	end

	arg_23_0._compareLast = arg_23_0._mapCfg
	arg_23_0._compareCur = arg_23_1

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	arg_23_0._tempMapCfg = nil

	if not arg_23_0._oldMapLoader and arg_23_0._sceneGo then
		arg_23_0._oldMapLoader = arg_23_0._mapLoader
		arg_23_0._oldSceneGo = arg_23_0._sceneGo
		arg_23_0._mapLoader = nil
	end

	if arg_23_0._mapLoader then
		arg_23_0._mapLoader:dispose()

		arg_23_0._mapLoader = nil
	end

	arg_23_0._mapCfg = arg_23_1

	local var_23_2 = arg_23_1.res

	arg_23_0._mapLoader = MultiAbLoader.New()

	local var_23_3 = {}

	var_0_0._preloadRes(var_23_3, arg_23_0._mapCfg)

	arg_23_0._canvasUrl = var_23_3[1]
	arg_23_0._interactiveItemUrl = var_23_3[2]
	arg_23_0._sceneUrl = var_23_3[3]

	arg_23_0._mapLoader:addPath(arg_23_0._sceneUrl)

	arg_23_0._mapAudioUrl = var_23_3[4]
	arg_23_0._mapLightUrl = var_23_3[5]

	arg_23_0._mapLoader:addPath(arg_23_0._canvasUrl)
	arg_23_0._mapLoader:addPath(arg_23_0._interactiveItemUrl)
	arg_23_0._mapLoader:addPath(arg_23_0._mapAudioUrl)
	arg_23_0._mapLoader:addPath(arg_23_0._mapLightUrl)

	arg_23_0._mapExEffectPath = DungeonEnum.MapExEffectPath[arg_23_0._mapCfg.id]

	if arg_23_0._mapExEffectPath then
		arg_23_0._mapLoader:addPath(arg_23_0._mapExEffectPath)
	end

	arg_23_0:preloadElementRes(arg_23_0._mapLoader)

	if arg_23_0._showSceneChangeAnimState == var_0_1.NoStart then
		arg_23_0._animchangeScene:Play("open", 0, 0)
		gohelper.setActive(arg_23_0._animchangeScene, true)
		TaskDispatcher.cancelTask(arg_23_0._delayShowScene, arg_23_0)
		TaskDispatcher.runDelay(arg_23_0._delayShowScene, arg_23_0, 0.5)
		UIBlockHelper.instance:startBlock("DungeonSceneChangeAnimStart", 0.5, arg_23_0.viewName)
	end

	arg_23_0._mapLoader:startLoad(arg_23_0._loadSceneFinish, arg_23_0)
end

function var_0_0._delayShowScene(arg_24_0)
	if arg_24_0._showSceneChangeAnimState == var_0_1.ResLoad then
		arg_24_0._showSceneChangeAnimState = var_0_1.OpenEnd

		arg_24_0:_loadSceneFinish()
	elseif arg_24_0._showSceneChangeAnimState == var_0_1.NoStart then
		arg_24_0._showSceneChangeAnimState = var_0_1.OpenEnd
	end
end

function var_0_0.playSceneChangeClose(arg_25_0)
	arg_25_0._animchangeScene:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_25_0._delayCloseEnd, arg_25_0, 0.5)
	UIBlockHelper.instance:startBlock("DungeonSceneChangeAnimEnd", 0.5, arg_25_0.viewName)
end

function var_0_0._delayCloseEnd(arg_26_0)
	arg_26_0._showSceneChangeAnimState = var_0_1.None

	gohelper.setActive(arg_26_0._animchangeScene, false)
end

function var_0_0.preloadElementRes(arg_27_0, arg_27_1)
	local var_27_0 = DungeonMapModel.instance:getElements(arg_27_0._mapCfg.id)

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1.type == DungeonEnum.ElementType.ToughBattle and not string.nilorempty(iter_27_1.res) then
			arg_27_1:addPath(iter_27_1.res)
		end
	end
end

function var_0_0._loadSceneFinish(arg_28_0)
	if gohelper.isNil(arg_28_0._sceneRoot) then
		logError("DungeonMapScene 节点没了？？？" .. arg_28_0.viewContainer._viewStatus)

		return
	end

	if arg_28_0._showSceneChangeAnimState == var_0_1.NoStart then
		arg_28_0._showSceneChangeAnimState = var_0_1.ResLoad

		return
	elseif arg_28_0._showSceneChangeAnimState == var_0_1.OpenEnd then
		arg_28_0:playSceneChangeClose()
	end

	if arg_28_0._curMapAreaAudio ~= arg_28_0._mapCfg.areaAudio then
		arg_28_0:_stopAreaAudio()
	elseif arg_28_0._mapAudioGo then
		gohelper.addChild(arg_28_0._sceneRoot, arg_28_0._mapAudioGo)
	end

	arg_28_0:disposeOldMap()

	local var_28_0 = arg_28_0._sceneUrl
	local var_28_1 = arg_28_0._mapLoader:getAssetItem(var_28_0):GetResource(var_28_0)

	arg_28_0._sceneGo = gohelper.clone(var_28_1, arg_28_0._sceneRoot, arg_28_0._mapCfg.id)
	arg_28_0._sceneTrans = arg_28_0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		arg_28_0._mapCfg,
		arg_28_0._sceneGo,
		arg_28_0,
		episodeConfig = arg_28_0._episodeConfig
	})
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowMap)
	TaskDispatcher.runDelay(arg_28_0._addAllAudio, arg_28_0, 0.2)
	MainCameraMgr.instance:addView(arg_28_0.viewName, arg_28_0._initCamera, nil, arg_28_0)
	arg_28_0:_initScene()
	arg_28_0:_initCanvas()
	arg_28_0:_initExEffect()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterEpisodeDungeonMapView, arg_28_0._mapCfg.id)

	if arg_28_0._mapCfg.id == 10721 or arg_28_0._mapCfg.id == 10728 then
		TaskDispatcher.runDelay(arg_28_0._addMapLight, arg_28_0, 0)
	else
		TaskDispatcher.runDelay(arg_28_0._addMapLight, arg_28_0, 0.3)
	end

	arg_28_0:_showMapTip()

	arg_28_0._switchState1 = gohelper.findChild(arg_28_0._sceneGo, "Obj-Plant/all/switch/state_1")
	arg_28_0._switchState2 = gohelper.findChild(arg_28_0._sceneGo, "Obj-Plant/all/switch/state_2")

	arg_28_0:_updateSwitchState()
end

function var_0_0._initExEffect(arg_29_0)
	if arg_29_0._mapExEffectPath then
		local var_29_0 = arg_29_0._mapLoader:getAssetItem(arg_29_0._mapExEffectPath):GetResource(arg_29_0._mapExEffectPath)

		gohelper.clone(var_29_0, arg_29_0._sceneGo)
	end
end

function var_0_0._addAllAudio(arg_30_0)
	arg_30_0:_addMapAudio()
	arg_30_0:_addEffectAudio()
end

function var_0_0._updateSwitchState(arg_31_0)
	if not arg_31_0._switchState1 or not arg_31_0._switchState2 then
		return
	end

	if not arg_31_0._episodeConfig then
		return
	end

	local var_31_0 = DungeonModel.instance:hasPassLevelAndStory(arg_31_0._episodeConfig.id)

	gohelper.setActive(arg_31_0._switchState1, not var_31_0)
	gohelper.setActive(arg_31_0._switchState2, var_31_0)
end

function var_0_0.getInteractiveItemPath(arg_32_0)
	if arg_32_0 == DungeonEnum.ChapterId.Main1_10 then
		return "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem_110.prefab"
	end

	if arg_32_0 == DungeonEnum.ChapterId.Main1_11 then
		return "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem_111.prefab"
	end

	return "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab"
end

function var_0_0.getInteractiveItemCls(arg_33_0)
	if arg_33_0 == DungeonEnum.ChapterId.Main1_10 then
		return DungeonMapInteractiveItem110
	end

	return DungeonMapInteractiveItem
end

function var_0_0._preloadRes(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	table.insert(arg_34_0, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(arg_34_0, var_0_0.getInteractiveItemPath(arg_34_1.chapterId))

	if arg_34_2 then
		arg_34_1 = DungeonMapChapterLayout.getFocusMap(arg_34_2, arg_34_3)
		DungeonMapModel.instance.preloadMapCfg = arg_34_1
	end

	if not arg_34_1 then
		return
	end

	if not arg_34_2 then
		if DungeonMapModel.instance.preloadMapCfg and DungeonMapModel.instance.preloadMapCfg ~= arg_34_1 then
			logError(string.format("DungeonMapScene preload error preload:%s,normal:%s", DungeonMapModel.instance.preloadMapCfg.id, arg_34_1.id))
		end

		DungeonMapModel.instance.preloadMapCfg = nil
	end

	table.insert(arg_34_0, ResUrl.getDungeonMapRes(arg_34_1.res))
	var_0_0._addAudioAndLight(arg_34_0, arg_34_1)
end

function var_0_0._addAudioAndLight(arg_35_0, arg_35_1)
	if arg_35_1.chapterId == 103 then
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_03.prefab")
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light_03.prefab")
	elseif arg_35_1.chapterId == 104 then
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_04.prefab")
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light_04.prefab")
	elseif arg_35_1.chapterId == 105 then
		table.insert(arg_35_0, "scenes/v1a4_m_s08_hddt/scenes_prefab/v1a4_m_s08_hddt_audio.prefab")
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	elseif arg_35_1.chapterId == 310 then
		table.insert(arg_35_0, "scenes/v1a4_m_s08_hddt_jz/scene_prefab/v1a4_m_s08_hddt_jz_audio.prefab")
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	elseif arg_35_1.chapterId == DungeonEnum.ChapterId.Main1_6 then
		table.insert(arg_35_0, "scenes/v1a7_m_s08_hddt/scenes_prefab/v1a7_m_s08_hddt_audio.prefab")
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	else
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio.prefab")
		table.insert(arg_35_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	end
end

function var_0_0._disposeScene(arg_36_0)
	arg_36_0._oldScenePos = arg_36_0._targetPos
	arg_36_0._tempMapCfg = arg_36_0._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if arg_36_0._sceneGo then
		gohelper.destroy(arg_36_0._sceneGo)

		arg_36_0._sceneGo = nil
	end

	arg_36_0._sceneTrans = nil

	if arg_36_0._mapLoader then
		arg_36_0._mapLoader:dispose()

		arg_36_0._mapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_36_0._addMapLight, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._addAllAudio, arg_36_0)
	arg_36_0:_removeEffectAudio(true)
	arg_36_0:_stopAreaAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_uinoise_bus)
end

function var_0_0._rebuildScene(arg_37_0)
	arg_37_0:_changeMap(arg_37_0._tempMapCfg, true)

	arg_37_0._tempMapCfg = nil
end

function var_0_0._removeEffectAudio(arg_38_0, arg_38_1)
	if not arg_38_0._effectAudio then
		return
	end

	if arg_38_0._effectAudio == arg_38_0._mapCfg.effectAudio and not arg_38_1 then
		return
	end

	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)

	arg_38_0._effectAudio = nil
end

function var_0_0._addEffectAudio(arg_39_0)
	if arg_39_0._effectAudio == arg_39_0._mapCfg.effectAudio or arg_39_0._mapCfg.effectAudio <= 0 then
		return
	end

	arg_39_0._effectAudio = arg_39_0._mapCfg.effectAudio

	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
end

function var_0_0._addMapLight(arg_40_0)
	local var_40_0 = arg_40_0._mapLightUrl
	local var_40_1 = arg_40_0._mapLoader:getAssetItem(var_40_0):GetResource(var_40_0)

	gohelper.clone(var_40_1, arg_40_0._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnNormalDungeonInitElements)
end

function var_0_0._addMapAudio(arg_41_0)
	if arg_41_0._mapAudioGo then
		gohelper.addChild(arg_41_0._sceneGo, arg_41_0._mapAudioGo)

		return
	end

	if arg_41_0._mapCfg.chapterId == DungeonEnum.ChapterId.Main1_6 and not arg_41_0.playingMain1_6Effect then
		arg_41_0.playingMain1_6Effect = true

		AudioEffectMgr.instance:playAudio(AudioEnum.Bgm.Main1_6Effect)
	end

	local var_41_0 = arg_41_0._mapAudioUrl
	local var_41_1 = arg_41_0._mapLoader:getAssetItem(var_41_0):GetResource(var_41_0)

	arg_41_0._mapAudioGo = gohelper.clone(var_41_1, arg_41_0._sceneGo, "audio")

	gohelper.addChild(arg_41_0._sceneGo, arg_41_0._mapAudioGo)
	transformhelper.setLocalPos(arg_41_0._mapAudioGo.transform, 0, 0, 0)

	local var_41_2 = arg_41_0._mapCfg.areaAudio

	if string.nilorempty(var_41_2) then
		return
	end

	arg_41_0._curMapAreaAudio = var_41_2

	local var_41_3 = gohelper.findChild(arg_41_0._mapAudioGo, "audio")

	if var_41_2 == "all" then
		local var_41_4 = var_41_3.transform
		local var_41_5 = var_41_4.childCount

		for iter_41_0 = 1, var_41_5 do
			local var_41_6 = var_41_4:GetChild(iter_41_0 - 1)

			gohelper.setActive(var_41_6.gameObject, true)
		end

		return
	end

	local var_41_7 = string.split(var_41_2, "#")

	for iter_41_1, iter_41_2 in ipairs(var_41_7) do
		local var_41_8 = gohelper.findChild(var_41_3, iter_41_2)

		gohelper.setActive(var_41_8, true)
	end
end

function var_0_0._initCanvas(arg_42_0)
	local var_42_0 = arg_42_0._mapLoader:getAssetItem(arg_42_0._canvasUrl):GetResource(arg_42_0._canvasUrl)

	arg_42_0._sceneCanvasGo = gohelper.clone(var_42_0, arg_42_0._sceneGo)
	arg_42_0._sceneCanvas = arg_42_0._sceneCanvasGo:GetComponent("Canvas")
	arg_42_0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_42_0._itemPrefab = arg_42_0._mapLoader:getAssetItem(arg_42_0._interactiveItemUrl):GetResource(arg_42_0._interactiveItemUrl)
end

function var_0_0.getInteractiveItem(arg_43_0)
	arg_43_0._uiGo = gohelper.clone(arg_43_0._itemPrefab, arg_43_0._sceneCanvasGo)
	arg_43_0._interactiveItem = MonoHelper.addLuaComOnceToGo(arg_43_0._uiGo, var_0_0.getInteractiveItemCls(arg_43_0._mapCfg.chapterId))

	gohelper.setActive(arg_43_0._uiGo, false)

	return arg_43_0._interactiveItem
end

function var_0_0.showInteractiveItem(arg_44_0)
	return not gohelper.isNil(arg_44_0._uiGo)
end

function var_0_0._initScene(arg_45_0)
	local var_45_0 = gohelper.findChild(arg_45_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if var_45_0 then
		arg_45_0._mapSize = var_45_0.size
	else
		arg_45_0._mapSize = Vector2()

		logError(string.format("DungeonMapScene _initScene scene:%s 的root/size 缺少 BoxCollider,请联系地编处理", arg_45_0._mapCfg.res))
	end

	local var_45_1
	local var_45_2 = GameUtil.getAdapterScale()

	if var_45_2 ~= 1 then
		var_45_1 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_45_1 = ViewMgr.instance:getUIRoot()
	end

	local var_45_3 = var_45_1.transform:GetWorldCorners()
	local var_45_4 = var_45_3[1] * var_45_2
	local var_45_5 = var_45_3[3] * var_45_2

	arg_45_0._viewWidth = math.abs(var_45_5.x - var_45_4.x)
	arg_45_0._viewHeight = math.abs(var_45_5.y - var_45_4.y)
	arg_45_0._mapMinX = var_45_4.x - (arg_45_0._mapSize.x - arg_45_0._viewWidth)
	arg_45_0._mapMaxX = var_45_4.x
	arg_45_0._mapMinY = var_45_4.y
	arg_45_0._mapMaxY = var_45_4.y + (arg_45_0._mapSize.y - arg_45_0._viewHeight)

	if arg_45_0._oldScenePos then
		arg_45_0._sceneTrans.localPosition = arg_45_0._oldScenePos
	end

	arg_45_0:_setInitPos(arg_45_0._oldScenePos)

	arg_45_0._oldScenePos = nil
end

function var_0_0._setInitPos(arg_46_0, arg_46_1)
	if not arg_46_0._mapCfg then
		return
	end

	if ToughBattleModel.instance:getIsJumpActElement() then
		DungeonMapModel.instance.directFocusElement = true

		arg_46_0:_focusElementById(ToughBattleEnum.ActElementId)

		DungeonMapModel.instance.directFocusElement = false

		return
	end

	if arg_46_0:_focusBossElement() then
		return
	end

	local var_46_0 = arg_46_0._mapCfg.initPos
	local var_46_1 = string.splitToNumber(var_46_0, "#")

	arg_46_0:setScenePosSafety(Vector3(var_46_1[1], var_46_1[2], 0), arg_46_1)
end

function var_0_0._focusBossElement(arg_47_0)
	local var_47_0 = DungeonMapModel.instance:getElements(arg_47_0._mapCfg.id)
	local var_47_1 = false

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		if iter_47_1.id == VersionActivity2_8BossEnum.ElementId then
			var_47_1 = true

			break
		end
	end

	if var_47_1 and (DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.BossStory) or VersionActivity2_8BossModel.instance:isFocusElement()) then
		VersionActivity2_8BossModel.instance:setFocusElement(false)

		DungeonMapModel.instance.directFocusElement = true

		arg_47_0:_focusElementById(VersionActivity2_8BossEnum.ElementId)

		DungeonMapModel.instance.directFocusElement = false

		return true
	end
end

function var_0_0.disposeOldMap(arg_48_0)
	if arg_48_0._sceneTrans then
		arg_48_0._oldScenePos = arg_48_0._sceneTrans.localPosition
	else
		arg_48_0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_48_0.viewName)

	if arg_48_0._oldSceneGo then
		gohelper.destroy(arg_48_0._oldSceneGo)

		arg_48_0._oldSceneGo = nil
	end

	if arg_48_0._oldMapLoader then
		arg_48_0._oldMapLoader:dispose()

		arg_48_0._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_48_0._addAllAudio, arg_48_0)
	arg_48_0:_removeEffectAudio()
	TaskDispatcher.cancelTask(arg_48_0._addMapLight, arg_48_0)
end

function var_0_0._stopAreaAudio(arg_49_0)
	if arg_49_0._mapAudioGo then
		gohelper.destroy(arg_49_0._mapAudioGo)

		arg_49_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
		AudioMgr.instance:trigger(AudioEnum.Bgm.Stop_FightingMusic)
	end
end

function var_0_0._showMapTip(arg_50_0)
	gohelper.setActive(arg_50_0._gotoptipsbg, false)
end

function var_0_0._hideMapTip(arg_51_0)
	gohelper.setActive(arg_51_0._gotoptipsbg, false)
end

function var_0_0.onOpen(arg_52_0)
	arg_52_0._showSceneChangeAnimState = var_0_1.None

	gohelper.setActive(arg_52_0._animchangeScene, false)
end

function var_0_0._onScreenResize(arg_53_0)
	if arg_53_0._sceneGo then
		arg_53_0:_initScene()
	end
end

function var_0_0._onStoryFinish(arg_54_0)
	TaskDispatcher.cancelTask(arg_54_0._checkSceneVisible, arg_54_0)
	TaskDispatcher.runRepeat(arg_54_0._checkSceneVisible, arg_54_0, 0)
	arg_54_0:_updateSwitchState()
end

function var_0_0._checkSceneVisible(arg_55_0)
	if ViewHelper.instance:checkViewOnTheTop(ViewName.DungeonMapView) then
		TaskDispatcher.cancelTask(arg_55_0._checkSceneVisible, arg_55_0)

		if not gohelper.isNil(arg_55_0._sceneRoot) and not arg_55_0._sceneRoot.activeSelf then
			logError("DungeonMapScene _checkSceneVisible is hided!")
			arg_55_0:setSceneVisible(true)
		end
	end
end

function var_0_0._focusElementById(arg_56_0, arg_56_1)
	arg_56_1 = tonumber(arg_56_1)

	local var_56_0, var_56_1 = arg_56_0:_getFocusPos(arg_56_1)

	arg_56_0:setScenePosSafety(Vector3(var_56_0, var_56_1, 0), not DungeonMapModel.instance.directFocusElement)
end

function var_0_0._getFocusPos(arg_57_0, arg_57_1)
	local var_57_0 = lua_chapter_map_element.configDict[arg_57_1]
	local var_57_1 = string.splitToNumber(var_57_0.pos, "#")
	local var_57_2 = var_57_1[1] or 0
	local var_57_3 = var_57_1[2] or 0
	local var_57_4 = string.splitToNumber(var_57_0.offsetPos, "#")
	local var_57_5 = var_57_2 + (var_57_4[1] or 0)
	local var_57_6 = var_57_3 + (var_57_4[2] or 0)
	local var_57_7 = arg_57_0._mapMaxX - var_57_5 + arg_57_0._viewWidth / 2
	local var_57_8 = arg_57_0._mapMinY - var_57_6 - arg_57_0._viewHeight / 2 + 2

	return var_57_7, var_57_8
end

function var_0_0._OnChangeMap(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1[1]

	arg_58_0._episodeConfig = arg_58_1[2]

	if var_58_0 == arg_58_0._mapCfg then
		arg_58_0:_setInitPos(true)

		return
	end

	arg_58_0:_changeMap(var_58_0)
end

function var_0_0._delaySendGuideEnterDungeonMapEvent(arg_59_0)
	TaskDispatcher.runDelay(arg_59_0._sendGuideEnterDungeonMapEvent, arg_59_0, 0.5)
end

function var_0_0._sendGuideEnterDungeonMapEvent(arg_60_0)
	local var_60_0 = arg_60_0.viewParam.chapterId

	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, var_60_0)
end

function var_0_0._delaySendGuideEnterEpisodeDungeonMapView(arg_61_0)
	TaskDispatcher.runDelay(arg_61_0._sendGuideEnterEpisodeDungeonMapView, arg_61_0, 0.1)
end

function var_0_0._sendGuideEnterEpisodeDungeonMapView(arg_62_0)
	if arg_62_0._mapCfg then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterEpisodeDungeonMapView, arg_62_0._mapCfg.id)
	end
end

function var_0_0.onClose(arg_63_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_uinoise_bus)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Bgm.Main1_6Effect)
	TaskDispatcher.cancelTask(arg_63_0._delayShowScene, arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._delayCloseEnd, arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._sendGuideEnterDungeonMapEvent, arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._delaySendGuideEnterEpisodeDungeonMapView, arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._checkSceneVisible, arg_63_0)
	gohelper.destroy(arg_63_0._sceneRoot)
	arg_63_0:_stopAreaAudio()
	arg_63_0:disposeOldMap()
	arg_63_0:_removeEffectAudio(true)

	if arg_63_0._mapLoader then
		arg_63_0._mapLoader:dispose()
	end

	arg_63_0._drag:RemoveDragBeginListener()
	arg_63_0._drag:RemoveDragListener()
	arg_63_0._drag:RemoveDragEndListener()
	arg_63_0:removeEvents()
end

function var_0_0.onDestroyView(arg_64_0)
	TaskDispatcher.cancelTask(arg_64_0._hideMapTip, arg_64_0)
end

return var_0_0
