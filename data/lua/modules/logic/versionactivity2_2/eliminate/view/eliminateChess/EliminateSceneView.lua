module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateSceneView", package.seeall)

slot0 = class("EliminateSceneView", BaseView)

function slot0.onOpen(slot0)
	slot1 = CameraMgr.instance:getSceneRoot()

	transformhelper.setLocalPos(slot1.transform, 0, 0, 0)

	slot0._sceneRoot = UnityEngine.GameObject.New(slot0.__cname)

	slot0:beforeLoadScene()
	gohelper.addChild(slot1, slot0._sceneRoot)
	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, 5, 0)
	MainCameraMgr.instance:addView(slot0.viewName, slot0._initCamera, nil, slot0)

	slot0._loader1 = PrefabInstantiate.Create(slot0._eliminateSceneGo)

	slot0._loader1:startLoad(slot0:getEliminateScenePath(), slot0._onEliminateSceneLoadEnd, slot0)

	slot0._loader2 = PrefabInstantiate.Create(slot0._teamChessGo)

	slot0._loader2:startLoad(slot0:getTeamChessScenePath(), slot0._onTeamChessSceneLoadEnd, slot0)
end

function slot0.beforeLoadScene(slot0)
	slot0._sceneTrans = slot0._sceneRoot.transform
	slot0._unitContainer = gohelper.create3d(slot0._sceneRoot, "Unit")
	slot0._unitPosition = slot0._unitContainer.transform.position
	slot0._unitEffectContainer = gohelper.create3d(slot0._sceneRoot, "UnitEffect")

	TeamChessEffectPool.setPoolContainerGO(slot0._unitEffectContainer)
	slot0:_initCanvas()
	transformhelper.setLocalPos(slot0._unitContainer.transform, 0, 0, 0)

	slot0._eliminateSceneGo = gohelper.create3d(slot0._sceneRoot, "EliminateScene")
	slot0._teamChessGo = gohelper.create3d(slot0._sceneRoot, "TeamChessScene")

	slot0:updateSceneState()
end

function slot0.setGoPosZ(slot0, slot1, slot2)
	slot3, slot4, slot5 = transformhelper.getPos(slot1.transform)

	transformhelper.setPos(slot1.transform, slot3, slot4, slot2)
end

function slot0.getTeamChessScenePath(slot0)
	return EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig().chessScene
end

function slot0.getEliminateScenePath(slot0)
	return EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig().eliminateScene
end

function slot0._onEliminateSceneLoadEnd(slot0)
	slot1 = slot0._loader1:getInstGO()

	transformhelper.setLocalPos(slot1.transform, 0, 0.8, 0)
	slot0:setGoPosZ(slot1, 1)
end

function slot0._onTeamChessSceneLoadEnd(slot0)
	slot1 = slot0._loader2:getInstGO()

	transformhelper.setLocalPos(slot1.transform, 0, 0.8, 0)

	slot2, slot3, slot4 = transformhelper.getPos(slot1.transform)

	transformhelper.setPos(slot1.transform, slot2, slot3, 1)
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot2 = CameraMgr.instance:getMainCameraTrs()

	transformhelper.setLocalRotation(slot2, 0, 0, 0)
	transformhelper.setLocalPos(slot2, 0, 0, 0)

	slot1.orthographic = true
	slot1.orthographicSize = 5 * GameUtil.getAdapterScale(true)
	slot1.nearClipPlane = 0.3
	slot1.farClipPlane = 1500
end

function slot0.setSceneVisible(slot0, slot1)
	gohelper.setActive(slot0._sceneRoot, slot1)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemBeginDrag, slot0.soliderItemDragBegin, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDrag, slot0.soliderItemDrag, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragEnd, slot0.soliderItemDragEnd, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.RefreshStronghold3DChess, slot0.refreshStronghold3DChess, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.RemoveStronghold3DChess, slot0.removeStronghold3DChess, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.HideAllStronghold3DChess, slot0.hideAllStronghold3DChess, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.ShowChessEffect, slot0.showEffect, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, slot0.updateViewState, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, slot0.updateSceneState, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessViewWatchView, slot0.updateTeamChessViewWatchState, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.updateSceneState(slot0)
	slot2 = EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess

	if slot0._eliminateSceneGo then
		gohelper.setActive(slot0._eliminateSceneGo, slot1 == EliminateEnum.RoundType.Match3Chess)
	end

	if slot0._teamChessGo then
		gohelper.setActive(slot0._teamChessGo, slot2)
	end

	if slot3 then
		slot0:updateViewState()
	end
end

slot1 = Vector2.zero

function slot0.soliderItemDragBegin(slot0, slot1, slot2, slot3)
	slot4 = TeamChessUnitEntityMgr.instance:getEmptyEntity(slot0._unitContainer, slot1)
	uv0.y = slot3
	uv0.x = slot2

	slot4:setScreenPoint(uv0)
	slot4:setUnitParentPosition(slot0._unitPosition)
	slot4:updateByScreenPos()
	slot4:setActive(true)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemBeginModelUpdated, slot1, slot2, slot3)
end

function slot0.soliderItemDrag(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = TeamChessUnitEntityMgr.instance:getEmptyEntity(slot0._unitContainer, slot1)
	uv0.y = slot5
	uv0.x = slot4

	slot6:setScreenPoint(uv0)
	slot6:setUnitParentPosition(slot0._unitPosition)
	slot6:updateByScreenPos()
	slot6:setActive(true)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragModelUpdated, slot1, slot2, slot3, slot4, slot5)
end

function slot0.soliderItemDragEnd(slot0, slot1, slot2, slot3, slot4, slot5)
	TeamChessUnitEntityMgr.instance:getEmptyEntity(slot0._unitContainer, slot1):setActive(false)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEndModelUpdated, slot1, slot2, slot3, slot4, slot5)
end

function slot0.refreshStronghold3DChess(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == nil then
		return
	end

	if slot0.teamChessUnitMoList == nil then
		slot0.teamChessUnitMoList = {}
		slot0.teamChessUnitItem = {}
	end

	slot6 = slot1.uid
	slot8 = TeamChessUnitEntityMgr.instance:getEntity(slot6)

	if slot0.teamChessUnitMoList[slot6] ~= nil then
		slot7:update(slot1.uid, slot1.id, slot2, slot3, slot1.teamType)
	else
		slot7 = TeamChessUnitMO.New()

		slot7:init(slot1.uid, slot1.id, slot2, slot3, slot1.teamType)

		slot8 = TeamChessUnitEntityMgr.instance:addEntity(slot7, slot0._unitContainer)
	end

	if canLogNormal then
		logNormal("EliminateSceneView==>refreshStronghold3DChess--1", slot1.uid)
	end

	if slot8 ~= nil then
		slot8:refreshTransform(slot4, slot0._unitPosition)
		slot8:setCanClick(true)
		slot8:setCanDrag(true)
		slot8:setActive(true)
		slot8:refreshMeshOrder()
	end

	slot0.teamChessUnitMoList[slot1.uid] = slot7
end

function slot0.removeStronghold3DChess(slot0, slot1)
	if slot0.teamChessUnitMoList == nil then
		return
	end

	slot0.teamChessUnitMoList[slot1] = nil

	TeamChessUnitEntityMgr.instance:removeEntity(slot1)
end

function slot0.hideAllStronghold3DChess(slot0)
	TeamChessUnitEntityMgr.instance:setAllEntityActive(false)
end

function slot0.updateViewState(slot0)
	TeamChessUnitEntityMgr.instance:setAllEntityActiveAndPlayAni(EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess)
	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(slot1 == EliminateEnum.RoundType.TeamChess)
	TeamChessUnitEntityMgr.instance:setAllEmptyEntityActive(false)
end

function slot0.updateTeamChessViewWatchState(slot0, slot1)
	if slot1 then
		TeamChessUnitEntityMgr.instance:cacheAllEntityShowMode()
		TeamChessUnitEntityMgr.instance:setAllEntityNormal()
	else
		TeamChessUnitEntityMgr.instance:restoreEntityShowMode()
	end

	TeamChessUnitEntityMgr.instance:setAllEntityActiveAndPlayAni(slot1)
	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(slot1)

	if slot0._eliminateSceneGo then
		gohelper.setActive(slot0._eliminateSceneGo, not slot1)
	end

	if slot0._teamChessGo then
		gohelper.setActive(slot0._teamChessGo, slot1)
	end
end

function slot0.onOpenFinish(slot0)
	if slot0._sceneGo then
		slot0:calcSceneBoard()
	end
end

function slot0._onScreenResize(slot0)
	if slot0._sceneGo then
		slot0:calcSceneBoard()
	end

	slot0:calCanvasWidthAndHeight()
end

function slot0.calcSceneBoard(slot0)
	if not slot0._sceneGo then
		return
	end

	if not gohelper.findChild(slot0._sceneGo, "BackGround/size") then
		return
	end

	if not slot1:GetComponentInChildren(typeof(UnityEngine.BoxCollider)) then
		return
	end

	slot0._mapSize = slot2.size
	slot3 = nil
	slot5 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot6 = slot5[1] * slot4
	slot7 = slot5[3] * slot4
	slot0._viewWidth = math.abs(slot7.x - slot6.x)
	slot0._viewHeight = math.abs(slot7.y - slot6.y)
	slot8 = 5.8
	slot9 = slot2.center
	slot0._mapMinX = slot6.x - (slot0._mapSize.x / 2 - slot0._viewWidth) - slot9.x
	slot0._mapMaxX = slot6.x + slot0._mapSize.x / 2 - slot9.x
	slot0._mapMinY = slot6.y - slot0._mapSize.y / 2 + slot8 - slot9.y
	slot0._mapMaxY = slot6.y + slot0._mapSize.y / 2 - slot0._viewHeight + slot8 - slot9.y
	CameraMgr.instance:getMainCamera().orthographicSize = 5 * GameUtil.getAdapterScale(true)
end

function slot0.calCanvasWidthAndHeight(slot0)
	if slot0._sceneCanvasGo == nil then
		return
	end

	slot2 = gohelper.find("POPUP_TOP").transform
	slot3 = recthelper.getWidth(slot2)
	slot4 = recthelper.getHeight(slot2)

	recthelper.setSize(slot0._sceneCanvasGo.transform, slot3, slot4)
	recthelper.setSize(slot0._sceneTipCanvasGo.transform, slot3, slot4)

	if gohelper.findChild(slot0._sceneCanvasGo, "#go_cameraMain") ~= nil then
		recthelper.setSize(slot5.transform, slot3, slot4)
	end
end

function slot0._initCanvas(slot0)
	slot0._sceneCanvasGo = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[4], slot0._sceneRoot)
	slot0._sceneCanvas = slot0._sceneCanvasGo:GetComponent("Canvas")
	slot0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	slot0._sceneCanvas.sortingOrder = -1
	slot0._sceneTipCanvasGo = gohelper.clone(slot0._sceneCanvasGo, slot0._sceneRoot, "SceneTipCanvas")
	slot0._sceneTipCanvas = slot0._sceneTipCanvasGo:GetComponent("Canvas")
	slot0._sceneTipCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	slot0._sceneTipCanvas.sortingOrder = 30

	slot0.viewContainer:setTeamChessViewParent(slot0._sceneCanvasGo, slot0._sceneCanvas)
	slot0.viewContainer:setTeamChessTipViewParent(slot0._sceneTipCanvasGo, slot0._sceneTipCanvas)
	transformhelper.setPosXY(slot0._sceneCanvasGo.transform, 0, 0.8798389)
	transformhelper.setPosXY(slot0._sceneTipCanvasGo.transform, 0, 0.8798389)
end

function slot0.showEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = TeamChessEffectPool.getEffect(slot1, slot0._onEffectLoadEnd, slot0)

	slot9:setWorldPos(slot2, slot3, slot4)
	slot9:setWorldScale(slot5 or 1, slot6 or 1, slot7 or 1)
	slot9:play(slot8)
end

function slot0.onDestroyView(slot0)
	if slot0.teamChessUnitMoList then
		tabletool.clear(slot0.teamChessUnitMoList)

		slot0.teamChessUnitMoList = nil
	end

	if slot0._eliminateSceneGo then
		slot0._eliminateSceneGo = nil
	end

	if slot0._teamChessGo then
		slot0._teamChessGo = nil
	end

	if slot0._sceneTipCanvasGo then
		slot0._sceneTipCanvas = nil
		slot0._sceneTipCanvasGo = nil
	end

	if slot0._sceneCanvasGo then
		slot0._sceneCanvas = nil
		slot0._sceneCanvasGo = nil
	end

	slot0._unitContainer = nil
	slot0._unitEffectContainer = nil

	if slot0._loader1 then
		slot0._loader1:dispose()

		slot0._loader1 = nil
	end

	if slot0._loader2 then
		slot0._loader2:dispose()

		slot0._loader2 = nil
	end

	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

return slot0
