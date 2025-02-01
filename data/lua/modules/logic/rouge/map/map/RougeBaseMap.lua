module("modules.logic.rouge.map.map.RougeBaseMap", package.seeall)

slot0 = class("RougeBaseMap", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0._createDoneFinish = false
	slot0._openViewFinish = ViewMgr.instance:isOpenFinish(ViewName.RougeMapView)

	RougeMapTipPopController.instance:init()
	RougeMapVoiceTriggerController.instance:init()

	slot0.mapGo = slot1

	slot0:initMap()
	slot0:createMapNodeContainer()
	RougeMapController.instance:registerMap(slot0)

	slot0.mapItemList = {}
	slot0.mapItemDict = {}

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.triggerInteract, slot0.onTriggerInteract, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onCreateMapDone, slot0.onCreateMapDone, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0.onScreenSizeChanged, slot0)
end

function slot0.onScreenSizeChanged(slot0)
	slot0:updateCameraSize()
end

function slot0.updateCameraSize(slot0)
	RougeMapModel.instance:setCameraSize(slot0:getCameraSize())
	RougeMapController.instance:dispatchEvent(RougeMapEvent.focusChangeCameraSize)
end

function slot0.getCameraSize(slot0)
	return RougeMapModel.instance:getCameraSize()
end

function slot0.initMap(slot0)
	slot0.mapTransform = slot0.mapGo.transform

	RougeMapModel.instance:setMapSize(gohelper.findChild(slot0.mapGo, "root/size"):GetComponent(typeof(UnityEngine.BoxCollider)).size)
end

function slot0.createMapNodeContainer(slot0)
	slot0.goLayerPiecesContainer = gohelper.create3d(slot0.mapGo, "layerPiecesContainer")
	slot0.trLayerPiecesContainer = slot0.goLayerPiecesContainer.transform

	transformhelper.setLocalPos(slot0.goLayerPiecesContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PiecesContainer)
end

function slot0.handleOtherRes(slot0, slot1)
end

function slot0.handleDLCRes(slot0, slot1, slot2)
end

function slot0.createMap(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCreateMapDone)
end

function slot0.onCreateMapDone(slot0)
	slot0._createDoneFinish = true

	slot0:startCreateMapDoneFlow()
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.RougeMapView then
		slot0._openViewFinish = true

		slot0:startCreateMapDoneFlow()
	end
end

function slot0.startCreateMapDoneFlow(slot0)
	if not slot0._createDoneFinish or not slot0._openViewFinish then
		return
	end

	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.WaitFlow)

	slot0.onCreateMapDoneFlow = FlowSequence.New()

	slot0:addStoryFlow()
	slot0.onCreateMapDoneFlow:addWork(WaitPopViewDoneWork.New())
	slot0.onCreateMapDoneFlow:addWork(WaitRougeInteractDoneWork.New())
	slot0.onCreateMapDoneFlow:addWork(WaitRougeCollectionEffectDoneWork.New())
	slot0.onCreateMapDoneFlow:addWork(WaitRougeNodeChangeAnimDoneWork.New())
	slot0.onCreateMapDoneFlow:addWork(WaitRougeActorMoveToEndDoneWork.New())
	slot0.onCreateMapDoneFlow:registerDoneListener(slot0.onCreateMapDoneFlowDone, slot0)
	slot0.onCreateMapDoneFlow:start()
end

function slot0.addStoryFlow(slot0)
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	if RougeMapModel.instance:getLayerCo().startStoryId == 0 then
		return
	end

	if StoryModel.instance:isStoryFinished(slot2) then
		return
	end

	slot0.onCreateMapDoneFlow:addWork(WaitRougeStoryDoneWork.New(slot2))
end

function slot0.onCreateMapDoneFlowDone(slot0)
	slot0:clearFlow()
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.Normal)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCreateMapDoneFlowDone)

	if RougeMapModel.instance:isNormalLayer() then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.OnGuideEnterNormalRougeMap)
	elseif RougeMapModel.instance:isMiddle() then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.OnGuideEnterMiddleRougeMap)
	end
end

function slot0.onTriggerInteract(slot0)
	RougeMapInteractHelper.triggerInteractive()
end

function slot0.getMapItemList(slot0)
	return slot0.mapItemList
end

function slot0.addMapItem(slot0, slot1)
	table.insert(slot0.mapItemList, slot1)

	slot0.mapItemDict[slot1.id] = slot1
end

function slot0.addMapItemList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:addMapItem(slot6)
	end
end

function slot0.getMapItem(slot0, slot1)
	return slot0.mapItemDict[slot1]
end

function slot0.getActorComp(slot0)
	return slot0.actorComp
end

function slot0.getActorPos(slot0)
end

function slot0.clearFlow(slot0)
	if slot0.onCreateMapDoneFlow then
		slot0.onCreateMapDoneFlow:destroy()
	end

	slot0.onCreateMapDoneFlow = nil
end

function slot0.destroy(slot0)
	slot4 = slot0.onScreenSizeChanged
	slot5 = slot0

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot4, slot5)

	for slot4, slot5 in ipairs(slot0.mapItemList) do
		slot5:destroy()
	end

	slot0.mapItemList = nil
	slot0.mapItemDict = nil

	if slot0.actorComp then
		slot0.actorComp:destroy()
	end

	slot0:clearFlow()
	RougeMapController.instance:unregisterMap()
	slot0:__onDispose()
end

return slot0
