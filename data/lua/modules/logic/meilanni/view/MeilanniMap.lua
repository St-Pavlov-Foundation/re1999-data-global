module("modules.logic.meilanni.view.MeilanniMap", package.seeall)

slot0 = class("MeilanniMap", BaseView)

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
	slot0:_initMap()
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

	if slot2 then
		ZProj.TweenHelper.DOLocalMove(slot0._sceneTrans, slot1.x, slot1.y, 0, 0.26)
	else
		slot0._sceneTrans.localPosition = slot1
	end
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true

	transformhelper.setLocalRotation(slot1.transform, 0, 0, 0)

	slot1.orthographicSize = MeilanniEnum.orthographicSize * GameUtil.getAdapterScale()
end

function slot0._resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = MeilanniEnum.orthographicSize
	slot1.orthographic = false
end

function slot0._initMap(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("MeilanniMap")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.onUpdateParam(slot0)
end

function slot0._showMap(slot0)
	slot0:_changeMap(slot0._mapInfo:getCurEpisodeInfo().episodeConfig)
end

function slot0._changeMap(slot0, slot1)
	if slot0._mapCfg == slot1 then
		return
	end

	if not slot0._oldMapLoader then
		slot0._oldMapLoader = slot0._mapLoader
		slot0._oldSceneGo = slot0._sceneGo
		slot0._oldSceneTrans = slot0._sceneTrans
	elseif slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end

	slot0._mapCfg = slot1

	slot0:_loadMap(slot1.res)
end

function slot0._loadMap(slot0, slot1)
	slot0._mapLoader = MultiAbLoader.New()

	slot0._mapLoader:addPath(slot1)
	slot0._mapLoader:startLoad(function (slot0)
		uv0._oldSceneGo = nil

		uv0:disposeOldMap()

		uv0._sceneGo = gohelper.clone(uv0._mapLoader:getAssetItem(uv1):GetResource(uv1), uv0._sceneRoot)

		gohelper.setActive(uv0._sceneGo, true)

		uv0._sceneTrans = uv0._sceneGo.transform

		uv0:_startFade(uv0._oldSceneGo, uv0._sceneGo)
	end)
end

function slot0._startFade(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot2:GetComponent(typeof(UnityEngine.Animator)).enabled = false

	gohelper.setAsLastSibling(slot1)

	slot0._oldSceneGoAnim = slot1
	slot0._newSceneGoAnim = slot2
	slot0._oldMats = slot0:_collectMats(slot1)
	slot0._newMats = slot0:_collectMats(slot2)

	slot0:_frameUpdateNew(0)
	slot0:_fadeOld()
	TaskDispatcher.runDelay(slot0._fadeNew, slot0, 0.5)
end

function slot0._fadeOld(slot0)
	ZProj.TweenHelper.DOTweenFloat(1, 0, 2, slot0._frameUpdateOld, slot0._fadeInFinishOld, slot0)
end

function slot0._fadeNew(slot0)
	ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, slot0._frameUpdateNew, slot0._fadeInFinishNew, slot0)
end

function slot0._collectMats(slot0, slot1)
	slot2 = {}

	for slot7 = 0, slot1:GetComponentsInChildren(typeof(UnityEngine.Renderer)).Length - 1 do
		table.insert(slot2, slot3[slot7].material)
	end

	return slot2
end

function slot0._updateMatAlpha(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot7:HasProperty("_MainCol") then
			slot8 = slot7:GetColor("_MainCol")
			slot8.a = slot2

			slot7:SetColor("_MainCol", slot8)
		end
	end
end

function slot0._frameUpdateNew(slot0, slot1)
	slot0:_updateMatAlpha(slot0._newMats, slot1)
end

function slot0._fadeInFinishNew(slot0, slot1)
	slot0:_updateMatAlpha(slot0._newMats, 1)

	slot0._newSceneGoAnim = nil
end

function slot0._frameUpdateOld(slot0, slot1)
	slot0:_updateMatAlpha(slot0._oldMats, slot1)
end

function slot0._fadeInFinishOld(slot0, slot1)
	if slot0._oldSceneGoAnim then
		gohelper.destroy(slot0._oldSceneGoAnim)

		slot0._oldSceneGoAnim = nil
	end
end

function slot0._initCanvas(slot0)
	slot0._sceneCanvasGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot0._canvasUrl):GetResource(slot0._canvasUrl), slot0._sceneGo)
	slot0._sceneCanvas = slot0._sceneCanvasGo:GetComponent("Canvas")
	slot0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
end

function slot0._initScene(slot0)
	slot0._mapSize = gohelper.findChild(slot0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size
	slot3 = nil
	slot5 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot6 = slot5[1]
	slot7 = slot5[3]
	slot0._viewWidth = math.abs(slot7.x - slot6.x)
	slot0._viewHeight = math.abs(slot7.y - slot6.y)
	slot0._mapMinX = slot6.x - (slot0._mapSize.x - slot0._viewWidth)
	slot0._mapMaxX = slot6.x
	slot0._mapMinY = slot6.y
	slot0._mapMaxY = slot6.y + slot0._mapSize.y - slot0._viewHeight

	if slot0._oldScenePos then
		slot0._sceneTrans.localPosition = slot0._oldScenePos
	end

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

	if slot0._oldMapLoader then
		slot0._oldMapLoader:dispose()

		slot0._oldMapLoader = nil
	end

	if slot0._oldSceneGo then
		gohelper.destroy(slot0._oldSceneGo)

		slot0._oldSceneGo = nil
	end
end

function slot0.onOpen(slot0)
	slot0._mapId = MeilanniModel.instance:getCurMapId()
	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)

	slot0:addEventCb(MainController.instance, MainEvent.OnSceneClose, slot0._onSceneClose, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, slot0._episodeInfoUpdate, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, slot0._resetMap, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:_initCamera()
	slot0:_showMap()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.DungeonMapView then
		slot0:_initCamera()
	end
end

function slot0._resetMap(slot0)
	slot0:_showMap()
end

function slot0._episodeInfoUpdate(slot0)
	MeilanniAnimationController.instance:addDelayCall(slot0._showMap, slot0, nil, MeilanniEnum.changeMapTime, MeilanniAnimationController.changeMapLayer)
end

function slot0._onScreenResize(slot0)
	CameraMgr.instance:getMainCamera().orthographicSize = MeilanniEnum.orthographicSize * GameUtil.getAdapterScale()
end

function slot0._onSceneClose(slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:_resetCamera()
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._sceneRoot)
	slot0:disposeOldMap()

	if slot0._mapLoader then
		slot0._mapLoader:dispose()
	end
end

return slot0
