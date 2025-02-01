module("modules.logic.toughbattle.view.ToughBattleMapScene", package.seeall)

slot0 = class("ToughBattleMapScene", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gofullscreen)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(ToughBattleController.instance, ToughBattleEvent.StageUpdate, slot0.loadMap, slot0)
	slot0:addEventCb(ToughBattleController.instance, ToughBattleEvent.BeginPlayFightSucessAnim, slot0.playSuccAnim, slot0)
	slot0:addEventCb(ToughBattleController.instance, ToughBattleEvent.GuideSetElementsActive, slot0._setElementsActive, slot0)
	slot0:addEventCb(ToughBattleController.instance, ToughBattleEvent.GuideClickElement, slot0._guideClickElement, slot0)
	slot0:addEventCb(ToughBattleController.instance, ToughBattleEvent.GuideFocusElement, slot0._guideFocusElement, slot0)
end

function slot0.removeEvents(slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.StageUpdate, slot0.loadMap, slot0)
	slot0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.BeginPlayFightSucessAnim, slot0.playSuccAnim, slot0)
	slot0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.GuideSetElementsActive, slot0._setElementsActive, slot0)
	slot0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.GuideClickElement, slot0._guideClickElement, slot0)
	slot0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.GuideFocusElement, slot0._guideFocusElement, slot0)
end

function slot0._editableInitView(slot0)
	slot0._tempVector = Vector3()
	slot0._dragDeltaPos = Vector3()
	slot0._scenePos = Vector3()

	slot0:_initMapRootNode()
end

function slot0.onOpen(slot0)
	slot0:loadMap()
	MainCameraMgr.instance:addView(slot0.viewName, slot0._initCamera, nil, slot0)
end

function slot0._onScreenResize(slot0)
	if slot0._sceneGo then
		CameraMgr.instance:getMainCamera().orthographicSize = ToughBattleEnum.DungeonMapCameraSize * GameUtil.getAdapterScale()

		slot0:_initScene()
	end
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = ToughBattleEnum.DungeonMapCameraSize * GameUtil.getAdapterScale()
end

function slot0.loadMap(slot0)
	if slot0._mapLoader then
		slot0._oldMapLoader = slot0._mapLoader
	end

	slot0._mapCfg = lua_chapter_map.configDict[slot0:getNowShowStage() == 1 and ToughBattleEnum.MapId_stage1 or ToughBattleEnum.MapId_stage2]
	slot0._mapLoader = MultiAbLoader.New()
	slot3 = {}

	slot0:buildLoadRes(slot3, slot0._mapCfg, slot1)

	slot0._sceneUrl = slot3[1]
	slot0._mapLightUrl = slot3[2]
	slot0._mapEffectUrl = slot3[3]

	slot0._mapLoader:addPath(slot0._sceneUrl)
	slot0._mapLoader:addPath(slot0._mapLightUrl)

	if slot0._mapEffectUrl then
		slot0._mapLoader:addPath(slot0._mapEffectUrl)
	end

	slot0._mapLoader:startLoad(slot0._loadSceneFinish, slot0)
end

function slot0.buildLoadRes(slot0, slot1, slot2, slot3)
	table.insert(slot1, ResUrl.getDungeonMapRes(slot2.res))
	table.insert(slot1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")

	if slot3 == 2 then
		table.insert(slot1, "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect3.prefab")
	end
end

function slot0._loadSceneFinish(slot0)
	if slot0._oldMapLoader then
		slot0._oldMapLoader:dispose()

		slot0._oldMapLoader = nil

		gohelper.destroy(slot0._sceneGo)
	end

	slot1 = slot0._sceneUrl
	slot0._sceneGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneRoot, slot0._mapCfg.id)
	slot0._sceneTrans = slot0._sceneGo.transform

	slot0:_initScene()
	slot0:_initSceneEffect()
	slot0:_addMapLight()
	slot0:_initElements()
	slot0:_setMapPos()
end

function slot0._initSceneEffect(slot0)
	if not slot0._mapEffectUrl then
		return
	end

	gohelper.clone(slot0._mapLoader:getAssetItem(slot0._mapEffectUrl):GetResource(slot0._mapEffectUrl), slot0._sceneGo)
end

function slot0._initScene(slot0)
	slot2 = gohelper.findChild(slot0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider))
	slot0._mapSize = slot2.size
	slot3 = slot2.center
	slot4 = slot3.x - slot0._mapSize.x / 2
	slot5 = slot3.y + slot0._mapSize.y / 2
	slot6 = nil
	slot8 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot11 = ToughBattleEnum.DungeonMapCameraSize / (CameraMgr.instance:getUICamera() and slot9.orthographicSize or 5)
	slot12 = slot8[1] * slot7 * slot11
	slot13 = slot8[3] * slot7 * slot11
	slot0._viewWidth = math.abs(slot13.x - slot12.x)
	slot0._viewHeight = math.abs(slot13.y - slot12.y)
	slot0._mapMinX = slot12.x - (slot0._mapSize.x - slot0._viewWidth) - slot4
	slot0._mapMaxX = slot12.x - slot4
	slot0._mapMinY = slot12.y - slot5
	slot0._mapMaxY = slot12.y + slot0._mapSize.y - slot0._viewHeight - slot5
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

	slot0._downElement = nil
	slot3 = slot0:getDragWorldPos(slot2)
	slot4 = slot3 - slot0._dragBeginPos
	slot0._dragBeginPos = slot3

	slot0._tempVector:Set(slot0._scenePos.x + slot4.x, slot0._scenePos.y + slot4.y)
	slot0:directSetScenePos(slot0._tempVector)
end

function slot0.getDragWorldPos(slot0, slot1)
	return SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot1.position, CameraMgr.instance:getMainCamera(), slot0._gofullscreen.transform.position)
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

function slot0._addMapLight(slot0)
	slot1 = slot0._mapLightUrl

	gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneGo)
end

function slot0.tweenFinishCallback(slot0)
	slot0._tempVector:Set(slot0._tweenTargetPosX, slot0._tweenTargetPosY, 0)
	slot0:directSetScenePos(slot0._tempVector)
	slot0:onTweenFinish()
end

function slot0.directSetScenePos(slot0, slot1)
	slot0._downElement = nil
	slot0._scenePos.x, slot0._scenePos.y = slot0:getTargetPos(slot1)

	if not slot0._sceneTrans or gohelper.isNil(slot0._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(slot0._sceneTrans, slot0._scenePos.x, slot0._scenePos.y, 0)
end

function slot0._initElements(slot0)
	slot0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(slot0._sceneGo, slot0._elementRoot)

	slot0._elementFinishRoot = UnityEngine.GameObject.New("elementRootFinish")

	gohelper.addChild(slot0._sceneGo, slot0._elementFinishRoot)

	slot0.tempInitPosX = nil
	slot0.tempInitPosY = nil
	slot0.needTween = nil
	slot0._finishIcons = {}
	slot3 = DungeonConfig.instance:getMapElements(slot0:getNowShowStage() == 1 and ToughBattleEnum.MapId_stage1 or ToughBattleEnum.MapId_stage2)
	slot4 = nil
	slot5 = slot0:getInfo()

	if slot1 == 1 then
		for slot9 = 1, 5 do
			if slot0:getCo(slot9).guideId and slot10.guideId > 0 and GuideModel.instance:getById(slot10.guideId) and slot11.isFinish and not tabletool.indexOf(slot5.passChallengeIds, slot10.id) then
				slot4 = slot9

				break
			end
		end
	end

	slot6 = slot0.viewParam.lastFightSuccIndex

	for slot10, slot11 in ipairs(slot3) do
		slot14 = tabletool.indexOf(slot5.passChallengeIds, slot0:getCo(tonumber(slot11.param)).id)

		if not slot4 or slot12 == slot4 or slot14 then
			if slot14 then
				slot15 = UnityEngine.GameObject.New(tostring(slot11.id))

				gohelper.addChild(slot0._elementFinishRoot, slot15)

				slot17 = gohelper.create3d(slot15, "icon")
				slot19 = PrefabInstantiate.Create(slot17)
				slot20 = ToughBattleEnum.FinishIconPos[slot12]

				transformhelper.setLocalPosXY(slot17.transform, slot20.x, slot20.y)
				PrefabInstantiate.Create(gohelper.create3d(slot15, "boss")):startLoad("scenes/v1a9_m_s08_hddt/prefab/m_s08_hddt_obj_boss" .. slot12 .. ".prefab")
				slot19:startLoad("scenes/v1a9_m_s08_hddt/prefab/hddt_icon_toughbattle_wancheng.prefab", uv0.onFinishIconLoaded, {
					slot0,
					slot12,
					slot13.sort == slot6,
					slot19
				})
			else
				slot15 = UnityEngine.GameObject.New(tostring(slot11.id))

				gohelper.addChild(slot0._elementRoot, slot15)
				MonoHelper.addLuaComOnceToGo(slot15, ToughBattleMapElement, {
					slot11,
					slot0
				})
			end

			if slot12 == slot6 then
				slot16 = string.splitToNumber(slot0._mapCfg.initPos, "#")
				slot0._oldScenePos = Vector2(slot16[1], slot16[2])
				slot0.tempInitPosX = -string.splitToNumber(slot11.pos, "#")[1] or 0
				slot0.tempInitPosY = -slot16[2] or 0
				slot0.needTween = true
			end
		end
	end

	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.GuideCurStage, slot1)
	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.InitFightIndex, tostring(#slot5.passChallengeIds + 1))
end

function slot0._setElementsActive(slot0, slot1)
	gohelper.setActive(slot0._elementRoot, slot1 == "true" and true or false)
end

function slot0._guideFocusElement(slot0, slot1)
	for slot9, slot10 in ipairs(DungeonConfig.instance:getMapElements(slot0:getNowShowStage() == 1 and ToughBattleEnum.MapId_stage1 or ToughBattleEnum.MapId_stage2)) do
		if tonumber(slot1) == tonumber(slot10.param) then
			slot0.tempInitPosX = -string.splitToNumber(slot10.pos, "#")[1] or 0
			slot0.tempInitPosY = -slot12[2] or 0
			slot0.needTween = true

			slot0:_setMapPos()

			break
		end
	end
end

function slot0._guideClickElement(slot0, slot1)
	slot2 = tonumber(slot1)

	slot0:onEnterFight(slot0:getCo(slot2), slot2 == 6 and 2 or 1)
end

function slot0.playSuccAnim(slot0)
	if not slot0._finishIcons or not slot0._finishIcons[slot0.viewParam.lastFightSuccIndex] then
		return
	end

	slot0._finishIcons[slot0.viewParam.lastFightSuccIndex]:Play("open", 0, 0)
end

function slot0.onFinishIconLoaded(slot0)
	slot0[1]._finishIcons[slot0[2]] = slot0[4]:getInstGO():GetComponent(typeof(UnityEngine.Animator))

	if slot0[3] then
		slot6:Play("open", 0, 0)
	else
		slot6:Play("open", 0, 1)
	end
end

function slot0.onTweenFinish(slot0)
end

function slot0.getInfo(slot0)
	return slot0.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()
end

function slot0.getNowShowStage(slot0)
	if #slot0:getInfo().passChallengeIds >= 3 and not slot0.viewParam.lastFightSuccIndex then
		return 2
	else
		return 1
	end
end

function slot0.setMouseElementUp(slot0, slot1)
	if slot0._downElement ~= slot1 then
		return
	end

	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0._downElement = false

		return
	end

	if slot0.viewParam.lastFightSuccIndex then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	slot3 = tonumber(slot1._config.param)

	slot0:onEnterFight(slot0:getCo(slot3), slot3 == 6 and 2 or 1)
end

function slot0.getCo(slot0, slot1)
	if slot0.viewParam.mode == ToughBattleEnum.Mode.Act then
		if slot1 == 6 then
			return ToughBattleConfig.instance:getCOByDiffcult(slot0:getInfo().currDifficulty).stage2
		else
			return slot3.stage1[slot1]
		end
	elseif slot1 == 6 then
		return ToughBattleConfig.instance:getStoryCO().stage2
	else
		return slot2.stage1[slot1]
	end
end

function slot0.setMouseElementDown(slot0, slot1)
	slot0._downElement = slot1
end

function slot0.onEnterFight(slot0, slot1, slot2)
	if tabletool.indexOf(slot0:getInfo().passChallengeIds, slot1.id) then
		return
	end

	if slot2 == 1 then
		ViewMgr.instance:openView(ViewName.ToughBattleEnemyInfoView, slot1)
	else
		slot4 = slot1.episodeId

		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot4).chapterId, slot4)
	end
end

function slot0.tweenSetScenePos(slot0, slot1, slot2)
	slot0._tweenTargetPosX, slot0._tweenTargetPosY = slot0:getTargetPos(slot1)
	slot0._tweenStartPosX, slot0._tweenStartPosY = slot0:getTargetPos(slot2 or slot0._scenePos)

	slot0:killTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, slot0.tweenFrameCallback, slot0.tweenFinishCallback, slot0)

	slot0:tweenFrameCallback(0)
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end
end

function slot0.tweenFrameCallback(slot0, slot1)
	slot0._tempVector:Set(Mathf.Lerp(slot0._tweenStartPosX, slot0._tweenTargetPosX, slot1), Mathf.Lerp(slot0._tweenStartPosY, slot0._tweenTargetPosY, slot1), 0)
	slot0:directSetScenePos(slot0._tempVector)
end

function slot0.getTargetPos(slot0, slot1)
	slot2 = slot1.x

	if not slot0._mapMinX or not slot0._mapMinY then
		return slot2, slot1.y
	end

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

	return slot2, slot3
end

function slot0._initMapRootNode(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("ToughBattleMapScene")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.setSceneVisible(slot0, slot1)
	gohelper.setActive(slot0._sceneRoot, slot1)
end

function slot0.onClose(slot0)
	if slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end

	gohelper.destroy(slot0._sceneRoot)
end

return slot0
