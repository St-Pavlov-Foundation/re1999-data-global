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
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.StoryView then
		arg_6_0:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, arg_6_0)
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.StoryView then
		arg_7_0:_rebuildScene()
	end
end

function var_0_0.setSceneVisible(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._sceneRoot, arg_8_1 and true or false)

	if arg_8_1 then
		local var_8_0 = arg_8_0.viewParam.chapterId

		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, var_8_0)
	end
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._dragBeginPos = arg_9_0:getDragWorldPos(arg_9_2)

	if arg_9_0._sceneTrans then
		arg_9_0._beginDragPos = arg_9_0._sceneTrans.localPosition
	end
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._dragBeginPos = nil
	arg_10_0._beginDragPos = nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)

	local var_11_0 = arg_11_0:getDragWorldPos(arg_11_2) - arg_11_0._dragBeginPos

	arg_11_0:drag(var_11_0)
end

function var_0_0.drag(arg_12_0, arg_12_1)
	if not arg_12_0._sceneTrans or not arg_12_0._beginDragPos then
		return
	end

	arg_12_0._dragDeltaPos.x = arg_12_1.x
	arg_12_0._dragDeltaPos.y = arg_12_1.y

	local var_12_0 = arg_12_0:vectorAdd(arg_12_0._beginDragPos, arg_12_0._dragDeltaPos)

	arg_12_0:setScenePosSafety(var_12_0)
	arg_12_0:_updateElementArrow()
end

function var_0_0._updateElementArrow(arg_13_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function var_0_0.setScenePosSafety(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0._sceneTrans then
		return
	end

	if arg_14_1.x < arg_14_0._mapMinX then
		arg_14_1.x = arg_14_0._mapMinX
	elseif arg_14_1.x > arg_14_0._mapMaxX then
		arg_14_1.x = arg_14_0._mapMaxX
	end

	if arg_14_1.y < arg_14_0._mapMinY then
		arg_14_1.y = arg_14_0._mapMinY
	elseif arg_14_1.y > arg_14_0._mapMaxY then
		arg_14_1.y = arg_14_0._mapMaxY
	end

	arg_14_0._targetPos = arg_14_1

	if arg_14_2 then
		local var_14_0 = arg_14_0._tweenTime or 0.46

		UIBlockHelper.instance:startBlock("DungeonMapSceneTweenPos", var_14_0, arg_14_0.viewName)
		ZProj.TweenHelper.DOLocalMove(arg_14_0._sceneTrans, arg_14_1.x, arg_14_1.y, 0, var_14_0, arg_14_0._localMoveDone, arg_14_0, nil, EaseType.OutQuad)
	else
		arg_14_0._sceneTrans.localPosition = arg_14_1

		arg_14_0:_updateElementArrow()
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnMapPosChanged, arg_14_1, arg_14_2)
end

function var_0_0._localMoveDone(arg_15_0)
	arg_15_0:_updateElementArrow()
end

function var_0_0.vectorAdd(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._tempVector

	var_16_0.x = arg_16_1.x + arg_16_2.x
	var_16_0.y = arg_16_1.y + arg_16_2.y

	return var_16_0
end

function var_0_0.getDragWorldPos(arg_17_0, arg_17_1)
	local var_17_0 = CameraMgr.instance:getMainCamera()
	local var_17_1 = arg_17_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_17_1.position, var_17_0, var_17_1))
end

function var_0_0._initCamera(arg_18_0)
	local var_18_0 = CameraMgr.instance:getMainCamera()

	var_18_0.orthographic = true
	var_18_0.orthographicSize = 5 * GameUtil.getAdapterScale()
end

function var_0_0._initMap(arg_19_0)
	local var_19_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_19_1 = CameraMgr.instance:getSceneRoot()

	arg_19_0._sceneRoot = UnityEngine.GameObject.New("DungeonMapScene")

	local var_19_2, var_19_3, var_19_4 = transformhelper.getLocalPos(var_19_0)

	transformhelper.setLocalPos(arg_19_0._sceneRoot.transform, 0, var_19_3, 0)
	gohelper.addChild(var_19_1, arg_19_0._sceneRoot)
end

function var_0_0.getSceneGo(arg_20_0)
	return arg_20_0._sceneGo
end

function var_0_0.getChangeMapStatus(arg_21_0)
	if not arg_21_0._compareCur or not arg_21_0._compareLast then
		return
	end

	if arg_21_0._compareCur.mapState ~= arg_21_0._compareLast.mapState then
		return arg_21_0._compareCur.mapState
	end
end

function var_0_0._changeMap(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_1 or arg_22_0._mapCfg == arg_22_1 and not arg_22_2 then
		return
	end

	arg_22_0._showSceneChangeAnimState = var_0_1.None

	if arg_22_0._mapCfg then
		local var_22_0 = arg_22_0._mapCfg.mapIdGroup
		local var_22_1 = arg_22_1.mapIdGroup

		if ToughBattleModel.instance:getIsJumpActElement() or var_22_0 and var_22_0 > 0 and var_22_1 and var_22_1 ~= var_22_0 then
			arg_22_0._showSceneChangeAnimState = var_0_1.NoStart
		end
	end

	arg_22_0._compareLast = arg_22_0._mapCfg
	arg_22_0._compareCur = arg_22_1

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	arg_22_0._tempMapCfg = nil

	if not arg_22_0._oldMapLoader and arg_22_0._sceneGo then
		arg_22_0._oldMapLoader = arg_22_0._mapLoader
		arg_22_0._oldSceneGo = arg_22_0._sceneGo
		arg_22_0._mapLoader = nil
	end

	if arg_22_0._mapLoader then
		arg_22_0._mapLoader:dispose()

		arg_22_0._mapLoader = nil
	end

	arg_22_0._mapCfg = arg_22_1

	local var_22_2 = arg_22_1.res

	arg_22_0._mapLoader = MultiAbLoader.New()

	local var_22_3 = {}

	var_0_0._preloadRes(var_22_3, arg_22_0._mapCfg)

	arg_22_0._canvasUrl = var_22_3[1]
	arg_22_0._interactiveItemUrl = var_22_3[2]
	arg_22_0._sceneUrl = var_22_3[3]

	arg_22_0._mapLoader:addPath(arg_22_0._sceneUrl)

	arg_22_0._mapAudioUrl = var_22_3[4]
	arg_22_0._mapLightUrl = var_22_3[5]

	arg_22_0._mapLoader:addPath(arg_22_0._canvasUrl)
	arg_22_0._mapLoader:addPath(arg_22_0._interactiveItemUrl)
	arg_22_0._mapLoader:addPath(arg_22_0._mapAudioUrl)
	arg_22_0._mapLoader:addPath(arg_22_0._mapLightUrl)

	arg_22_0._mapExEffectPath = DungeonEnum.MapExEffectPath[arg_22_0._mapCfg.id]

	if arg_22_0._mapExEffectPath then
		arg_22_0._mapLoader:addPath(arg_22_0._mapExEffectPath)
	end

	arg_22_0:preloadElementRes(arg_22_0._mapLoader)

	if arg_22_0._showSceneChangeAnimState == var_0_1.NoStart then
		arg_22_0._animchangeScene:Play("open", 0, 0)
		gohelper.setActive(arg_22_0._animchangeScene, true)
		TaskDispatcher.cancelTask(arg_22_0._delayShowScene, arg_22_0)
		TaskDispatcher.runDelay(arg_22_0._delayShowScene, arg_22_0, 0.5)
		UIBlockHelper.instance:startBlock("DungeonSceneChangeAnimStart", 0.5, arg_22_0.viewName)
	end

	arg_22_0._mapLoader:startLoad(arg_22_0._loadSceneFinish, arg_22_0)
end

function var_0_0._delayShowScene(arg_23_0)
	if arg_23_0._showSceneChangeAnimState == var_0_1.ResLoad then
		arg_23_0._showSceneChangeAnimState = var_0_1.OpenEnd

		arg_23_0:_loadSceneFinish()
	elseif arg_23_0._showSceneChangeAnimState == var_0_1.NoStart then
		arg_23_0._showSceneChangeAnimState = var_0_1.OpenEnd
	end
end

function var_0_0.playSceneChangeClose(arg_24_0)
	arg_24_0._animchangeScene:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_24_0._delayCloseEnd, arg_24_0, 0.5)
	UIBlockHelper.instance:startBlock("DungeonSceneChangeAnimEnd", 0.5, arg_24_0.viewName)
end

function var_0_0._delayCloseEnd(arg_25_0)
	arg_25_0._showSceneChangeAnimState = var_0_1.None

	gohelper.setActive(arg_25_0._animchangeScene, false)
end

function var_0_0.preloadElementRes(arg_26_0, arg_26_1)
	local var_26_0 = DungeonMapModel.instance:getElements(arg_26_0._mapCfg.id)

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		if iter_26_1.type == DungeonEnum.ElementType.ToughBattle and not string.nilorempty(iter_26_1.res) then
			arg_26_1:addPath(iter_26_1.res)
		end
	end
end

function var_0_0._loadSceneFinish(arg_27_0)
	if gohelper.isNil(arg_27_0._sceneRoot) then
		logError("DungeonMapScene 节点没了？？？" .. arg_27_0.viewContainer._viewStatus)

		return
	end

	if arg_27_0._showSceneChangeAnimState == var_0_1.NoStart then
		arg_27_0._showSceneChangeAnimState = var_0_1.ResLoad

		return
	elseif arg_27_0._showSceneChangeAnimState == var_0_1.OpenEnd then
		arg_27_0:playSceneChangeClose()
	end

	if arg_27_0._curMapAreaAudio ~= arg_27_0._mapCfg.areaAudio then
		arg_27_0:_stopAreaAudio()
	elseif arg_27_0._mapAudioGo then
		gohelper.addChild(arg_27_0._sceneRoot, arg_27_0._mapAudioGo)
	end

	arg_27_0:disposeOldMap()

	local var_27_0 = arg_27_0._sceneUrl
	local var_27_1 = arg_27_0._mapLoader:getAssetItem(var_27_0):GetResource(var_27_0)

	arg_27_0._sceneGo = gohelper.clone(var_27_1, arg_27_0._sceneRoot, arg_27_0._mapCfg.id)
	arg_27_0._sceneTrans = arg_27_0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		arg_27_0._mapCfg,
		arg_27_0._sceneGo,
		arg_27_0
	})
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowMap)
	TaskDispatcher.runDelay(arg_27_0._addAllAudio, arg_27_0, 0.2)
	MainCameraMgr.instance:addView(arg_27_0.viewName, arg_27_0._initCamera, nil, arg_27_0)
	arg_27_0:_initScene()
	arg_27_0:_initCanvas()
	arg_27_0:_initExEffect()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterEpisodeDungeonMapView, arg_27_0._mapCfg.id)

	if arg_27_0._mapCfg.id == 10721 or arg_27_0._mapCfg.id == 10728 then
		TaskDispatcher.runDelay(arg_27_0._addMapLight, arg_27_0, 0)
	else
		TaskDispatcher.runDelay(arg_27_0._addMapLight, arg_27_0, 0.3)
	end

	arg_27_0:_showMapTip()

	arg_27_0._switchState1 = gohelper.findChild(arg_27_0._sceneGo, "Obj-Plant/all/switch/state_1")
	arg_27_0._switchState2 = gohelper.findChild(arg_27_0._sceneGo, "Obj-Plant/all/switch/state_2")

	arg_27_0:_updateSwitchState()
end

function var_0_0._initExEffect(arg_28_0)
	if arg_28_0._mapExEffectPath then
		local var_28_0 = arg_28_0._mapLoader:getAssetItem(arg_28_0._mapExEffectPath):GetResource(arg_28_0._mapExEffectPath)

		gohelper.clone(var_28_0, arg_28_0._sceneGo)
	end
end

function var_0_0._addAllAudio(arg_29_0)
	arg_29_0:_addMapAudio()
	arg_29_0:_addEffectAudio()
end

function var_0_0._updateSwitchState(arg_30_0)
	if not arg_30_0._switchState1 or not arg_30_0._switchState2 then
		return
	end

	if not arg_30_0._episodeConfig then
		return
	end

	local var_30_0 = DungeonModel.instance:hasPassLevelAndStory(arg_30_0._episodeConfig.id)

	gohelper.setActive(arg_30_0._switchState1, not var_30_0)
	gohelper.setActive(arg_30_0._switchState2, var_30_0)
end

function var_0_0._preloadRes(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	table.insert(arg_31_0, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(arg_31_0, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")

	if arg_31_2 then
		arg_31_1 = DungeonMapChapterLayout.getFocusMap(arg_31_2, arg_31_3)
		DungeonMapModel.instance.preloadMapCfg = arg_31_1
	end

	if not arg_31_1 then
		return
	end

	if not arg_31_2 then
		if DungeonMapModel.instance.preloadMapCfg and DungeonMapModel.instance.preloadMapCfg ~= arg_31_1 then
			logError(string.format("DungeonMapScene preload error preload:%s,normal:%s", DungeonMapModel.instance.preloadMapCfg.id, arg_31_1.id))
		end

		DungeonMapModel.instance.preloadMapCfg = nil
	end

	table.insert(arg_31_0, ResUrl.getDungeonMapRes(arg_31_1.res))
	var_0_0._addAudioAndLight(arg_31_0, arg_31_1)
end

function var_0_0._addAudioAndLight(arg_32_0, arg_32_1)
	if arg_32_1.chapterId == 103 then
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_03.prefab")
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light_03.prefab")
	elseif arg_32_1.chapterId == 104 then
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_04.prefab")
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light_04.prefab")
	elseif arg_32_1.chapterId == 105 then
		table.insert(arg_32_0, "scenes/v1a4_m_s08_hddt/scenes_prefab/v1a4_m_s08_hddt_audio.prefab")
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	elseif arg_32_1.chapterId == 310 then
		table.insert(arg_32_0, "scenes/v1a4_m_s08_hddt_jz/scene_prefab/v1a4_m_s08_hddt_jz_audio.prefab")
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	elseif arg_32_1.chapterId == DungeonEnum.ChapterId.Main1_6 then
		table.insert(arg_32_0, "scenes/v1a7_m_s08_hddt/scenes_prefab/v1a7_m_s08_hddt_audio.prefab")
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	else
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio.prefab")
		table.insert(arg_32_0, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	end
end

function var_0_0._disposeScene(arg_33_0)
	arg_33_0._oldScenePos = arg_33_0._targetPos
	arg_33_0._tempMapCfg = arg_33_0._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if arg_33_0._sceneGo then
		gohelper.destroy(arg_33_0._sceneGo)

		arg_33_0._sceneGo = nil
	end

	arg_33_0._sceneTrans = nil

	if arg_33_0._mapLoader then
		arg_33_0._mapLoader:dispose()

		arg_33_0._mapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_33_0._addMapLight, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._addAllAudio, arg_33_0)
	arg_33_0:_removeEffectAudio(true)
	arg_33_0:_stopAreaAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_uinoise_bus)
end

function var_0_0._rebuildScene(arg_34_0)
	arg_34_0:_changeMap(arg_34_0._tempMapCfg, true)

	arg_34_0._tempMapCfg = nil
end

function var_0_0._removeEffectAudio(arg_35_0, arg_35_1)
	if not arg_35_0._effectAudio then
		return
	end

	if arg_35_0._effectAudio == arg_35_0._mapCfg.effectAudio and not arg_35_1 then
		return
	end

	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)

	arg_35_0._effectAudio = nil
end

function var_0_0._addEffectAudio(arg_36_0)
	if arg_36_0._effectAudio == arg_36_0._mapCfg.effectAudio or arg_36_0._mapCfg.effectAudio <= 0 then
		return
	end

	arg_36_0._effectAudio = arg_36_0._mapCfg.effectAudio

	AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
end

function var_0_0._addMapLight(arg_37_0)
	local var_37_0 = arg_37_0._mapLightUrl
	local var_37_1 = arg_37_0._mapLoader:getAssetItem(var_37_0):GetResource(var_37_0)

	gohelper.clone(var_37_1, arg_37_0._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnNormalDungeonInitElements)
end

function var_0_0._addMapAudio(arg_38_0)
	if arg_38_0._mapAudioGo then
		gohelper.addChild(arg_38_0._sceneGo, arg_38_0._mapAudioGo)

		return
	end

	if arg_38_0._mapCfg.chapterId == DungeonEnum.ChapterId.Main1_6 and not arg_38_0.playingMain1_6Effect then
		arg_38_0.playingMain1_6Effect = true

		AudioEffectMgr.instance:playAudio(AudioEnum.Bgm.Main1_6Effect)
	end

	local var_38_0 = arg_38_0._mapAudioUrl
	local var_38_1 = arg_38_0._mapLoader:getAssetItem(var_38_0):GetResource(var_38_0)

	arg_38_0._mapAudioGo = gohelper.clone(var_38_1, arg_38_0._sceneGo, "audio")

	gohelper.addChild(arg_38_0._sceneGo, arg_38_0._mapAudioGo)
	transformhelper.setLocalPos(arg_38_0._mapAudioGo.transform, 0, 0, 0)

	local var_38_2 = arg_38_0._mapCfg.areaAudio

	if string.nilorempty(var_38_2) then
		return
	end

	arg_38_0._curMapAreaAudio = var_38_2

	local var_38_3 = gohelper.findChild(arg_38_0._mapAudioGo, "audio")

	if var_38_2 == "all" then
		local var_38_4 = var_38_3.transform
		local var_38_5 = var_38_4.childCount

		for iter_38_0 = 1, var_38_5 do
			local var_38_6 = var_38_4:GetChild(iter_38_0 - 1)

			gohelper.setActive(var_38_6.gameObject, true)
		end

		return
	end

	local var_38_7 = string.split(var_38_2, "#")

	for iter_38_1, iter_38_2 in ipairs(var_38_7) do
		local var_38_8 = gohelper.findChild(var_38_3, iter_38_2)

		gohelper.setActive(var_38_8, true)
	end
end

function var_0_0._initCanvas(arg_39_0)
	local var_39_0 = arg_39_0._mapLoader:getAssetItem(arg_39_0._canvasUrl):GetResource(arg_39_0._canvasUrl)

	arg_39_0._sceneCanvasGo = gohelper.clone(var_39_0, arg_39_0._sceneGo)
	arg_39_0._sceneCanvas = arg_39_0._sceneCanvasGo:GetComponent("Canvas")
	arg_39_0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_39_0._itemPrefab = arg_39_0._mapLoader:getAssetItem(arg_39_0._interactiveItemUrl):GetResource(arg_39_0._interactiveItemUrl)
end

function var_0_0.getInteractiveItem(arg_40_0)
	arg_40_0._uiGo = gohelper.clone(arg_40_0._itemPrefab, arg_40_0._sceneCanvasGo)
	arg_40_0._interactiveItem = MonoHelper.addLuaComOnceToGo(arg_40_0._uiGo, DungeonMapInteractiveItem)

	gohelper.setActive(arg_40_0._uiGo, false)

	return arg_40_0._interactiveItem
end

function var_0_0.showInteractiveItem(arg_41_0)
	return not gohelper.isNil(arg_41_0._uiGo)
end

function var_0_0._initScene(arg_42_0)
	arg_42_0._mapSize = gohelper.findChild(arg_42_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_42_0
	local var_42_1 = GameUtil.getAdapterScale()

	if var_42_1 ~= 1 then
		var_42_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_42_0 = ViewMgr.instance:getUIRoot()
	end

	local var_42_2 = var_42_0.transform:GetWorldCorners()
	local var_42_3 = var_42_2[1] * var_42_1
	local var_42_4 = var_42_2[3] * var_42_1

	arg_42_0._viewWidth = math.abs(var_42_4.x - var_42_3.x)
	arg_42_0._viewHeight = math.abs(var_42_4.y - var_42_3.y)
	arg_42_0._mapMinX = var_42_3.x - (arg_42_0._mapSize.x - arg_42_0._viewWidth)
	arg_42_0._mapMaxX = var_42_3.x
	arg_42_0._mapMinY = var_42_3.y
	arg_42_0._mapMaxY = var_42_3.y + (arg_42_0._mapSize.y - arg_42_0._viewHeight)

	if arg_42_0._oldScenePos then
		arg_42_0._sceneTrans.localPosition = arg_42_0._oldScenePos
	end

	arg_42_0:_setInitPos(arg_42_0._oldScenePos)

	arg_42_0._oldScenePos = nil
end

function var_0_0._setInitPos(arg_43_0, arg_43_1)
	if not arg_43_0._mapCfg then
		return
	end

	if ToughBattleModel.instance:getIsJumpActElement() then
		DungeonMapModel.instance.directFocusElement = true

		arg_43_0:_focusElementById(ToughBattleEnum.ActElementId)

		DungeonMapModel.instance.directFocusElement = false

		return
	end

	local var_43_0 = arg_43_0._mapCfg.initPos
	local var_43_1 = string.splitToNumber(var_43_0, "#")

	arg_43_0:setScenePosSafety(Vector3(var_43_1[1], var_43_1[2], 0), arg_43_1)
end

function var_0_0.disposeOldMap(arg_44_0)
	if arg_44_0._sceneTrans then
		arg_44_0._oldScenePos = arg_44_0._sceneTrans.localPosition
	else
		arg_44_0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_44_0.viewName)

	if arg_44_0._oldSceneGo then
		gohelper.destroy(arg_44_0._oldSceneGo)

		arg_44_0._oldSceneGo = nil
	end

	if arg_44_0._oldMapLoader then
		arg_44_0._oldMapLoader:dispose()

		arg_44_0._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_44_0._addAllAudio, arg_44_0)
	arg_44_0:_removeEffectAudio()
	TaskDispatcher.cancelTask(arg_44_0._addMapLight, arg_44_0)
end

function var_0_0._stopAreaAudio(arg_45_0)
	if arg_45_0._mapAudioGo then
		gohelper.destroy(arg_45_0._mapAudioGo)

		arg_45_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
		AudioMgr.instance:trigger(AudioEnum.Bgm.Stop_FightingMusic)
	end
end

function var_0_0._showMapTip(arg_46_0)
	gohelper.setActive(arg_46_0._gotoptipsbg, false)
end

function var_0_0._hideMapTip(arg_47_0)
	gohelper.setActive(arg_47_0._gotoptipsbg, false)
end

function var_0_0.onOpen(arg_48_0)
	arg_48_0._showSceneChangeAnimState = var_0_1.None

	gohelper.setActive(arg_48_0._animchangeScene, false)
end

function var_0_0._onScreenResize(arg_49_0)
	if arg_49_0._sceneGo then
		arg_49_0:_initScene()
	end
end

function var_0_0._onStoryFinish(arg_50_0)
	arg_50_0:_updateSwitchState()
end

function var_0_0._focusElementById(arg_51_0, arg_51_1)
	arg_51_1 = tonumber(arg_51_1)

	local var_51_0, var_51_1 = arg_51_0:_getFocusPos(arg_51_1)

	arg_51_0:setScenePosSafety(Vector3(var_51_0, var_51_1, 0), not DungeonMapModel.instance.directFocusElement)
end

function var_0_0._getFocusPos(arg_52_0, arg_52_1)
	local var_52_0 = lua_chapter_map_element.configDict[arg_52_1]
	local var_52_1 = string.splitToNumber(var_52_0.pos, "#")
	local var_52_2 = var_52_1[1] or 0
	local var_52_3 = var_52_1[2] or 0
	local var_52_4 = string.splitToNumber(var_52_0.offsetPos, "#")
	local var_52_5 = var_52_2 + (var_52_4[1] or 0)
	local var_52_6 = var_52_3 + (var_52_4[2] or 0)
	local var_52_7 = arg_52_0._mapMaxX - var_52_5 + arg_52_0._viewWidth / 2
	local var_52_8 = arg_52_0._mapMinY - var_52_6 - arg_52_0._viewHeight / 2 + 2

	return var_52_7, var_52_8
end

function var_0_0._OnChangeMap(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1[1]

	arg_53_0._episodeConfig = arg_53_1[2]

	if var_53_0 == arg_53_0._mapCfg then
		arg_53_0:_setInitPos(true)

		return
	end

	arg_53_0:_changeMap(var_53_0)
end

function var_0_0._delaySendGuideEnterDungeonMapEvent(arg_54_0)
	TaskDispatcher.runDelay(arg_54_0._sendGuideEnterDungeonMapEvent, arg_54_0, 0.5)
end

function var_0_0._sendGuideEnterDungeonMapEvent(arg_55_0)
	local var_55_0 = arg_55_0.viewParam.chapterId

	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, var_55_0)
end

function var_0_0._delaySendGuideEnterEpisodeDungeonMapView(arg_56_0)
	TaskDispatcher.runDelay(arg_56_0._sendGuideEnterEpisodeDungeonMapView, arg_56_0, 0.1)
end

function var_0_0._sendGuideEnterEpisodeDungeonMapView(arg_57_0)
	if arg_57_0._mapCfg then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterEpisodeDungeonMapView, arg_57_0._mapCfg.id)
	end
end

function var_0_0.onClose(arg_58_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_uinoise_bus)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Bgm.Main1_6Effect)
	TaskDispatcher.cancelTask(arg_58_0._delayShowScene, arg_58_0)
	TaskDispatcher.cancelTask(arg_58_0._delayCloseEnd, arg_58_0)
	TaskDispatcher.cancelTask(arg_58_0._sendGuideEnterDungeonMapEvent, arg_58_0)
	TaskDispatcher.cancelTask(arg_58_0._delaySendGuideEnterEpisodeDungeonMapView, arg_58_0)
	gohelper.destroy(arg_58_0._sceneRoot)
	arg_58_0:_stopAreaAudio()
	arg_58_0:disposeOldMap()
	arg_58_0:_removeEffectAudio(true)

	if arg_58_0._mapLoader then
		arg_58_0._mapLoader:dispose()
	end

	arg_58_0._drag:RemoveDragBeginListener()
	arg_58_0._drag:RemoveDragListener()
	arg_58_0._drag:RemoveDragEndListener()
	arg_58_0:removeEvents()
end

function var_0_0.onDestroyView(arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0._hideMapTip, arg_59_0)
end

return var_0_0
