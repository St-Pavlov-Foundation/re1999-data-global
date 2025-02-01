module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelScene", package.seeall)

slot0 = class("TianShiNaNaLevelScene", TianShiNaNaBaseSceneView)

function slot0.onInitView(slot0)
end

function slot0.getScenePath(slot0)
	return TianShiNaNaModel.instance.mapCo.path
end

function slot0.beforeLoadScene(slot0)
	slot0._sceneTrans = slot0._sceneRoot.transform
	slot0._nodeContainer = gohelper.create3d(slot0._sceneRoot, "Node")
	slot0._unitContainer = gohelper.create3d(slot0._sceneRoot, "Unit")

	transformhelper.setLocalPos(slot0._nodeContainer.transform, 0, 0, 1)
	slot0:_initNodeAndUnit()
end

function slot0.addEvents(slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, slot0._resetScene, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.DragScene, slot0._onDragScene, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.CheckMapCollapse, slot0._checkMapCollapse, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.PlayerMove, slot0._onPlayerMove, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, slot0._resetScene, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.DragScene, slot0._onDragScene, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.CheckMapCollapse, slot0._checkMapCollapse, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.PlayerMove, slot0._onPlayerMove, slot0)
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7 * GameUtil.getAdapterScale(true)
end

function slot0.onSceneLoaded(slot0, slot1)
	slot0._sceneGo = slot1

	slot0:calcSceneBoard()
	slot0:autoFocusPlayer()
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.LoadLevelFinish, slot1)
end

function slot0._onScreenResize(slot0)
	if slot0._sceneGo then
		slot0:calcSceneBoard()
	end
end

function slot0.calcSceneBoard(slot0)
	slot0._mapMinX = -10
	slot0._mapMaxX = 10
	slot0._mapMinY = -10
	slot0._mapMaxY = 10

	if not slot0._sceneGo then
		return
	end

	if not gohelper.findChild(slot0._sceneGo, "BackGround/size") then
		return
	end

	if not slot1:GetComponentInChildren(typeof(UnityEngine.BoxCollider)) then
		return
	end

	slot3 = slot1.transform.lossyScale
	slot0._mapSize = slot2.size
	slot0._mapSize.x = slot0._mapSize.x * slot3.x
	slot0._mapSize.y = slot0._mapSize.y * slot3.y
	slot4 = nil
	slot5 = slot5 * 7 / 5
	slot6 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot7 = slot6[1] * slot5
	slot8 = slot6[3] * slot5
	slot0._viewWidth = math.abs(slot8.x - slot7.x)
	slot0._viewHeight = math.abs(slot8.y - slot7.y)
	slot9 = 5.8
	slot10 = slot2.center
	slot0._mapMinX = slot7.x - (slot0._mapSize.x / 2 - slot0._viewWidth) - slot10.x
	slot0._mapMaxX = slot7.x + slot0._mapSize.x / 2 - slot10.x
	slot0._mapMinY = slot7.y - slot0._mapSize.y / 2 + slot9 - slot10.y
	slot0._mapMaxY = slot7.y + slot0._mapSize.y / 2 - slot0._viewHeight + slot9 - slot10.y
end

function slot0.autoFocusPlayer(slot0)
	slot2 = -TianShiNaNaHelper.nodeToV3(TianShiNaNaModel.instance:getHeroMo())
	slot2.y = slot2.y + 5.8
	slot2.z = 0

	slot0:setScenePosSafety(slot2)
end

slot1 = Vector3()

function slot0._onDragScene(slot0, slot1)
	if not slot0._targetPos then
		return
	end

	slot2 = CameraMgr.instance:getMainCamera()
	slot5 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot1.position, slot2, uv0) - SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot1.position - slot1.delta, slot2, uv0)
	slot5.z = 0

	slot0:setScenePosSafety(slot0._targetPos:Add(slot5))
end

function slot0._onPlayerMove(slot0, slot1)
	slot2 = -slot1
	slot2.y = slot2.y + 5.8
	slot2.z = 0

	slot0:setScenePosSafety(slot2)
end

function slot0.setScenePosSafety(slot0, slot1)
	if not slot0._mapMinX then
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
	slot0._sceneTrans.localPosition = slot1
	TianShiNaNaModel.instance.nowScenePos = slot1
end

function slot0._initNodeAndUnit(slot0)
	TianShiNaNaEntityMgr.instance:clear()

	slot0._mapCo = TianShiNaNaModel.instance.mapCo

	slot0:_initNode()

	for slot4, slot5 in pairs(TianShiNaNaModel.instance.unitMos) do
		TianShiNaNaEntityMgr.instance:addEntity(slot5, slot0._unitContainer)
	end
end

function slot0._initNode(slot0)
	for slot4, slot5 in pairs(slot0._mapCo.nodesDict) do
		for slot9, slot10 in pairs(slot5) do
			if not slot10:isCollapse() then
				TianShiNaNaEntityMgr.instance:addNode(slot10, slot0._nodeContainer)
			else
				TianShiNaNaEntityMgr.instance:removeNode(slot10)
			end
		end
	end
end

function slot0._checkMapCollapse(slot0)
	for slot4, slot5 in pairs(TianShiNaNaModel.instance.unitMos) do
		if not TianShiNaNaModel.instance.mapCo:getNodeCo(slot5.x, slot5.y) or slot6:isCollapse() then
			TianShiNaNaModel.instance:removeUnit(slot4)
		end
	end

	slot0:_initNode()
end

function slot0._resetScene(slot0)
	for slot4, slot5 in pairs(TianShiNaNaModel.instance.unitMos) do
		TianShiNaNaEntityMgr.instance:addEntity(slot5, slot0._unitContainer)
	end

	slot0:_initNode()
end

function slot0.onDestroyView(slot0)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ExitLevel)
	TianShiNaNaEntityMgr.instance:clear()
	uv0.super.onDestroyView(slot0)
end

return slot0
